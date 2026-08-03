from spacy.tokens import Doc

from src.dictionary import Dictionary
from src.engine import Rule, Violation


class PosRule(Rule):
    rule_id = "1.2"
    description = "Flag approved words used with the wrong part of speech"

    _allowed = {"VERB": {"VERB", "AUX"}, "ADP": {"ADP", "PART"}}

    def __init__(self, dictionary: Dictionary | None = None) -> None:
        self._dictionary = dictionary or Dictionary()

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for token in doc:
            if self._is_skippable(token):
                continue
            approved_pos = self._dictionary.approved_pos(token.lower_)
            if approved_pos is None:
                continue
            if not self._uses_approved_pos(approved_pos, token.pos_):
                violations.append(self._violation(token, approved_pos))
        return violations

    def _is_skippable(self, token) -> bool:
        return token.is_punct or token.is_space or token.like_num or token.pos_ == "PROPN"

    def _uses_approved_pos(self, approved: str, actual: str) -> bool:
        return actual in self._allowed.get(approved, {approved})

    def _violation(self, token, approved_pos: str) -> Violation:
        return Violation(
            rule_id=self.rule_id,
            start=token.idx,
            end=token.idx + len(token.text),
            message=(
                f'"{token.text}" is approved only as {approved_pos.lower()}; '
                f"it is used here as {token.pos_.lower()}"
            ),
            suggestion=f'use "{token.lower_}" only as a {approved_pos.lower()}',
        )
