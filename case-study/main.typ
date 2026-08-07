// ============================================================
//  ASD-STE100 Compliance Checker, NLP Case Study Report
//  College format (reference: "Case Study in college format").
//  Color scheme: navy blue accent (classic academic); all
//  text/background pairs meet WCAG AA contrast.
//  Font note: template font "Linux Libertine" is not installed
//  on this machine; compiled with "Liberation Serif" substitute.
// ============================================================

// -- Palette (navy) ---------------------------------------------
#let accent      = rgb(20, 50, 90)     // headings, table headers
#let accent-soft = rgb(45, 68, 99)     // captions, secondary text
#let rule        = rgb(203, 210, 219)  // hairline rules
#let tint        = rgb(242, 244, 246)  // light panel fills
#let tint-dark   = rgb(232, 234, 238)  // zebra strip / callout fill
#let link-color  = rgb(0, 90, 180)     // standard link blue
#let footer-text = rgb(90, 90, 90)     // footer page numbers
#let subtitle    = rgb(60, 60, 60)     // cover subtitle

// -- College header image -------------------------------------
#let college-header = image("assets/college-header.jpg", width: 100%, height: 3.2cm, fit: "contain")

// -- Page setup ------------------------------------------------
#let page-header = {
  v(8pt)
  align(right)[#text(size: 8pt, fill: accent-soft)[ASD-STE100 Compliance Checker Using NLP]]
  v(4pt)
  line(length: 100%, stroke: 0.5pt + rule)
  v(10pt)
}
#let page-footer = context align(center)[#text(size: 9pt, fill: footer-text)[#counter(page).display()]]
#set page(
  paper: "a4",
  margin: (top: 4cm, bottom: 2.5cm, left: 2.5cm, right: 2cm),
  header: page-header,
  footer: page-footer,
  header-ascent: 0%,
)
#set document(title: "ASD-STE100 Compliance Checker Using NLP", author: "Swaroop Dattatraya Patil")

// -- Global typography ----------------------------------------
#set text(font: "Liberation Serif", size: 11pt, hyphenate: true)
#set par(leading: 0.62em, justify: true, spacing: 0.4em)
#set heading(numbering: (..ns) => {
  let n = ns.pos()
  if n.len() == 1 { str(n.first()) + "." } else { n.map(str).join(".") }
})
#show heading: set block(breakable: false)

#show heading.where(level: 1): it => {
  v(0.45em)
  text(weight: "bold", size: 16pt, fill: accent)[#it]
  v(0.2em)
}
#show heading.where(level: 2): it => {
  v(0.3em)
  text(weight: "bold", size: 12pt, fill: accent-soft)[#it]
  v(0.12em)
}

#show link: set text(fill: link-color)

#show raw.where(block: true): it => {
  set text(font: "Liberation Mono", size: 9.5pt)
  block(width: 100%, fill: luma(246), stroke: 0.5pt + luma(200), radius: 2pt, inset: 8pt, it)
}
#show raw.where(block: false): it => {
  box(fill: luma(240), inset: (x: 3pt, y: 0pt), radius: 2pt, text(font: "Liberation Mono", size: 9pt, it))
}

#show table.cell: set text(size: 9.5pt, hyphenate: false)
#show table.cell: set par(justify: false)
#show table: set block(breakable: false)

// -- Helpers ---------------------------------------------------
#let obj(body) = {
  grid(columns: (1.2em, 1fr), [#text(fill: accent, weight: "bold")[•]], body)
  v(3pt)
}

#let callout(title, body) = block(
  width: 100%, fill: tint,
  stroke: (left: 2.5pt + accent),
  inset: (x: 10pt, y: 8pt), radius: (right: 2pt),
  [
    #text(weight: "bold", fill: accent)[#title]
    #v(3pt)
    #body
  ]
)

#let fig(path, caption-text, width-val: 100%) = {
  v(0.15cm)
  align(center)[
    #image(path, width: width-val, fit: "contain")
    #v(3pt)
    #text(size: 9.5pt, fill: accent-soft, style: "italic")[#caption-text]
  ]
  v(0.25cm)
}

