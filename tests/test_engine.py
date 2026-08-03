import pytest

from src.engine import Rule, RuleEngine, Violation
from src.pipeline import analyze


class DummyRule(Rule):
    rule_id = "dummy"
    description = "flags every token"

    def check(self, doc):
        return [Violation(self.rule_id, token.i, token.i + 1, "flagged") for token in doc]


@pytest.fixture(scope="module")
def doc():
    return analyze("Remove the filter.")


def test_run_collects_violations(doc):
    engine = RuleEngine([DummyRule()])
    violations = engine.run(doc)
    assert len(violations) == len(doc)
    assert all(v.rule_id == "dummy" for v in violations)


def test_default_engine_returns_nothing(doc):
    assert RuleEngine().run(doc) == []


def test_duplicate_registration_raises():
    engine = RuleEngine()
    engine.register(DummyRule())
    with pytest.raises(ValueError):
        engine.register(DummyRule())
