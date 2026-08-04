from spacy.matcher import Matcher
from spacy.tokens import Doc

from src.engine import Rule, Violation

_PHRASAL_VERBS = {
    "back off": "back away, loosen",
    "carry out": "do, measure",
    "dispose of": "remove, discard",
    "get away": "leave",
    "get down": "remove, take off",
    "get into": "enter",
    "get off": "leave, remove",
    "get to": "arrive at",
    "hold back": "stop",
    "hold off": "stop",
    "hook up": "connect",
    "rope off": "surround with rope",
    "set up": "install",
    "shut down": "stop",
    "slow down": "slow",
    "take away": "remove",
    "take care": "be careful",
    "take off": "remove",
    "take out": "remove",
    "top off": "add, fill",
    "turn off": "stop",
    "turn on": "start, energize",
    "turn over": "reverse",
}


class PhrasalVerbRule(Rule):
    rule_id = "9.3"
    description = "Flag phrasal verbs that are not approved"

    def __init__(self) -> None:
        self._matcher: Matcher | None = None

    def check(self, doc: Doc) -> list[Violation]:
        matcher = self._matcher or self._build_matcher(doc)
        violations = []
        for _, start, end in matcher(doc):
            if doc[start].pos_ not in {"VERB", "PROPN"}:
                continue
            span = doc[start:end]
            phrase = " ".join(token.lemma_ for token in span)
            violations.append(
                Violation(
                    rule_id=self.rule_id,
                    start=span.start_char,
                    end=span.end_char,
                    message=f'"{span.text}" is a phrasal verb',
                    suggestion=_PHRASAL_VERBS[phrase],
                )
            )
        return violations

    def _build_matcher(self, doc: Doc) -> Matcher:
        matcher = Matcher(doc.vocab)
        for phrase in _PHRASAL_VERBS:
            matcher.add(phrase, [[{"LEMMA": word} for word in phrase.split()]])
        self._matcher = matcher
        return matcher