#let ref-entry(num, detail) = {
  set text(size: 10pt)
  grid(
    columns: (2.6em, 1fr), gutter: 4pt,
    align(top, text(weight: "bold", fill: accent)[[#num]]),
    align(top, detail)
  )
  v(0.5pt)
}

#let table-counter = counter("ste-tables")

#let data-table(headers, rows, cols, caption: none) = {
  let tbl = table(
    columns: cols,
    inset: (x: 5pt, y: 3pt),
    align: left,
    stroke: 0.4pt + rule,
    fill: (col, row) => if calc.even(row) { tint-dark } else { white },
    table.header(..headers.map(c => table.cell(fill: accent, align: left, text(fill: white, weight: "bold")[#c]))),
    ..rows.flatten(),
  )
  if caption == none {
    block(breakable: false, tbl)
  } else {
    table-counter.step()
    block(breakable: false)[
      #v(0.05cm)
      #align(left)[#text(size: 9.5pt, weight: "bold", fill: accent-soft)[Table #context table-counter.display(). #caption]]
      #v(1.5pt)
      #tbl
    ]
  }
}

// ============================================================
//  COVER
// ============================================================
#set page(numbering: none, header: none, footer: none)

#college-header
#v(0.2cm)
#line(length: 100%, stroke: 1pt + accent)
#v(1.1cm)

#align(center)[
  #text(size: 16pt, weight: "bold", fill: accent)[Case Study: ASD-STE100 Compliance Checker Using NLP]
  #v(0.4cm)
  #text(size: 11pt, fill: subtitle)[
    A Rule-Based Controlled-Language Compliance Checking Tool \
    for Simplified Technical English using Python and spaCy
  ]
]

#v(1.0cm)

#table(
  columns: (1fr, 1.7fr),
  inset: (x: 10pt, y: 7pt),
  align: left,
  stroke: 0.4pt + rule,
  fill: (col, _) => if col == 0 { tint } else { white },
  [*Name of the student*], [Swaroop Dattatraya Patil],
  [*Class*], [4th Year IT (B.Tech IT)],
  [*Seat no*], [23510046],
  [*Course Teacher*], [Mrs. Gunjan Ukalkar],
  [*Title of the Course*], [Elective-III (B) Natural Language Processing (ITPEC702B), In-Sem I Exam, Case Study],
  [*Case Selected for Development*], [Rule-based detection of ASD-STE100 writing-rule violations in procedural and descriptive technical text, with approved-alternative suggestions],
)

#v(1.2cm)
#align(center)[
  #text(size: 10.5pt, weight: "bold", fill: accent)[DEPARTMENT OF INFORMATION TECHNOLOGY]
  #v(0.2cm)
  #text(size: 10pt)[
    ALL INDIA SHRI SHIVAJI MEMORIAL SOCIETY'S \
    INSTITUTE OF INFORMATION TECHNOLOGY, PUNE 411001
  ]
  #v(0.1cm)
  #text(size: 10pt)[SAVITRIBAI PHULE PUNE UNIVERSITY, PUNE 2025–26]
]

// ============================================================
//  TABLE OF CONTENTS
// ============================================================
#pagebreak()
#set page(numbering: "1", header: page-header, footer: page-footer)
#counter(page).update(1)

#text(size: 16pt, weight: "bold", fill: accent)[Abstract]
#v(3pt)
#line(length: 100%, stroke: 0.5pt + rule)
#v(0.35em)

ASD-STE100 (Simplified Technical English) governs the vocabulary and grammar of safety-critical technical documentation. This case study develops a rule-based compliance checker that runs spaCy's statistical pipeline over the text, applies ten automatable STE rules to the resulting linguistic structure, and reports each violation with an approved alternative. On a 16-sentence annotated suite the checker reaches precision 0.941, recall 1.000, and F1 0.970 — encouraging, though preliminary. The vocabulary is a curated, extensible JSON dictionary implementing about a third of the standard's Part 2 word list.

#v(0.55em)
#text(size: 10.5pt)[*Keywords:* Simplified Technical English, controlled natural language, rule-based NLP, spaCy, technical documentation]

#v(1.4em)
#text(size: 16pt, weight: "bold", fill: accent)[Table of Contents]
#v(3pt)
#line(length: 100%, stroke: 0.5pt + rule)
#v(0.35em)

