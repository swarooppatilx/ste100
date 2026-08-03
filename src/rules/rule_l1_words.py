from spacy.tokens import Doc

from src.dictionary import Dictionary
from src.engine import Rule, Violation


class WordRule(Rule):
    rule_id = "1.1"
    description = "Flag unapproved and unknown words"

    def __init__(self, dictionary: Dictionary | None = None) -> None:
        self._dictionary = dictionary or Dictionary()

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for token in doc:
            if self._is_skippable(token):
                continue
            violations.extend(self._check_token(token))
        return violations

    def _is_skippable(self, token) -> bool:
        return (
            token.is_punct
            or token.is_space
            or token.like_num
            or not token.is_alpha
            or token.pos_ == "PROPN"
        )

    def _check_token(self, token) -> list[Violation]:
        lower = token.lower_
        if self._dictionary.is_unapproved(lower):
            alternatives = ", ".join(self._dictionary.alternative(lower))
            return [
                Violation(
                    rule_id=self.rule_id,
                    start=token.idx,
                    end=token.idx + len(token.text),
                    message=f'"{token.text}" is not an approved word',
                    suggestion=alternatives,
                )
            ]
        if not self._dictionary.is_known(token.lemma_.lower()):
            return [
                Violation(
                    rule_id=self.rule_id,
                    start=token.idx,
                    end=token.idx + len(token.text),
                    message=f'"{token.text}" is not in the approved or technical dictionary',
                )
            ]
        return []
