from spacy.tokens import Doc

from src.engine import Rule, Violation


class SemicolonRule(Rule):
    rule_id = "8.1"
    description = "Flag semicolons"

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for token in doc:
            if token.text == ";":
                violations.append(
                    Violation(
                        rule_id=self.rule_id,
                        start=token.idx,
                        end=token.idx + 1,
                        message="semicolons are not allowed",
                        suggestion="split the sentence or use a full stop",
                    )
                )
        return violations