#outline(title: none)

// ============================================================
//  CONTENT
// ============================================================
#pagebreak()

= Background / Situation

Technical documents such as aircraft maintenance manuals, operating procedures, and descriptive specifications must be understood identically by every reader, many of whom read English only as a second language. A poorly worded maintenance step can cause incorrect assembly, unscheduled downtime, or, in the worst case, an in-flight failure.

This safety-critical requirement is why the aerospace industry pioneered controlled writing standards: S1000D, ATA iSpec 2200 and ATA-104, and the EASA/FAA/CAAC directives all mandate or strongly reference simplified, rule-governed English for technical publications [11].

*ASD-STE100*, "Simplified Technical English", is the leading such standard. It was developed jointly by AECMA (Association Européenne des Constructeurs de Matériel Aérospatial) and the AIA (Aerospace Industries Association of America), and its history is short enough for a timeline:

#obj[*1970s* — development of Simplified English by AECMA with the AIA.]
#obj[*1986* — publication as the AECMA Guide (PSC-85-16598).]
#obj[*2004* — renamed ASD-STE100.]
#obj[*2025* — Issue 9 (January) becomes an international standard, subtitled "Standard for Technical Documentation" [1].]

It now reaches beyond aerospace into defense, rail, automotive, medical, and information technology.

The standard has two parts. Part 1 specifies 53 writing rules grouped into nine sections: Words, Noun phrases, Verbs, Sentences, and further chapters covering punctuation, word counts, and writing practices. Part 2 is the controlled dictionary: roughly 900 approved words and 1,200 unapproved words with their approved alternatives. The standard's guiding principle is that each approved word carries one approved meaning and one part of speech: "start" is approved while begin, commence, initiate, and originate are not, and "test" is approved only as a noun, never as a verb.

#data-table(
  (("Term", "Meaning in this report")),
  (
    ("STE / ASD-STE100", "Simplified Technical English; controlled-language standard for technical documentation"),
    ("CNL", "Controlled Natural Language: a restricted subset of a natural language"),
    ("POS", "Part of speech (NOUN, VERB, ADJ, ADP, ...)"),
    ("Lemma", "Dictionary headword form (opened, open)"),
    ("TN / TV", "Technical Noun / Technical Verb: user-extensible word classes (rules 1.5 / 1.12)"),
    ("STEMG", "Simplified Technical English Maintenance Group; the ASD working group that maintains the standard"),
    ("Precision", "Correctly flagged violations divided by total flags"),
    ("Recall", "Correctly flagged violations divided by total actual violations"),
  ),
  (0.22fr, 1.78fr),
  caption: "Terminology used in this report",
)

Most of this burden is borne by human reviewers who must hold the 53 rules and roughly 900 approved words in mind; as documentation grows, manual review becomes slow, expensive, and inconsistent. NLP automates the mechanical parts: a pipeline structures the text, a rule engine checks it against the STE rules, and a dictionary supplies approved replacements.

#block(breakable: false)[
= Problem Statement

The problem is the automatic detection of STE writing-rule violations in technical text and the suggestion of approved alternatives. Writing compliant prose is difficult because authors habitually reuse ambiguous vocabulary, construct long noun strings, shift into the passive voice and complex tenses, and exceed the standard's sentence limits. Manual checking presents several specific challenges:
]

#obj[The vocabulary and rules are large (53 rules, roughly 900 approved words); no reviewer can hold all of them reliably.]
#obj[Unapproved words such as "utilize" and "commence", British spellings ("colour", "centre"), noun clusters ("fuel pump housing flange assembly"), and passive voice are subtle and easy to miss.]
#obj[The same concept can be expressed with different words and structures, defeating simple keyword search.]
#obj[Manual review of thousands of pages consumes hundreds of professional-hours and still allows errors to slip through.]

Simple keyword search, the obvious first alternative, is insufficient: it cannot tell that "pump" is an approved verb but not an approved noun, that "has been opened" is a disallowed complex tense while "open" is fine, or that "will be using" is an -ing verb form rather than a modifier. Understanding usage requires morphological, syntactic, and even semantic analysis. A worked contrast:

