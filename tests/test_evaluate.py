from src.cli import build_engine
from src.evaluate import evaluate, load_entries
from src.pipeline import get_pipeline


def test_perfect_score_on_matching_entries():
    entries = [
        {"text": "Utilize the wrench.", "expected": ["1.1"]},
        {"text": "Open the valve slowly.", "expected": []},
    ]
    result = evaluate(entries, build_engine(), get_pipeline())
    assert result.precision == 1.0
    assert result.recall == 1.0
    assert result.true_positives == 1
    assert result.false_positives == 0
    assert result.false_negatives == 0


def test_false_positive_counts():
    entries = [{"text": "Install the generator.", "expected": []}]
    result = evaluate(entries, build_engine(), get_pipeline())
    assert result.precision == 0.0
    assert result.false_positives == 1


def test_false_negative_counts():
    entries = [{"text": "Open the valve slowly.", "expected": ["9.3"]}]
    result = evaluate(entries, build_engine(), get_pipeline())
    assert result.recall == 0.0
    assert result.false_negatives == 1


def test_load_entries_shape():
    entries = load_entries()
    assert isinstance(entries, list)
    assert len(entries) >= 10
    assert all("text" in entry and "expected" in entry for entry in entries)


def test_annotated_suite_metrics_are_reasonable():
    result = evaluate(load_entries(), build_engine(), get_pipeline())
    assert result.precision >= 0.5
    assert result.recall >= 0.5
    assert result.f1 > 0.0
