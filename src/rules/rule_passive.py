from spacy.tokens import Doc, Token

from src.engine import Rule, Violation


class PassiveRule(Rule):
    rule_id = "3.6"
    description = "Detect passive voice"

    _PASSIVE_DEPS = {"auxpass", "aux", "neg"}

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for token in doc:
            if token.dep_ != "nsubjpass":
                continue
            verb = token.head
            span_tokens = self._passive_span(verb)
            if not span_tokens:
                continue
            violations.append(
                Violation(
                    rule_id=self.rule_id,
                    start=span_tokens[0].idx,
                    end=span_tokens[-1].idx + len(span_tokens[-1].text),
                    message=f'passive voice: "{" ".join(t.text for t in span_tokens)}"',
                    suggestion="rewrite in active voice",
                )
            )
        return violations

    def _passive_span(self, verb: Token) -> list[Token]:
        span = [verb] + [token for token in verb.children if token.dep_ in self._PASSIVE_DEPS]
        return sorted(span, key=lambda token: token.i)
