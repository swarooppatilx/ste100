from spacy.tokens import Doc, Token

from src.engine import Rule, Violation


class VerbTenseRule(Rule):
    rule_id = "3.2"
    description = "Flag complex verb tenses (perfect, progressive, modal passive)"

    _AUX_DEPS = {"aux", "auxpass", "neg"}
    _PERFECT = {"have", "has", "had"}

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for token in doc:
            if token.pos_ != "VERB":
                continue
            if token.tag_ == "VBN":
                violations.extend(self._check_past_participle(token))
            elif token.tag_ == "VBG" and self._has_aux(token, "be"):
                violations.append(self._violation(token, "3.2", "progressive tense"))
        return violations

    def _check_past_participle(self, verb: Token) -> list[Violation]:
        aux = [token for token in verb.children if token.dep_ in ("aux", "auxpass")]
        lemmas = {token.lemma_ for token in aux}
        tags = {token.tag_ for token in aux}
        if lemmas & self._PERFECT:
            return [self._violation(verb, "3.2", "perfect tense")]
        if "to" in lemmas and "be" in lemmas:
            return [self._violation(verb, "3.4", "is to be + past participle")]
        if "be" in lemmas and "MD" in tags:
            return [self._violation(verb, "3.4", "modal + be + past participle")]
        return []

    def _has_aux(self, verb: Token, lemma: str) -> bool:
        return any(token.dep_ == "aux" and token.lemma_ == lemma for token in verb.children)

    def _violation(self, verb: Token, rule_id: str, label: str) -> Violation:
        span = [token for token in verb.children if token.dep_ in self._AUX_DEPS] + [verb]
        span = sorted(span, key=lambda token: token.i)
        return Violation(
            rule_id=rule_id,
            start=span[0].idx,
            end=span[-1].idx + len(span[-1].text),
            message=f'{label}: "{" ".join(token.text for token in span)}"',
            suggestion="use the present tense",
        )


class IngRule(Rule):
    rule_id = "3.5"
    description = "Flag -ing forms used as verbs"

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for token in doc:
            if token.tag_ != "VBG":
                continue
            if token.dep_ not in {"ROOT", "conj"}:
                continue
            violations.append(
                Violation(
                    rule_id=self.rule_id,
                    start=token.idx,
                    end=token.idx + len(token.text),
                    message=f'"{token.text}" is an -ing form used as a verb',
                    suggestion=f'use the verb "{token.lemma_}" instead',
                )
            )
        return violations