#data-table(
  (("Non-STE (violations)", "STE (compliant)")),
  (
    ("Utilize the tool to commence the inspection.", "Use the tool to start the inspection."),
    ("The valve has been opened before the system was checked.", "Open the valve before you check the system."),
    ("The main fuel pump housing flange assembly was tightened.", "Tighten the assembly of the main fuel pump housing."),
    ("Remove the filter; then inspect it.", "Remove the filter. Then inspect it."),
  ),
  (1fr, 1fr),
  caption: "Worked contrast of non-STE and STE phrasing",
)

#callout[Key challenge: How can rule-based NLP automatically analyze technical English, identify violations of the automatable STE rules, and suggest approved alternatives with high precision and recall?][
  #v(2pt)
  #text(size: 10.5pt)[Section 4.3, "Why rule-based rather than machine-learned?", develops the reasoning behind this approach.]
]

= Dataset / Information

*Curated STE Dictionary (JSON).* The checker's vocabulary is a curated, user-extensible subset — about a third of the standard's roughly 900 approved words — stored in `data/` and loaded by `src/dictionary.py`:

#data-table(
  (("File", "Entries", "Example")),
  (
    ("`approved.json`", "310 approved words, part of speech", "`\"test\": \"NOUN\"`, `\"start\": \"VERB\"`"),
    ("`unapproved.json`", "79 unapproved words with approved alternatives", "`\"utilize\": \"use\"`, `\"commence\": \"start\"`"),
    ("`technical.json`", "25 technical nouns, 14 technical verbs (rules 1.5 / 1.12)", "`\"actuator\"`, `\"weld\"`, `\"switch on\"`"),
  ),
  (0.45fr, 1.05fr, 1.0fr),
  caption: "Dictionary files in data/",
)

Each dictionary entry follows the standard's four-column spirit: the word with its part of speech, the approved meaning or alternatives, an STE example, and a non-STE example:

#data-table(
  (("Word (POS)", "Alternative / Meaning", "STE example", "Non-STE example")),
  (
    ("`utilize`", "use", "Use the correct tool.", "Utilize the correct tool."),
    ("`commence`", "start", "Start the motor.", "Commence the motor."),
    ("`test` (noun)", "approved as noun only", "Do the leak test.", "Test the valve."),
    ("`colour`", "color (spelling)", "Install the red filter.", "Install the colour filter."),
  ),
  (0.45fr, 0.65fr, 0.95fr, 0.95fr),
  caption: "Dictionary entry format (word, approved alternative, STE and non-STE examples)",
)

The dictionary lists the American spelling `utilize` with its alternative; the British variant `utilise` is equally unapproved but, being absent from the dictionary, is flagged only as an unknown word, without a suggested alternative.

Technical nouns and verbs (rules 1.5 and 1.12) keep the checker practical: because these words cannot be enumerated in a general dictionary, an organization defines its own. The sample set includes component nouns (`actuator`, `duct`, `gasket`, `turbine`, `wrench`) and process verbs (`drill`, `weld`, `solder`, `switch on`, `taxi`), all editable in `technical.json`.

Annotated Evaluation Suite. `samples/eval.json` contains 16 short sentences, each labeled with the rule ids that should be flagged, including deliberately compliant sentences to measure false positives:

#data-table(
  (("Sentence", "Expected rules")),
  (
    ("Utilize the wrench.", "1.1"),
    ("Test the valve.", "1.2"),
    ("The system has been checked.", "3.2, 3.6"),
    ("The valve is to be replaced.", "3.4"),
    ("Carry out the inspection.", "9.3"),
    ("Remove the filter; then inspect it.", "8.1"),
    ("Switch on the motor.", "none (compliant)"),
    ("Install the generator.", "none (deliberate false-positive probe)"),
  ),
  (1.45fr, 0.55fr),
  caption: "Annotated evaluation suite (samples/eval.json, 8 of 16 sentences shown)",
)

#block(breakable: false)[
  *Working Samples.* `samples/compliant.txt` and `samples/non_compliant.txt` demonstrate the tool on clean and violation-rich text. The end-to-end data flow — input text through spaCy's linguistic analysis and the STE rule engine to a text or JSON report — is shown as the system architecture diagram in Figure 1 (Section 5).
]

