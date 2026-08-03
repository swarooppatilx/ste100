from src.pipeline import analyze
from src.rules.rule_l1_pos import PosRule

RULE = PosRule()


def test_test_as_verb_is_flagged():
    doc = analyze("Test the valve.")
    hits = [v for v in RULE.check(doc) if v.message.startswith('"Test"')]
    assert len(hits) == 1
    assert hits[0].suggestion == 'use "test" only as a noun'


def test_approved_pos_usage_not_flagged():
    doc = analyze("Perform the test.")
    assert RULE.check(doc) == []


def test_start_as_noun_is_flagged():
    doc = analyze("The start of the engine.")
    hits = [v for v in RULE.check(doc) if v.message.startswith('"start"')]
    assert len(hits) == 1


def test_auxiliary_usage_not_flagged():
    doc = analyze("We have removed the filter.")
    assert not any("have" in v.message for v in RULE.check(doc))


def test_infinitive_to_not_flagged():
    doc = analyze("Use the wrench to remove the part.")
    assert RULE.check(doc) == []


def test_proper_nouns_skipped():
    doc = analyze("Examine the Boeing part.")
    assert RULE.check(doc) == []
