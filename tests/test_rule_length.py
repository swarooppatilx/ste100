from src.pipeline import analyze
from src.rules.rule_length import SentenceLengthRule

PROCEDURAL_LIMIT = SentenceLengthRule(max_words=20, rule_id="5.1")
DESCRIPTIVE_LIMIT = SentenceLengthRule(max_words=25, rule_id="6.3")

LONG_PROCEDURAL = (
    "Remove the old filter and install the new filter with the correct torque on "
    "the pump housing before you continue the test procedure again."
)
SHORT_PROCEDURAL = "Remove the old filter and install the new filter with the correct torque."
LONG_DESCRIPTIVE = (
    "A good inspection procedure must include a complete check of the pump and the "
    "filter before the system is connected to the main power supply again."
)
SHORT_DESCRIPTIVE = (
    "A good inspection procedure must include a complete check of the pump and the "
    "filter before the system is connected to the main power supply."
)


def test_procedural_limit_flagged():
    hits = PROCEDURAL_LIMIT.check(analyze(LONG_PROCEDURAL))
    assert len(hits) == 1
    assert hits[0].rule_id == "5.1"


def test_procedural_limit_passes():
    assert PROCEDURAL_LIMIT.check(analyze(SHORT_PROCEDURAL)) == []


def test_descriptive_limit_flagged():
    hits = DESCRIPTIVE_LIMIT.check(analyze(LONG_DESCRIPTIVE))
    assert len(hits) == 1
    assert hits[0].rule_id == "6.3"


def test_descriptive_limit_passes():
    assert DESCRIPTIVE_LIMIT.check(analyze(SHORT_DESCRIPTIVE)) == []


def test_short_sentence_not_flagged_by_descriptive_rule():
    assert DESCRIPTIVE_LIMIT.check(analyze(SHORT_PROCEDURAL)) == []
