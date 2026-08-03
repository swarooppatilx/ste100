from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import Sequence

from spacy.tokens import Doc


@dataclass(frozen=True)
class Violation:
    rule_id: str
    start: int
    end: int
    message: str
    suggestion: str | None = None


class Rule(ABC):
    rule_id: str = ""
    description: str = ""

    @abstractmethod
    def check(self, doc: Doc) -> list[Violation]: ...


class RuleEngine:
    def __init__(self, rules: Sequence[Rule] = ()) -> None:
        self._rules: dict[str, Rule] = {}
        for rule in rules:
            self.register(rule)

    def register(self, rule: Rule) -> None:
        if rule.rule_id in self._rules:
            raise ValueError(f"duplicate rule id: {rule.rule_id}")
        self._rules[rule.rule_id] = rule

    def run(self, doc: Doc) -> list[Violation]:
        violations: list[Violation] = []
        for rule in self._rules.values():
            violations.extend(rule.check(doc))
        return violations