The whole project is developed and verified with a small, modern toolchain:

#data-table(
  (("Component", "Role in development")),
  (
    ("Python 3.14", "runtime for the checker and its tooling"),
    ("spaCy ≥ 3.8.12 + en_core_web_sm", "tokenizer, tagger, dependency parser, lemmatizer"),
    ("Typer", "CLI framework behind the `ste100` command"),
    ("pytest + ruff", "unit tests; linting and formatting"),
    ("GitHub Actions", "CI and release automation (lint, tests, PyPI, PDF)"),
    ("Typst 0.15.1", "typesetting of this report"),
  ),
  (0.65fr, 1.35fr),
  caption: "Development toolchain",
)

#block(breakable: false)[
  = Analysis

  The compliance problem decomposes into linguistically well-defined sub-tasks, each implemented as a rule over spaCy's statistical features (`en_core_web_sm`):

  == Rule inventory

  #data-table(
    (("Rule", "Check", "Example flag", "spaCy technique")),
    (
      ("1.1", "Unapproved or unknown word", "utilize, colour", "dictionary lookup on `lower` / lemma"),
      ("1.2", "Approved word, wrong POS", "test (as verb)", "compare `token.pos_` to dictionary POS"),
      ("1.14", "British spelling", "-ise, colour, centre", "regex + replacement map"),
      ("2.1", "Noun cluster of more than 3 nouns", "fuel pump housing flange assembly", "consecutive NOUN/PROPN runs"),
      ("3.2/3.4", "Complex tenses", "has been opened, will be using, is to be replaced", "`Matcher` on `LEMMA`/`TAG`"),
      ("3.5", "-ing form used as a verb", "will be using", "`VBG` that is `ROOT`/`conj`"),
      ("3.6", "Passive voice", "was checked, was tightened", "`nsubjpass`, `auxpass`, `VBN`"),
      ("5.1/6.3", "Sentence length over 20/25 words", "overlong procedural sentence", "`doc.sents` + token count"),
      ("8.1", "Semicolon usage", "filter; then", "token text `;`"),
      ("9.3", "Phrasal verbs", "carry out", "phrase list on lemma"),
    ),
    (0.18fr, 0.42fr, 0.95fr, 0.95fr),
    caption: "Automatable STE rules and the spaCy technique behind each check",
  )
]

Tags follow spaCy's schemes: `nsubjpass`/`auxpass` are Universal Dependencies roles (passive subject / auxiliary); `VBN` (past participle) and `VBG` (gerund) are Penn Treebank tags.

The rules fall into two families. Lexical rules (1.1, 1.2, 1.14, 9.3) compare token forms, lemmas, and POS tags against the dictionary; these decisions are nearly deterministic once the dictionary is reliable. Syntactic rules (2.1, 3.2–3.6, 5.1/6.3, 8.1) walk sentence structure: passive voice is detected by following the dependency chain `nsubjpass, aux*, auxpass, VBN` (the strategy behind PassivePy [9]), complex tenses by matching auxiliary-lemma patterns, and noun clusters by counting consecutive nominal tags.

== Non-automatable rules

Two rule families are documented as non-automatable and out of scope. Rule 1.3 requires checking that an approved word is used with its approved meaning ("follow" as "come after", not "obey"), which demands semantic comprehension beyond current lexical resources. Topic-sentence rules and the question of whether a text is understandable likewise resist rule-based checking. A checker is therefore an aid, not a proof of compliance.

== Why rule-based rather than machine-learned?

STE is itself a closed rule system, so the natural engineering approach is to encode those rules directly. The limited availability of publicly labeled STE-compliance data makes a conventional supervised-learning approach difficult. Many established controlled-language checkers, including BSEC [2], SECC [3], Congree, Acrolinx, and MAXit, use rule-based approaches for exactly this reason [5]. The choice keeps the tool explainable: each flag is traceable to a rule, a span, and the dictionary.

= Solution

The solution is an incremental, rule-based NLP pipeline built on spaCy. It is intentionally model-light: the only trained model is `en_core_web_sm` (tokenizer, tagger, parser, lemmatizer); all STE logic is hand-written rules over it.

