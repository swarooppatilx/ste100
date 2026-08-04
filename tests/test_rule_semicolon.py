from src.pipeline import analyze
from src.rules.rule_semicolon import SemicolonRule

RULE = SemicolonRule()


def test_flags_semicolon():
    hits = RULE.check(analyze("Remove the filter; then clean it."))
    assert len(hits) == 1
    assert hits[0].rule_id == "8.1"
    assert hits[0].start == 17
    assert hits[0].suggestion is not None


def test_multiple_semicolons_flagged():
    hits = RULE.check(analyze("A; B; C."))
    assert len(hits) == 2


def test_clean_text_passes():
    assert RULE.check(analyze("Remove the filter. Then clean it.")) == []
