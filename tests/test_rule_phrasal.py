from src.pipeline import analyze
from src.rules.rule_phrasal import PhrasalVerbRule

RULE = PhrasalVerbRule()


def test_carry_out_flagged():
    hits = RULE.check(analyze("Carry out the inspection."))
    assert len(hits) == 1
    assert hits[0].rule_id == "9.3"
    assert hits[0].message == '"Carry out" is a phrasal verb'
    assert hits[0].suggestion == "do, measure"


def test_turn_on_flagged():
    hits = RULE.check(analyze("Turn on the pump."))
    assert len(hits) == 1
    assert hits[0].suggestion == "start, energize"


def test_inflected_form_flagged():
    hits = RULE.check(analyze("We shut down the engine."))
    assert len(hits) == 1
    assert hits[0].message == '"shut down" is a phrasal verb'


def test_dispose_of_flagged():
    hits = RULE.check(analyze("We dispose of the oil."))
    assert len(hits) == 1
    assert hits[0].suggestion == "remove, discard"


def test_approved_technical_verb_not_flagged():
    assert RULE.check(analyze("Switch on the pump.")) == []


def test_noun_use_not_flagged():
    assert RULE.check(analyze("The back off the seat is damaged.")) == []


def test_plain_sentence_passes():
    assert RULE.check(analyze("Remove the filter.")) == []
