# ste100-checker

[![PyPI version](https://img.shields.io/pypi/v/ste100-checker.svg)](https://pypi.org/project/ste100-checker/)
[![CI](https://github.com/swarooppatilx/ste100/actions/workflows/ci.yml/badge.svg)](https://github.com/swarooppatilx/ste100/actions/workflows/ci.yml)

Rule-based **ASD-STE100 (Simplified Technical English) compliance checker** for
procedural and descriptive technical text. It analyzes files with spaCy and
reports writing-rule violations together with approved-alternative suggestions.

STE is a controlled natural language: a restricted vocabulary, one meaning per
word, short simple sentences. No public labeled STE corpus exists, so all
compliance logic is rule-based on top of spaCy's statistical tokenizer, POS
tagger, dependency parser, and lemmatizer.

## Features

- Ten automatable STE rules: vocabulary, part of speech, spelling, noun
  clusters, verb tense, passive voice, sentence length, semicolons, phrasal verbs
- Approved-alternative suggestion with every violation
- Text output for humans, JSON output for pipelines
- Curated, extensible JSON dictionary (approved, unapproved, technical)

## Installation

Requires Python 3.14.

```bash
python -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
python -m spacy download en_core_web_sm
```

## Usage

```
ste100 <file.txt> [--format text|json]
```

| Option     | Alias | Description              | Default  |
|------------|-------|--------------------------|----------|
| `path`     |       | Text file to check       | required |
| `--format` | `-f`  | Output format: `text` or `json` | `text`   |
| `--help`   |       | Show help and exit       |          |

Text output:

```text
$ ste100 src/samples/non_compliant.txt
Words: 45
Sentences: 3
Violations: 20

1. [1.1] "Utilize" is not an approved word (57-64)
   suggestion: use
2. [1.1] "colour" is not in the approved or technical dictionary (69-75)
...
```

JSON output:

```json
{
  "words": 45,
  "sentences": 3,
  "total": 20,
  "violations": [
    {
      "rule": "1.1",
      "start": 57,
      "end": 64,
      "text": "Utilize",
      "message": "\"Utilize\" is not an approved word",
      "suggestion": "use"
    }
  ]
}
```

Each violation carries the rule id, character offsets into the source text,
the offending span, a message, and an approved alternative when one exists.
Exit status is `0` whether or not violations are found; parse the JSON and
branch on `total` if you need a nonzero signal.

## Rule coverage

| STE rule | Check | spaCy technique |
|---|---|---|
| 1.1 | Unapproved or unknown word (with approved alternative) | dictionary lookup on `token.lower_` / lemma |
| 1.2 | Approved word used with wrong part of speech | compare `token.pos_` to dictionary POS |
| 1.14 | British spelling (`-ise`, `colour`, `centre`) | regex + replacement map |
| 2.1 | Noun cluster with more than 3 nouns | consecutive NOUN/PROPN runs |
| 3.2 / 3.4 | Complex tenses (perfect, progressive, modal + be + VBN, "is to be + VBN") | `Matcher` on `LEMMA` / `TAG` |
| 3.5 | `-ing` form used as a verb | VBG that is ROOT/conj |
| 3.6 | Passive voice | `nsubjpass -> auxpass -> VBN` |
| 5.1 / 6.3 | Sentence longer than 20 (procedural) / 25 (descriptive) words | `doc.sents` + token count |
| 8.1 | Semicolon usage | token text `;` |
| 9.3 | Phrasal verbs (curated) | phrase list on lemma |

Non-automatable rules (approved meanings, topic sentences, comprehension) are
documented as out of scope; checkers are aids, not proofs.

## Extending the dictionary

`src/data/` holds the vocabulary as JSON. `technical.json` stores the domain words
you add under rules 1.5 / 1.12:

```json
{
  "nouns": ["actuator", "alternator", "antenna", "duct", "nozzle", "piston"],
  "verbs": ["bond", "drill", "weld"]
}
```

Append your own terms and rules 1.1 and 1.2 accept them automatically.
`approved.json` maps approved words to their one allowed part of speech;
`unapproved.json` maps unapproved words to their approved alternatives.

## Evaluation

`src/samples/eval.json` is a 16-sentence annotated suite. Run the harness:

```bash
python -m src.evaluate
```

Current results: **precision 0.941, recall 1.000, F1 0.970** (one false
positive: rule 1.1 flags `generator`, a legitimate technical noun absent from
the small curated dictionary). For context, Boeing BSEC reports 79%/89% and
SECC 87%/93% on their much larger suites.

## Development

```bash
ruff check .
ruff format --check .
python -m pytest
```

## Project layout

```
├─ src/           package root: dictionary, pipeline, engine, rules, report, cli, evaluate
├─ src/data/      curated approved / unapproved / technical dictionaries
├─ src/rules/     one module per rule family
├─ src/samples/   compliant / non-compliant examples + annotated eval suite
├─ tests/         per-rule unit tests and CLI/eval tests
├─ case-study/    college case-study report (Typst)
└─ .github/       CI and release workflows
```

## License

MIT. See [LICENSE](LICENSE).
