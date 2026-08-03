from spacy.tokens import Doc

from src.engine import Rule, Violation


class SentenceLengthRule(Rule):
    description = "Flag sentences that exceed the maximum word count"

    def __init__(self, max_words: int = 20, rule_id: str = "5.1") -> None:
        self.max_words = max_words
        self.rule_id = rule_id

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for sent in doc.sents:
            count = sum(1 for token in sent if not token.is_punct and not token.is_space)
            if count > self.max_words:
                violations.append(
                    Violation(
                        rule_id=self.rule_id,
                        start=sent.start_char,
                        end=sent.end_char,
                        message=f"Sentence has {count} words; maximum is {self.max_words}",
                        suggestion="split the sentence into shorter sentences",
                    )
                )
        return violations
