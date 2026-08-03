from spacy.tokens import Doc, Token

from src.engine import Rule, Violation


class NounClusterRule(Rule):
    rule_id = "2.1"
    description = "Flag noun clusters of more than three nouns"

    _NOUN_POS = {"NOUN", "PROPN"}

    def __init__(self, max_nouns: int = 3) -> None:
        self.max_nouns = max_nouns

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for sent in doc.sents:
            violations.extend(self._check_sentence(sent))
        return violations

    def _check_sentence(self, sent) -> list[Violation]:
        violations: list[Violation] = []
        run: list[Token] = []
        for token in sent:
            if token.pos_ in self._NOUN_POS:
                run.append(token)
            else:
                violations.extend(self._flush(run))
                run = []
        violations.extend(self._flush(run))
        return violations

    def _flush(self, run: list[Token]) -> list[Violation]:
        if len(run) <= self.max_nouns:
            return []
        text = " ".join(token.text for token in run)
        return [
            Violation(
                rule_id=self.rule_id,
                start=run[0].idx,
                end=run[-1].idx + len(run[-1].text),
                message=f'noun cluster of {len(run)} nouns: "{text}"',
                suggestion="break the cluster with prepositions or adjectives",
            )
        ]