#fig("assets/architecture.svg", "Figure 1. System architecture of the ASD-STE100 compliance checker", width-val: 69%)

== Pipeline overview

The pipeline proceeds in five steps:

#obj[*Linguistic analysis:* spaCy produces sentences, tokens, lemmas, POS tags, and dependencies in a single `Doc`.]
#obj[*Rule evaluation:* ten registered rules run over the `Doc`, consulting the dictionary; each emits a `Violation` with rule id, character span, message, and suggestion.]
#obj[*Aggregation:* violations are combined with word and sentence counts into a `Report`.]
#obj[*Rendering and CLI:* the report is formatted as text or serialized as JSON; `ste100 <file> [--format text|json]` drives the whole pipeline.]
#obj[*Evaluation:* a harness compares detected rule ids against the annotated suite to compute precision, recall, and F1.]

== Implementation and reporting

The rule engine (`src/engine.py`) is a pluggable registry: each rule is a class with `rule_id`, `description`, and `check(doc)`, and the engine rejects duplicate ids at registration. Violations use character offsets (`token.idx` to `idx + len(token.text)`) so reports map back to the source text unambiguously. The dictionary layer (`src/dictionary.py`) exposes `is_approved`, `approved_pos`, `is_unapproved`, `is_technical`, `is_known`, and `alternative`, a single vocabulary interface consulted by every rule.

Running the tool on `samples/non_compliant.txt` produces a terminal report. Spans in parentheses are character offsets into the source text; the listing is truncated (entries 2–8, 12–13, and 15–18 omitted):

```text
$ ste100 samples/non_compliant.txt
Words: 45   Sentences: 3   Violations: 20

1. [1.1] "Utilize" is not an approved word (57-64)
   ...
9. [1.2] "pump" is approved only as verb; it is used here as noun (137-141)
10. [2.1] noun cluster: "fuel pump housing flange assembly" (132-165)
11. [3.6] passive voice: "has been opened was" (10-47)
14. [3.2] perfect tense: "has been opened" (10-25)
19. [1.14] "colour" is British spelling (69-75)
20. [9.3] "carry out" is a phrasal verb (91-100)
```

The clause "has been opened" is flagged twice: rule 3.6 catches the passive construction and rule 3.2 the perfect tense, matching the evaluation suite's expectation `3.2, 3.6` for "The system has been checked."

The same analysis is available as machine-readable JSON for downstream tooling such as editors, dashboards, or CI pipelines (truncated to two entries):

```json
{
  "words": 45, "sentences": 3, "total": 20,
  "violations": [
    {"rule": "1.1", "start": 57, "end": 64, "text": "Utilize",
     "message": "\"Utilize\" is not an approved word",
     "suggestion": "use"},
    {"rule": "1.2", "start": 137, "end": 141, "text": "pump",
     "message": "\"pump\" is approved only as verb; it is used here as noun",
     "suggestion": "use \"pump\" only as a verb"}
  ]
}
```

== Extensibility

Extensibility is a first-class requirement: adding a domain word means appending one line to `technical.json`, and adding a new check means implementing a `Rule` subclass and registering it with the engine. No other code changes.

= Real-World Implementation

STE compliance checking is an established, in-production technology. Boeing's BSEC, a full-parse grammar checker with over 400 rules, has checked commercial aircraft documentation since 1990; Wojcik, Harrison, and Bremer report precision 79% and recall 89% on their evaluation [2]. The SECC project (Adriaens & Macken, 1995) embedded STE checking in a machine-translation framework, reporting 87% precision, 93% recall [3], and a "convergence test" for how quickly corrections converge to compliant text [4].

Several commercial and open-source checkers are in production. Congree, Acrolinx, and MAXit (whose SMART system maintains 19,000+ rules) sell STE checking inside authoring environments; LanguageTool-based term checkers exist, for example TechScribe; and open-source suites include dfch's `AsdSte100*` family and HendrikLuedemann's S1000D-STE100-Tool-Suite, an Issue-9 linter. Shaw [7] surveys STE's uptake in the twenty-first century, Bernth [6] extends controlled-language checking from the sentence to the discourse level, Mitamura and Nyberg [8] drive knowledge-based machine translation from controlled English, and Zambrini and Chiarello [10] analyze how STE's term categories have evolved across specification issues.

