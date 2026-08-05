import json
from dataclasses import dataclass

from spacy.tokens import Doc

from src.engine import Violation


@dataclass(frozen=True)
class Report:
    text: str
    words: int
    sentences: int
    violations: list[Violation]
    spans: list[str]


def build_report(doc: Doc, violations: list[Violation]) -> Report:
    words = sum(1 for token in doc if not token.is_space and not token.is_punct)
    sentences = sum(1 for _ in doc.sents)
    spans = [doc.text[v.start : v.end] for v in violations]
    return Report(doc.text, words, sentences, violations, spans)


def render_text(report: Report) -> str:
    lines = [
        f"Words: {report.words}",
        f"Sentences: {report.sentences}",
        f"Violations: {len(report.violations)}",
        "",
    ]
    for index, violation in enumerate(report.violations, start=1):
        span = f"({violation.start}-{violation.end})"
        lines.append(f"{index}. [{violation.rule_id}] {violation.message} {span}")
        if violation.suggestion:
            lines.append(f"   suggestion: {violation.suggestion}")
    return "\n".join(lines)


def render_json(report: Report) -> str:
    payload = {
        "words": report.words,
        "sentences": report.sentences,
        "total": len(report.violations),
        "violations": [
            {
                "rule": violation.rule_id,
                "start": violation.start,
                "end": violation.end,
                "text": span,
                "message": violation.message,
                "suggestion": violation.suggestion,
            }
            for violation, span in zip(report.violations, report.spans)
        ],
    }
    return json.dumps(payload, indent=2)
