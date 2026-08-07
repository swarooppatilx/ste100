# ste100-checker

A rule-based **ASD-STE100 (Simplified Technical English) compliance checker** for
procedural and descriptive technical text. It analyzes input files with spaCy and
reports writing-rule violations together with approved-alternative suggestions.

STE (ASD-STE100, Issue 9) is a controlled natural language: every word has one
meaning, sentences are short and simple, and the vocabulary is restricted to an
approved dictionary. Because STE is itself a rule system — and no public labeled
STE corpus exists — all compliance logic here is *rule-based* on top of spaCy's
statistical tokenizer, POS tagger, dependency parser, and lemmatizer.

## Installation

Requires Python 3.11–3.14.

```bash
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
python -m spacy download en_core_web_sm
```

## Usage

```bash
ste100 <file.txt> [--format text|json]
```

`text` (default) prints a human-readable report; `json` emits machine-readable
output. Exit status is `0` whether or not violations are found; each violation
reports its STE rule id, the offending character span, a message, and where
applicable the approved alternative.

```text
$ ste100 samples/non_compliant.txt
Words: 45
Sentences: 3
Violations: 21

1. [1.1] "Utilise" is not in the approved or technical dictionary (57-64)
2. [1.1] "colour" is not in the approved or technical dictionary (69-75)
...
```

## Rule coverage

| STE rule | Check | spaCy technique |
|---|---|---|
| 1.1 | Unapproved or unknown word (with approved alternative) | dictionary lookup on `token.lower_` / lemma |
| 1.2 | Approved word used with wrong part of speech | compare `token.pos_` to dictionary POS |
| 1.14 | British spelling (`-ise`, `colour`, `centre`) | regex + replacement map |
| 2.1 | Noun cluster with more than 3 nouns | consecutive NOUN/PROPN runs |
| 3.2 / 3.4 | Complex tenses (perfect, progressive, modal + be + VBN, "is to be + VBN") | `Matcher` on `LEMMA` / `TAG` |
| 3.5 | `-ing` form used as a verb | VBG that is ROOT/conj |
| 3.6 | Passive voice | `nsubjpass → auxpass → VBN` |
| 5.1 / 6.3 | Sentence longer than 20 (procedural) / 25 (descriptive) words | `doc.sents` + token count |
| 8.1 | Semicolon usage | token text `;` |
| 9.3 | Phrasal verbs (curated) | phrase list on lemma |

Non-automatable rules (approved meanings, topic sentences, comprehension) are
documented as out of scope; checkers are aids, not proofs.

## Dictionaries

`data/` holds the curated, extensible STE dictionary as JSON:

- `approved.json` — approved words mapped to their part of speech
- `unapproved.json` — unapproved words mapped to approved alternatives
- `technical.json` — technical nouns (rule 1.5) and technical verbs (rule 1.12)
  that you can extend for your own domain

## Development

```bash
ruff check .
ruff format --check .
python -m pytest
```

## Evaluation

`samples/eval.json` is a 16-sentence annotated suite labeled by an STE-aware
judge. Run the harness with:

```bash
python -m src.evaluate
```

Results on the current suite: **precision 0.941, recall 1.000, F1 0.970**
(1 false positive: rule 1.1 flags `generator`, a legitimate technical noun
absent from the small curated dictionary). For context, Boeing BSEC reports
79%/89% and SECC 87%/93% on their much larger suites.

## Project layout

```
├─ data/          curated approved / unapproved / technical dictionaries
├─ src/           package root: dictionary, pipeline, engine, rules, report, cli, evaluate
├─ src/rules/     one module per rule family
├─ samples/       compliant / non-compliant examples + annotated eval suite
├─ tests/         per-rule unit tests and CLI/eval tests
├─ case-study/    college case-study report (Typst) — compile with `typst compile case-study/main.typ`
└─ .github/       CI and release workflows
```

## License

MIT
