from src.pipeline import analyze
from src.rules.rule_spelling import SpellingRule

RULE = SpellingRule()


def test_colour_flagged():
    hits = RULE.check(analyze("Remove the colour filter."))
    assert len(hits) == 1
    assert hits[0].rule_id == "1.14"
    assert hits[0].suggestion == 'use American spelling "color"'


def test_centre_flagged():
    hits = RULE.check(analyze("The centre is damaged."))
    assert len(hits) == 1
    assert hits[0].message == '"centre" is British spelling'


def test_ise_to_ize():
    hits = RULE.check(analyze("We utilise the tool."))
    assert hits[0].suggestion == 'use American spelling "utilize"'


def test_organisation_to_organization():
    hits = RULE.check(analyze("The organisation will approve it."))
    assert hits[0].suggestion == 'use American spelling "organization"'


def test_american_spelling_passes():
    assert RULE.check(analyze("Use the correct color.")) == []


def test_ise_exceptions_pass():
    assert RULE.check(analyze("Exercise the valve.")) == []
    assert RULE.check(analyze("Do not compromise on safety.")) == []
    assert RULE.check(analyze("Advertise the product.")) == []


def test_inflected_ise_to_ize():
    hits = RULE.check(analyze("We are utilising the tool."))
    assert hits[0].suggestion == 'use American spelling "utilizing"'


def test_inflected_exceptions_pass():
    assert RULE.check(analyze("The engineer advised caution.")) == []
    assert RULE.check(analyze("We raised the load.")) == []


def test_yse_to_yze():
    hits = RULE.check(analyze("We will analyse the data."))
    assert hits[0].suggestion == 'use American spelling "analyze"'
    assert RULE.check(analyze("The analyses are complete.")) == []
