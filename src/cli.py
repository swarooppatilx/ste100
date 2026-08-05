from pathlib import Path

import typer

from src.engine import RuleEngine
from src.pipeline import get_pipeline
from src.report import build_report, render_json, render_text
from src.rules.rule_l1_pos import PosRule
from src.rules.rule_l1_words import WordRule
from src.rules.rule_length import SentenceLengthRule
from src.rules.rule_noun_cluster import NounClusterRule
from src.rules.rule_passive import PassiveRule
from src.rules.rule_phrasal import PhrasalVerbRule
from src.rules.rule_semicolon import SemicolonRule
from src.rules.rule_spelling import SpellingRule
from src.rules.rule_verb_tense import IngRule, VerbTenseRule

app = typer.Typer()


def build_engine() -> RuleEngine:
    rules = [
        WordRule(),
        PosRule(),
        SentenceLengthRule(),
        NounClusterRule(),
        PassiveRule(),
        VerbTenseRule(),
        IngRule(),
        SemicolonRule(),
        SpellingRule(),
        PhrasalVerbRule(),
    ]
    return RuleEngine(rules)


@app.command()
def check(
    path: Path = typer.Argument(..., help="Path to the text file to check"),
    fmt: str = typer.Option("text", "--format", "-f", help="Output format: text or json"),
) -> None:
    if fmt not in {"text", "json"}:
        raise typer.BadParameter("format must be 'text' or 'json'")
    text = path.read_text(encoding="utf-8")
    doc = get_pipeline()(text)
    report = build_report(doc, build_engine().run(doc))
    typer.echo(render_json(report) if fmt == "json" else render_text(report))


if __name__ == "__main__":
    app()
