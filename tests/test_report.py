import json

from src.pipeline import analyze
from src.report import build_report, render_json, render_text
from src.rules.rule_l1_words import WordRule

RULE = WordRule()


def test_build_report_counts():
    doc = analyze("Utilize the wrench. Remove the filter.")
    report = build_report(doc, RULE.check(doc))
    assert report.words == 6
    assert report.sentences == 2


def test_build_report_spans_match_violations():
    doc = analyze("Utilize the wrench.")
    violations = RULE.check(doc)
    report = build_report(doc, violations)
    assert len(report.violations) == len(report.spans) == 1
    assert report.spans[0] == "Utilize"


def test_render_json_round_trip():
    doc = analyze("Utilize the wrench.")
    report = build_report(doc, RULE.check(doc))
    data = json.loads(render_json(report))
    assert data["total"] == 1
    assert data["words"] == 3
    assert data["sentences"] == 1
    assert data["violations"][0]["rule"] == "1.1"
    assert data["violations"][0]["suggestion"] == "use"


def test_render_text_contains_message_and_suggestion():
    doc = analyze("Utilize the wrench.")
    report = build_report(doc, RULE.check(doc))
    text = render_text(report)
    assert '"Utilize" is not an approved word' in text
    assert "suggestion: use" in text
    assert "Violations: 1" in text


def test_empty_report():
    doc = analyze("Remove the filter.")
    report = build_report(doc, RULE.check(doc))
    assert report.violations == []
    assert render_text(report) != ""