The checker described here reproduces this behavior with far less machinery. On its 16-sentence annotated suite it detects 16 true positives, 1 false positive, and 0 false negatives, giving precision 0.941, recall 1.000, and F1 0.970. Although the datasets, rule coverage, and evaluation methodologies are not directly comparable, these results are encouraging relative to the reported historical figures. Because the evaluation suite contains only 16 sentences, the metrics should be interpreted as preliminary rather than as evidence of generalization to unrestricted technical documentation:

#data-table(
  (("Checker", "Precision", "Recall", "Notes")),
  (
    ("ste100-checker", "94.1%", "100.0%", "rule-based over spaCy; 10 rules; 16-sentence suite"),
    ("Boeing BSEC", "79%", "89%", "full-parse grammar checker, 400+ rules (Wojcik et al., 1993)"),
    ("SECC", "87%", "93%", "MT-framework checker/corrector (Adriaens & Macken, 1995)"),
  ),
  (0.5fr, 0.3fr, 0.3fr, 1.1fr),
  caption: [Checker comparison (ste100-checker figures from the 16-sentence suite)#footnote[Datasets, rule coverage, and evaluation methodology differ across systems; the figures are indicative, not directly comparable.]],
)

#data-table(
  (("Measure", "Count")),
  (
    ("True positives", "16"),
    ("False positives", "1"),
    ("False negatives", "0"),
    ("Precision (16/17)", "94.1%"),
    ("Recall (16/16)", "100.0%"),
    ("F1 score", "97.0%"),
  ),
  (1.5fr, 0.5fr),
  caption: "Evaluation metrics on the 16-sentence annotated suite",
)

Because the suite was written alongside the rules, this perfect recall reflects tuning to known behaviors rather than independent validation.

The single false positive is rule 1.1 flagging "Install the generator." The word `generator` is a legitimate technical noun not yet present in the small curated dictionary. This is an honest illustration of the extensibility mechanism rather than a logic error: adding `generator` to `technical.json` removes the flag entirely.

= Advantages

#grid(columns: (1fr, 1fr), gutter: 12pt,
  block[
    #obj[Automates repetitive, high-volume compliance review.]
    #obj[Flags every violation with its STE rule and the offending span.]
    #obj[Suggests approved alternatives directly from the dictionary.]
    #obj[Explainable output: each flag traces to a rule, a span, and a lookup.]
  ],
  block[
    #obj[Extensible technical nouns and verbs for any domain via JSON.]
    #obj[Lightweight: one statistical model plus hand-written rules.]
    #obj[Structured reports (text and JSON) for editors and CI pipelines.]
    #obj[Rule-based by design, matching every established checker in the field.]
  ],
)

= Limitations

#grid(columns: (1fr, 1fr), gutter: 12pt,
  block[
    #obj[Rules 1.3 (approved meanings), topic sentences, and semantic comprehension cannot be checked automatically.]
    #obj[Performance depends on dictionary coverage; the curated subset is intentionally small.]
    #obj[The evaluation suite is small (16 sentences) and cannot match the scale of BSEC/SECC studies.]
  ],
  block[
    #obj[Passive-voice and tense detection inherit spaCy's tagging accuracy on unusual or noisy prose.]
    #obj[Checkers are aids, not proofs: a text can be word-compliant yet still incorrect in meaning.]
    #obj[An STE expert remains necessary for final approval of critical or high-risk documentation.]
  ],
)

= Conclusion

*Key finding.* A rule-based NLP checker built on spaCy's statistical pipeline can enforce the automatable parts of ASD-STE100, at least on a small annotated suite. Ten rules reproduce the documented violation classes — from unapproved words and British spelling to noun clusters, complex tenses, and phrasal verbs — each flag carrying an approved alternative. The tool reaches precision 0.941, recall 1.000, and F1 0.970: encouraging, though preliminary, results.

