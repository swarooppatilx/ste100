from src.pipeline import analyze
from src.rules.rule_passive import PassiveRule

RULE = PassiveRule()


def test_simple_passive_flagged():
    hits = RULE.check(analyze("The valve is opened by the crew."))
    assert len(hits) == 1
    assert hits[0].message == 'passive voice: "is opened"'


def test_compound_passive_flagged():
    hits = RULE.check(analyze("The filter has been cleaned."))
    assert len(hits) == 1
    assert hits[0].message == 'passive voice: "has been cleaned"'


def test_past_tense_passive_flagged():
    hits = RULE.check(analyze("The pump was removed."))
    assert len(hits) == 1
    assert "was removed" in hits[0].message


def test_active_voice_passes():
    assert RULE.check(analyze("Open the valve.")) == []


def test_multiple_passives_flagged():
    hits = RULE.check(analyze("The door was opened and the filter was removed."))
    assert len(hits) == 2


def test_passive_span_stays_in_clause():
    hits = RULE.check(analyze("The valve has been opened before the system was checked."))
    messages = [hit.message for hit in hits]
    assert 'passive voice: "has been opened"' in messages
    assert 'passive voice: "was checked"' in messages
    assert not any("opened was" in message for message in messages)
