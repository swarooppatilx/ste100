from src.pipeline import analyze
from src.rules.rule_verb_tense import IngRule, VerbTenseRule

TENSE_RULE = VerbTenseRule()
ING_RULE = IngRule()


def test_perfect_tense_flagged():
    hits = TENSE_RULE.check(analyze("We have removed the filter."))
    assert len(hits) == 1
    assert hits[0].rule_id == "3.2"
    assert hits[0].message == 'perfect tense: "have removed"'


def test_progressive_tense_flagged():
    hits = TENSE_RULE.check(analyze("We are removing the filter."))
    assert len(hits) == 1
    assert hits[0].rule_id == "3.2"
    assert "progressive" in hits[0].message


def test_modal_passive_flagged():
    hits = TENSE_RULE.check(analyze("The valve will be removed."))
    assert len(hits) == 1
    assert hits[0].rule_id == "3.4"
    assert "modal" in hits[0].message


def test_is_to_be_passive_flagged():
    hits = TENSE_RULE.check(analyze("The valve is to be replaced."))
    assert len(hits) == 1
    assert hits[0].rule_id == "3.4"


def test_simple_present_passes():
    assert TENSE_RULE.check(analyze("Open the valve.")) == []
    assert TENSE_RULE.check(analyze("We opened the valve.")) == []


def test_plain_passive_not_flagged_as_tense():
    hits = TENSE_RULE.check(analyze("The valve is removed."))
    assert hits == []


def test_ing_used_as_verb_flagged():
    hits = [v for v in ING_RULE.check(analyze("The crew is opening the door."))]
    assert len(hits) == 1
    assert hits[0].rule_id == "3.5"


def test_gerund_as_subject_not_flagged():
    hits = ING_RULE.check(analyze("Opening the valve takes time."))
    assert hits == []
