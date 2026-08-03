from src.pipeline import analyze
from src.rules.rule_noun_cluster import NounClusterRule

RULE = NounClusterRule()


def test_overlong_cluster_flagged():
    doc = analyze("The aircraft engine fuel pump housing is installed.")
    hits = RULE.check(doc)
    assert len(hits) == 1
    assert "housing" in hits[0].message
    assert "5" in hits[0].message


def test_three_noun_cluster_passes():
    doc = analyze("Remove the fuel pump housing.")
    assert RULE.check(doc) == []


def test_two_noun_cluster_passes():
    doc = analyze("Check the valve cover.")
    assert RULE.check(doc) == []


def test_clusters_do_not_merge_across_sentences():
    doc = analyze("Open the door. Check the valve cover.")
    assert RULE.check(doc) == []
