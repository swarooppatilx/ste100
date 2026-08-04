from spacy.tokens import Doc

from src.engine import Rule, Violation

_AMERICAN = {
    "aeroplane": "airplane",
    "aluminium": "aluminum",
    "analogue": "analog",
    "analyse": "analyze",
    "analysed": "analyzed",
    "analysing": "analyzing",
    "armour": "armor",
    "behaviour": "behavior",
    "calibre": "caliber",
    "cancelled": "canceled",
    "cancelling": "canceling",
    "catalogue": "catalog",
    "catalyse": "catalyze",
    "centimetre": "centimeter",
    "centre": "center",
    "centred": "centered",
    "centres": "centers",
    "cheque": "check",
    "colour": "color",
    "coloured": "colored",
    "colours": "colors",
    "defence": "defense",
    "dialogue": "dialog",
    "electrolyse": "electrolyze",
    "favour": "favor",
    "favourite": "favorite",
    "fibre": "fiber",
    "flavour": "flavor",
    "fuelled": "fueled",
    "fuelling": "fueling",
    "grey": "gray",
    "harbour": "harbor",
    "honour": "honor",
    "humour": "humor",
    "hydrolyse": "hydrolyze",
    "jewellery": "jewelry",
    "kilometre": "kilometer",
    "labelled": "labeled",
    "labelling": "labeling",
    "labour": "labor",
    "licence": "license",
    "litre": "liter",
    "metre": "meter",
    "millimetre": "millimeter",
    "monologue": "monolog",
    "neighbour": "neighbor",
    "offence": "offense",
    "paralyse": "paralyze",
    "practise": "practice",
    "programme": "program",
    "rumour": "rumor",
    "savour": "savor",
    "signalled": "signaled",
    "signalling": "signaling",
    "sulphur": "sulfur",
    "theatre": "theater",
    "travelled": "traveled",
    "travelling": "traveling",
    "tyre": "tire",
    "vapour": "vapor",
}

_ISE_EXCEPTIONS = {
    "advertise",
    "advise",
    "apprise",
    "arise",
    "bruise",
    "chastise",
    "circumcise",
    "clockwise",
    "comprise",
    "compromise",
    "concise",
    "cruise",
    "demise",
    "despise",
    "devise",
    "disguise",
    "enfranchise",
    "enterprise",
    "excise",
    "exercise",
    "expertise",
    "franchise",
    "improvise",
    "incise",
    "likewise",
    "merchandise",
    "mortise",
    "noise",
    "otherwise",
    "poise",
    "praise",
    "precise",
    "premise",
    "promise",
    "raise",
    "revise",
    "supervise",
    "surmise",
    "surprise",
    "televise",
    "wise",
}


class SpellingRule(Rule):
    rule_id = "1.14"
    description = "Flag British spelling"

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for token in doc:
            if not token.is_alpha:
                continue
            american = self._americanize(token.lower_)
            if american is not None:
                violations.append(
                    Violation(
                        rule_id=self.rule_id,
                        start=token.idx,
                        end=token.idx + len(token.text),
                        message=f'"{token.text}" is British spelling',
                        suggestion=f'use American spelling "{american}"',
                    )
                )
        return violations

    @staticmethod
    def _americanize(lower: str) -> str | None:
        american = _AMERICAN.get(lower)
        if american is not None:
            return american
        for suffix, replacement in (("ysing", "yzing"), ("ysed", "yzed"), ("yse", "yze")):
            if lower.endswith(suffix):
                return lower[: -len(suffix)] + replacement
        if lower.endswith("isation"):
            return lower.replace("isation", "ization")
        if lower.endswith("ised"):
            base = lower[:-2]
            base_word = base + "e"
            if base_word in _ISE_EXCEPTIONS:
                return None
            american = _AMERICAN.get(base_word)
            if american is not None:
                return american + "d"
            return lower.replace("ised", "ized")
        if lower.endswith("ising"):
            base = lower[:-3]
            base_word = base + "e"
            if base_word in _ISE_EXCEPTIONS:
                return None
            american = _AMERICAN.get(base_word)
            if american is not None:
                return american[:-1] + "ing"
            return lower.replace("ising", "izing")
        if lower.endswith("ise"):
            if lower in _ISE_EXCEPTIONS:
                return None
            return lower[:-3] + "ize"
        return None
