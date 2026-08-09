import json
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path

from spacy.language import Language

from src.engine import RuleEngine

SAMPLES_DIR = Path(__file__).resolve().parent / "samples"


@dataclass(frozen=True)
class EvalResult:
    precision: float
    recall: float
    f1: float
    true_positives: int
    false_positives: int
    false_negatives: int
    per_rule: dict[str, dict[str, float | int]]


def evaluate(entries: list[dict], engine: RuleEngine, nlp: Language) -> EvalResult:
    true_positives = false_positives = false_negatives = 0
    rule_tp: dict[str, int] = defaultdict(int)
    rule_fp: dict[str, int] = defaultdict(int)
    rule_fn: dict[str, int] = defaultdict(int)
    for entry in entries:
        expected = set(entry["expected"])
        fired = {violation.rule_id for violation in engine.run(nlp(entry["text"]))}
        for rule_id in expected & fired:
            true_positives += 1
            rule_tp[rule_id] += 1
        for rule_id in fired - expected:
            false_positives += 1
            rule_fp[rule_id] += 1
        for rule_id in expected - fired:
            false_negatives += 1
            rule_fn[rule_id] += 1
    precision = _rate(true_positives, true_positives + false_positives)
    recall = _rate(true_positives, true_positives + false_negatives)
    f1 = _f1(precision, recall)
    per_rule = {
        rule_id: {
            "true_positives": rule_tp[rule_id],
            "false_positives": rule_fp[rule_id],
            "false_negatives": rule_fn[rule_id],
            "precision": _rate(rule_tp[rule_id], rule_tp[rule_id] + rule_fp[rule_id]),
            "recall": _rate(rule_tp[rule_id], rule_tp[rule_id] + rule_fn[rule_id]),
        }
        for rule_id in sorted(set(rule_tp) | set(rule_fp) | set(rule_fn))
    }
    return EvalResult(
        precision, recall, f1, true_positives, false_positives, false_negatives, per_rule
    )


def load_entries(path: Path | None = None) -> list[dict]:
    path = path or SAMPLES_DIR / "eval.json"
    return json.loads(path.read_text(encoding="utf-8"))


def main() -> None:
    from src.cli import build_engine
    from src.pipeline import get_pipeline

    result = evaluate(load_entries(), build_engine(), get_pipeline())
    print(f"precision: {result.precision:.3f}")
    print(f"recall:    {result.recall:.3f}")
    print(f"f1:        {result.f1:.3f}")
    print(f"tp={result.true_positives} fp={result.false_positives} fn={result.false_negatives}")
    for rule_id, metrics in result.per_rule.items():
        counts = (
            f"{metrics['true_positives']}/{metrics['false_positives']}/{metrics['false_negatives']}"
        )
        row = f"precision={metrics['precision']:.3f} recall={metrics['recall']:.3f} ({counts})"
        print(f"  {rule_id}: {row}")


def _rate(correct: int, total: int) -> float:
    return correct / total if total else 0.0


def _f1(precision: float, recall: float) -> float:
    return 2 * precision * recall / (precision + recall) if precision + recall else 0.0


if __name__ == "__main__":
    main()
