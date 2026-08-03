from src.pipeline import analyze
from src.rules.rule_l1_words import WordRule

RULE = WordRule()


def test_flags_unapproved_word_with_suggestion():
    doc = analyze("Utilize the wrench.")
    hits = [v for v in RULE.check(doc) if "Utilize" in v.message]
    assert len(hits) == 1
    assert hits[0].rule_id == "1.1"
    assert hits[0].suggestion == "use"


def test_flags_unknown_word():
    doc = analyze("Install the accumulator before use.")
    hits = [v for v in RULE.check(doc) if "accumulator" in v.message]
    assert len(hits) == 1
    assert hits[0].suggestion is None


def test_inflected_approved_words_not_flagged():
    doc = analyze("Remove the filters carefully.")
    assert RULE.check(doc) == []


def test_technical_words_not_flagged():
    doc = analyze("Install the actuator.")
    assert RULE.check(doc) == []


def test_proper_nouns_not_flagged():
    doc = analyze("Boeing makes aircraft.")
    assert RULE.check(doc) == []