*Lessons learned.* Hand-written rules over statistical features remain the right choice because STE is a closed rule system with limited public labeled data; BSEC, SECC, and today's commercial products take the same approach. A pluggable rule registry and a single dictionary interface keep the tool small and auditable, so a new rule or vocabulary entry touches one place. Honest evaluation — deliberately compliant sentences and known false positives — matters as much as the rules themselves.

*Future work.* Coverage can expand toward all 53 rules and a larger dictionary; LLM-assisted whole-sentence rephrasing could be verified by the rule engine, per the STEMG's caution that AI text must be checked, not assumed compliant. S1000D/DITA-aware checking, a web interface, and a larger open annotated corpus would support reproducible benchmarking.

= References

#ref-entry("1", [
  *ASD-STE100, Simplified Technical English — Issue 9*. ASD STEMG, January 2025. Available: #link("https://asd-ste100.org")[asd-ste100.org], accessed Aug. 2026.
])

#ref-entry("2", [
  R. Wojcik, P. Harrison, and J. Bremer, #link("https://aclanthology.org/P93-1006/")["Using bracketed parses to evaluate a grammar checking application,"] *Proc. of the 31st Annual Meeting of the Association for Computational Linguistics (ACL-93)*, pp. 38–45, 1993.
])

#ref-entry("3", [
  G. Adriaens and L. Macken, #link("https://aclanthology.org/1995.tmi-1.10/")["Technological evaluation of a controlled language application: precision, recall, and convergence tests for SECC,"] *Proc. of the 6th Int. Conf. on Theoretical and Methodological Issues in Machine Translation (TMI-95)*, pp. 123–141, 1995.
])

#ref-entry("4", [
  G. Adriaens, #link("https://aclanthology.org/1994.tc-1.8/")["Simplified English grammar and style correction in an MT framework: the LRE SECC project,"] *Proc. of Translating and the Computer 16*, Aslib, London, 1994.
])

#ref-entry("5", [
  U. Knops, #link("https://aclanthology.org/1999.mtsummit-1.7/")["Controlled language — issues in checkers' design,"] *Proc. of Machine Translation Summit VII*, pp. 40–45, 1999.
])

#ref-entry("6", [
  A. Bernth, #link("https://aclanthology.org/2006.claw-1.4/")["EasyEnglish Analyzer: taking controlled language from sentence to discourse level,"] *Proc. of the 5th Int. Workshop on Controlled Language Applications (CLAW-2006)*, Cambridge, MA, 2006.
])

#ref-entry("7", [
  D. Shaw, #link("https://aclanthology.org/2006.claw-1.1/")["Simplified Technical English in the 21st century,"] *Proc. of the 5th Int. Workshop on Controlled Language Applications (CLAW-2006)*, Cambridge, MA, 2006.
])

#ref-entry("8", [
  T. Mitamura and E. Nyberg, #link("https://aclanthology.org/1995.tmi-1.12/")["Controlled English for knowledge-based MT: experience with the KANT system,"] *Proc. of the 6th Int. Conf. on Theoretical and Methodological Issues in Machine Translation (TMI-95)*, pp. 158–172, 1995.
])

#ref-entry("9", [
  A. Sepehri, M. S. Mirshafiee, and D. M. Markowitz, #link("https://doi.org/10.1002/jcpy.1377")["PassivePy: a tool to automatically identify passive voice in big text data,"] *J. Consumer Psychology*, vol. 33, no. 4, pp. 714–727, 2023.
])

#ref-entry("10", [
  D. Zambrini and O. Chiarello, #link("https://ceur-ws.org/Vol-3427/short2.pdf")["Subject fields in a controlled natural language: how the evolution of the ASD-STE100 specification led to a proposal for a global structured review of term categories,"] *Proc. of the 2nd Int. Conf. on Multilingual Digital Terminology Today (MDTT 2023)*, CEUR Workshop Proceedings, vol. 3427, 2023.
])

#ref-entry("11", [
  *ISO 24620-4:2023*, "Language resource management — Controlled human communication (CHC) — Part 4: Basic principles and methodology for stylistic guidelines (BSG)." International Organization for Standardization, 2023. Available: #link("https://www.iso.org/standard/79087.html")[iso.org/standard/79087.html]
])
