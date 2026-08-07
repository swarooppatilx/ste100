// ============================================================
//  ASD-STE100 Compliance Checker, NLP Case Study Report
//  College format: cover, certificate, acknowledgement,
//  abstract + TOC, then the numbered case-study sections.
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
#set par(leading: 0.7em, justify: true, spacing: 0.5em)
#set heading(numbering: (..ns) => {
  let n = ns.pos()
  if n.len() == 1 { str(n.first()) + "." } else { n.map(str).join(".") }
})
#show heading: set block(breakable: false)

#show heading.where(level: 1): it => {
  v(0.5em)
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
    inset: (x: 5pt, y: 4pt),
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
//  CERTIFICATE
// ============================================================
#pagebreak()

#text(size: 16pt, weight: "bold", fill: accent)[Certificate]
#v(3pt)
#line(length: 100%, stroke: 0.5pt + rule)
#v(0.4cm)

This is to certify that the Case Study entitled

#v(0.15cm)
#align(center)[
  #text(size: 12pt, weight: "bold")[
    ASD-STE100 Compliance Checker Using NLP: A Rule-Based Controlled-Language Compliance Checking Tool for Simplified Technical English using Python and spaCy
  ]
]
#v(0.15cm)

being submitted by

#v(0.15cm)
#align(center)[
  #text(size: 11.5pt, weight: "bold")[Swaroop Dattatraya Patil #h(8pt) (23510046)]
]
#v(0.2cm)

is a record of bonafide work carried out by him under the supervision and guidance of *Mrs. Gunjan Ukalkar*, in partial fulfillment of the requirements for the elective course Natural Language Processing (ITPEC702B), In-Sem I Examination, Fourth Year (Information Technology), Academic Year 2025–2026, at All India Shri Shivaji Memorial Society's Institute of Information Technology, Pune, affiliated to Savitribai Phule Pune University.

#v(1.4cm)
#grid(
  columns: (1fr, 1fr),
  align(left)[*Place:* Pune],
  []
)
#v(1.5cm)
#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  align(center)[
    #line(length: 75%)
    #v(3pt)
    Mrs. Gunjan Ukalkar \
    *Course Teacher*
  ],
  align(center)[
    #line(length: 75%)
    #v(3pt)
    *Head of the Department*
  ]
)

// ============================================================
//  ACKNOWLEDGEMENT
// ============================================================
#pagebreak()

#text(size: 16pt, weight: "bold", fill: accent)[Acknowledgement]
#v(3pt)
#line(length: 100%, stroke: 0.5pt + rule)
#v(0.4cm)

I express my sincere gratitude to *Mrs. Gunjan Ukalkar* for her guidance, constant encouragement, and valuable feedback throughout the development of this case study. Her teaching of natural language processing fundamentals shaped the approach used in this work.

I am equally grateful to the faculty members of the Information Technology Department for their support and for clarifying doubts at various stages of the work.

I also thank the ASD STEMG for keeping the ASD-STE100 specification freely available, the authors of the research papers referenced in this report, and the maintainers of the open-source tools (spaCy and Typer) that this project builds upon.

#v(1.5cm)
#align(right)[*Swaroop Dattatraya Patil* \ Roll No. 23510046]

// ============================================================
//  ABSTRACT AND TABLE OF CONTENTS
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

Technical documents such as aircraft maintenance manuals, operating procedures, and descriptive specifications must be read and understood identically by every technician, many of whom read English only as a second language. A poorly worded step can cause incorrect assembly, unscheduled downtime, or, in the worst case, an in-flight failure.

This safety-critical requirement is why the aerospace industry pioneered controlled writing standards: S1000D, ATA iSpec 2200 and ATA-104, and the EASA/FAA/CAAC directives all mandate or strongly reference simplified, rule-governed English for technical publications [11].

*ASD-STE100*, "Simplified Technical English", is the leading standard of this kind. It was developed jointly by AECMA (Association Européenne des Constructeurs de Matériel Aérospatial) and the AIA (Aerospace Industries Association of America). Its history is short enough for a timeline:

#obj[*1970s* — development of Simplified English by AECMA with the AIA.]
#obj[*1986* — publication as the AECMA Guide (PSC-85-16598).]
#obj[*2004* — renamed ASD-STE100.]
#obj[*2025* — Issue 9 (January) becomes an international standard, subtitled "Standard for Technical Documentation" [1].]

The standard now reaches beyond aerospace into defense, rail, automotive, medical, and information technology.

STE has two parts. Part 1 defines 53 writing rules in nine sections that cover words, noun phrases, verbs, sentences, punctuation, word counts, and writing practices. Part 2 is the controlled dictionary: roughly 900 approved words and 1,200 unapproved words with their approved alternatives. The guiding principle is one word, one meaning, one part of speech: "start" is approved while begin, commence, initiate, and originate are not, and "test" is approved only as a noun, never as a verb.

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

Today most of this checking is done by hand. A reviewer must keep the 53 rules and roughly 900 approved words in mind, and as documents grow, manual review becomes slow, inconsistent, and expensive. NLP automates the mechanical part: a pipeline structures the text, a rule engine checks it against the STE rules, and a dictionary supplies approved replacements.

= Problem Statement

The problem is the automatic detection of STE writing-rule violations in technical text, together with approved alternatives for each violation. Writers habitually reuse ambiguous vocabulary, build long noun strings, shift into passive voice and complex tenses, and exceed the standard's sentence limits. Manual checking has specific weaknesses:

#obj[The rules and vocabulary are large (53 rules, roughly 900 approved words); no reviewer can hold all of them reliably.]
#obj[Violations are easy to miss: unapproved words such as "utilize" or "commence", British spellings like "colour" and "centre", noun clusters such as "fuel pump housing flange assembly", and passive voice.]
#obj[The same concept can be expressed with different words and structures, so simple keyword search misses most violations.]
#obj[Manual review of thousands of pages consumes hundreds of professional-hours and still allows errors to slip through.]

Keyword search, the obvious first alternative, cannot tell that "pump" is an approved verb but not an approved noun, that "has been opened" is a disallowed complex tense while "open" is fine, or that "will be using" is an -ing verb form rather than a modifier. These distinctions need morphology, syntax, and a little semantics. A worked contrast:

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

#callout[Key challenge][
  #v(2pt)
  #text(size: 10.5pt)[Can rule-based NLP analyze technical English, detect the automatable STE violations, and suggest approved alternatives with high precision and recall? Section 4.4, "Why rule-based rather than machine-learned?", develops the reasoning behind this approach.]
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

Each JSON file is a flat map. `approved.json` maps a word to the one part of speech it may take (rule 1.2 checks this); `unapproved.json` maps an unapproved word to its approved alternative; `technical.json` groups user-defined technical nouns and verbs. Real entries:

```json
// data/approved.json — word : the only part of speech it may take
{"test": "NOUN", "start": "VERB", "air": "NOUN", "open": "VERB"}

// data/unapproved.json — unapproved word : approved alternative
{"utilize": "use", "commence": "start", "abort": "stop", "ascertain": "check"}

// data/technical.json — technical nouns and verbs (rules 1.5 / 1.12)
{"nouns": ["actuator", "gasket", "nozzle", "wrench"], "verbs": ["drill", "weld", "switch on"]}
```

Each dictionary entry follows the standard's four-column spirit: the word with its part of speech, the approved meaning or alternatives, an STE example, and a non-STE example.

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

Technical nouns and verbs (rules 1.5 and 1.12) keep the checker practical. A general dictionary cannot enumerate every component or process, so each organization defines its own. The sample set includes component nouns such as `actuator`, `duct`, `gasket`, `turbine`, and `wrench`, and process verbs such as `drill`, `weld`, `solder`, `switch on`, and `taxi`, all editable in `technical.json`.

*Annotated Evaluation Suite.* `samples/eval.json` holds 16 short sentences, each labeled with the rule ids that should fire, including deliberately compliant sentences to measure false positives:

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

  Each rule targets one specific part of the language. Some look at single words, others at sentence structure. The checker implements ten rules from the standard:

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

The tag names come from spaCy's schemes: `nsubjpass`/`auxpass` are Universal Dependencies roles (passive subject / auxiliary), `VBN` is a Penn Treebank past-participle tag, and `VBG` a gerund tag.

The rules fall into two families. Lexical rules (1.1, 1.2, 1.14, 9.3) compare token forms, lemmas, and POS tags against the dictionary; once the dictionary is reliable, these decisions are straightforward. Syntactic rules (2.1, 3.2–3.6, 5.1/6.3, 8.1) walk sentence structure: passive voice follows the dependency chain `nsubjpass, aux*, auxpass, VBN` (the strategy behind PassivePy [9]), complex tenses match auxiliary-lemma patterns, and noun clusters are counted runs of nominal tags.

== How a rule fires

To see how the linguistic features drive the rules, consider the first sentence of `samples/non_compliant.txt`:

```text
The valve has been opened before the system was checked.
```

spaCy produces these tokens, lemmas, POS tags, and dependencies:

#data-table(
  (("Token", "Lemma", "POS", "Dependency", "Head")),
  (
    ("The", "the", "DET", "det", "valve"),
    ("valve", "valve", "NOUN", "nsubjpass", "opened"),
    ("has", "have", "AUX", "aux", "opened"),
    ("been", "be", "AUX", "auxpass", "opened"),
    ("opened", "open", "VERB", "ROOT", "opened"),
    ("before", "before", "SCONJ", "mark", "checked"),
    ("the", "the", "DET", "det", "system"),
    ("system", "system", "NOUN", "nsubjpass", "checked"),
    ("was", "be", "AUX", "auxpass", "checked"),
    ("checked", "check", "VERB", "advcl", "opened"),
    (".", ".", "PUNCT", "punct", "opened"),
  ),
  (0.5fr, 0.5fr, 0.45fr, 0.9fr, 0.6fr),
  caption: "Linguistic analysis of one sentence and how rules 3.2 / 3.6 fire",
)

Rule 3.6 walks the tokens looking for a `nsubjpass` role. It finds `valve` and `system`, each with a passive auxiliary. The first verb, `opened`, collects the span "has been opened was" — the span reaches into the next clause because the parser attaches `was` into `opened`'s subtree. Rule 3.2 separately matches the perfect-tense pattern *has + been + past participle* and reports "has been opened". Both flags for the same clause match the suite's expectation `3.2, 3.6`.

== Non-automatable rules

Two rule families are documented as non-automatable and out of scope. Rule 1.3 requires checking that an approved word is used with its approved meaning ("follow" as "come after", not "obey"), which needs semantic comprehension beyond today's lexical resources. Topic-sentence rules and the question of whether a text is understandable resist rule-based checking for the same reason. A checker is therefore an aid, not a proof of compliance.

== Why rule-based rather than machine-learned?

STE is itself a closed rule system, so the direct engineering approach is to encode those rules. Publicly labeled STE-compliance data is scarce, which makes supervised learning impractical. Established checkers — BSEC [2], SECC [3], Congree, Acrolinx, MAXit — are rule-based for the same reason [5]. Every flag also points back to one rule, one span, and one dictionary entry, which keeps the tool auditable.

= Solution

The solution is an incremental, rule-based NLP pipeline built on spaCy. It is deliberately model-light: the only trained model is `en_core_web_sm` (tokenizer, tagger, parser, lemmatizer); all STE logic is hand-written rules on top of it.

#fig("assets/architecture.svg", "Figure 1. System architecture of the ASD-STE100 compliance checker", width-val: 69%)

== Pipeline overview

The pipeline proceeds in five steps:

#obj[*Linguistic analysis:* spaCy produces sentences, tokens, lemmas, POS tags, and dependencies in a single `Doc`.]
#obj[*Rule evaluation:* ten registered rules run over the `Doc`, consulting the dictionary; each emits a `Violation` with rule id, character span, message, and suggestion.]
#obj[*Aggregation:* violations are combined with word and sentence counts into a `Report`.]
#obj[*Rendering and CLI:* the report is formatted as text or serialized as JSON; `ste100 <file> [--format text|json]` drives the whole pipeline.]
#obj[*Evaluation:* a harness compares detected rule ids against the annotated suite to compute precision, recall, and F1.]

== How the rules are implemented

Each rule is a small class with a `check(doc)` method, so the code reads like the standard's wording. The passive rule walks tokens for a passive subject, then collects the auxiliary span:

```python
class PassiveRule(Rule):
    rule_id = "3.6"
    description = "Detect passive voice"

    _PASSIVE_DEPS = {"auxpass", "aux", "neg"}

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for token in doc:
            if token.dep_ != "nsubjpass":
                continue
            verb = token.head
            span_tokens = self._passive_span(verb)
            if not span_tokens:
                continue
            violations.append(
                Violation(
                    rule_id=self.rule_id,
                    start=span_tokens[0].idx,
                    end=span_tokens[-1].idx + len(span_tokens[-1].text),
                    message=f'passive voice: "{" ".join(t.text for t in span_tokens)}"',
                    suggestion="rewrite in active voice",
                )
            )
        return violations

    def _passive_span(self, verb: Token) -> list[Token]:
        span = [
            token for token in verb.subtree
            if token.dep_ in self._PASSIVE_DEPS or token is verb
        ]
        return sorted(span, key=lambda token: token.i)
```

The noun-cluster rule is simpler: it counts consecutive nouns and reports the run once it passes the limit:

```python
class NounClusterRule(Rule):
    rule_id = "2.1"
    description = "Flag noun clusters of more than three nouns"

    _NOUN_POS = {"NOUN", "PROPN"}

    def check(self, doc: Doc) -> list[Violation]:
        violations = []
        for sent in doc.sents:
            run = []
            for token in sent:
                if token.pos_ in self._NOUN_POS:
                    run.append(token)
                else:
                    violations.extend(self._flush(run))
                    run = []
            violations.extend(self._flush(run))
        return violations

    def _flush(self, run: list[Token]) -> list[Violation]:
        if len(run) <= self.max_nouns:
            return []
        text = " ".join(token.text for token in run)
        return [
            Violation(
                rule_id=self.rule_id,
                start=run[0].idx,
                end=run[-1].idx + len(run[-1].text),
                message=f'noun cluster of {len(run)} nouns: "{text}"',
                suggestion="break the cluster with prepositions or adjectives",
            )
        ]
```

The rule engine (`src/engine.py`) is a pluggable registry: rules register by rule id and the engine rejects duplicates. The dictionary layer (`src/dictionary.py`) exposes `is_approved`, `approved_pos`, `is_unapproved`, `is_technical`, `is_known`, and `alternative` — one vocabulary interface used by every rule. Violations carry character offsets (`token.idx` to `idx + len(token.text)`) so every report maps back to the source text exactly.

== Reporting and the command line

Running the tool on `samples/non_compliant.txt` produces the full report. The spans in parentheses are character offsets into the source text:

```text
$ ste100 samples/non_compliant.txt
Words: 45
Sentences: 3
Violations: 20

1. [1.1] "Utilize" is not an approved word (57-64)
   suggestion: use
2. [1.1] "colour" is not in the approved or technical dictionary (69-75)
3. [1.1] "coded" is not in the approved or technical dictionary (76-81)
4. [1.1] "final" is not in the approved or technical dictionary (105-110)
5. [1.1] "main" is not in the approved or technical dictionary (127-131)
6. [1.1] "crew" is not in the approved or technical dictionary (221-225)
7. [1.1] "will" is not in the approved or technical dictionary (226-230)
8. [1.2] "before" is approved only as adp; it is used here as sconj (26-32)
   suggestion: use "before" only as a adp
9. [1.2] "pump" is approved only as verb; it is used here as noun (137-141)
   suggestion: use "pump" only as a verb
10. [2.1] noun cluster: "fuel pump housing flange assembly" (132-165)
   suggestion: break the cluster with prepositions or adjectives
11. [3.6] passive voice: "has been opened was" (10-47)
   suggestion: rewrite in active voice
12. [3.6] passive voice: "was checked" (44-55)
   suggestion: rewrite in active voice
13. [3.6] passive voice: "was tightened" (166-179)
   suggestion: rewrite in active voice
14. [3.2] perfect tense: "has been opened" (10-25)
   suggestion: use the present tense
15. [3.4] is to be + past participle: "to be replaced" (198-212)
   suggestion: use the present tense
16. [3.2] progressive tense: "will be using" (226-239)
   suggestion: use the present tense
17. [3.5] "using" is an -ing form used as a verb (234-239)
   suggestion: use the verb "use" instead
18. [8.1] semicolons are not allowed (121-122)
   suggestion: split the sentence or use a full stop
19. [1.14] "colour" is British spelling (69-75)
   suggestion: use American spelling "color"
20. [9.3] "carry out" is a phrasal verb (91-100)
   suggestion: do, measure
```

The same analysis is available as JSON for editors, dashboards, or CI pipelines. Two entries:

```json
{
  "words": 45, "sentences": 3, "total": 20,
  "violations": [
    {"rule": "1.1", "start": 57, "end": 64, "text": "Utilize",
     "message": "\"Utilize\" is not an approved word", "suggestion": "use"},
    {"rule": "3.6", "start": 166, "end": 179, "text": "was tightened",
     "message": "passive voice: \"was tightened\"",
     "suggestion": "rewrite in active voice"}
  ]
}
```

== Extensibility and design principles

Extensibility was a design requirement from the start. Adding a domain word means appending one line to `technical.json`; adding a new check means implementing a `Rule` subclass and registering it with the engine. No other code changes. A few principles guided the design:

#obj[*Pluggable rules:* one class per rule; the engine is a registry, not a switch statement.]
#obj[*One dictionary interface:* every rule reads the vocabulary through the same API.]
#obj[*Offsets, not guesses:* violations carry character spans, so reports map back to the source exactly.]
#obj[*Version sync:* `src/__init__.py` carries the release version, kept equal to the git tag.]
#obj[*CI on every push:* ruff, formatting, and pytest run across Python 3.11–3.14 before anything is released.]

= Real-World Implementation

STE checking is established, in-production technology. Boeing's BSEC, a full-parse grammar checker with more than 400 rules, has reviewed commercial aircraft documentation since 1990; Wojcik, Harrison, and Bremer report 79% precision and 89% recall [2]. The SECC project (Adriaens & Macken, 1995) embedded STE checking in a machine-translation framework, reporting 87% precision and 93% recall [3], plus a "convergence test" that measures how quickly corrections settle on compliant text [4].

Commercial and open-source checkers are in widespread use. Congree, Acrolinx, and MAXit (whose SMART system maintains 19,000+ rules) sell STE checking inside authoring environments; TechScribe offers a LanguageTool-based checker; and open-source suites include dfch's `AsdSte100*` family and HendrikLuedemann's S1000D-STE100-Tool-Suite, an Issue-9 linter. Shaw [7] surveys STE's uptake in the twenty-first century, Bernth [6] extends controlled-language checking from the sentence to the discourse level, Mitamura and Nyberg [8] drive knowledge-based machine translation from controlled English, and Zambrini and Chiarello [10] analyze how STE's term categories have evolved across specification issues.

== Evaluation

The 16-sentence suite is annotated with the rule ids that should fire (Section 3). Detection counts are: a *true positive* flags a violation the suite expects; a *false positive* flags text the suite marks compliant; a *false negative* misses an expected violation. From these counts:

```text
precision  = TP / (TP + FP)   = 16 / 17 = 0.941
recall     = TP / (TP + FN)   = 16 / 16 = 1.000
F1         = 2 · P · R / (P + R)       = 0.970
```

The tool detects 16 true positives, 1 false positive, and 0 false negatives on the suite. The results, with the reported historical figures for context:

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

Because the suite was written alongside the rules, this perfect recall reflects tuning to known behavior rather than independent validation. The single false positive is rule 1.1 flagging "Install the generator." The word `generator` is a legitimate technical noun not yet present in the small curated dictionary. This is expected behavior, not a bug: add `generator` to `technical.json` and the flag disappears.

= Advantages

#obj[*Fast:* a file is checked in well under a second once spaCy is loaded, regardless of length.]
#obj[*Consistent:* the same rules and the same dictionary apply to every file, with no reviewer fatigue.]
#obj[*Actionable:* every violation names the rule, the offending span, and an approved alternative.]
#obj[*Auditable:* a flag always traces back to one rule, one span, and one dictionary entry.]
#obj[*Extensible:* new technical nouns, verbs, and rules are added without touching existing code.]
#obj[*Lightweight:* one statistical model plus hand-written rules — no training pipeline, no GPU.]

= Limitations

#grid(columns: (1fr, 1fr), gutter: 12pt,
  block[
    #obj[Rules 1.3 (approved meanings), topic sentences, and semantic comprehension cannot be checked automatically.]
    #obj[Performance depends on dictionary coverage; the curated subset is intentionally small.]
    #obj[The evaluation suite is small (16 sentences) and cannot match the scale of the BSEC/SECC studies.]
  ],
  block[
    #obj[Passive-voice and tense detection inherit spaCy's tagging accuracy on unusual or noisy prose.]
    #obj[Checkers are aids, not proofs: a text can be word-compliant yet still wrong in meaning.]
    #obj[An STE expert must still approve critical or high-risk documentation.]
  ],
)

Running the tool also surfaced a few quirks worth recording — none breaks the checker, but each shows where rule-based output needs human judgment:

#callout[Observed output quirks][
  #v(2pt)
  #text(size: 10.5pt)[
    #obj[`will` is flagged as an unknown word (rule 1.1) because the modal is not in the dictionary; the report cannot yet suggest rewriting "will be using" as "use".]
    #obj[`colour` is flagged twice — once as an unknown word (1.1) and once as a British spelling (1.14).]
    #obj[One suggestion reads "use `before` only as a adp", a wording slip in the part-of-speech template (a vs. an).]
    #obj[Passive spans can reach into the next clause, as "has been opened was" shows; the span is a hint, not a parse.]
  ]
]

= Conclusion

*Key finding.* A rule-based NLP checker built on spaCy's statistical pipeline can enforce the automatable parts of ASD-STE100, at least on a small annotated suite. Ten rules reproduce the documented violation classes — from unapproved words and British spelling to noun clusters, complex tenses, and phrasal verbs — and every flag carries an approved alternative. On the 16-sentence suite the tool reaches precision 0.941, recall 1.000, and F1 0.970.

*Lessons learned.* Hand-written rules over statistical features remain the right choice because STE is a closed rule system with little public labeled data; BSEC, SECC, and today's commercial products take the same approach. A pluggable rule registry and a single dictionary interface keep the tool small and auditable: a new rule or vocabulary entry touches one place. The deliberately compliant sentences and the known false positive made the evaluation honest.

*What this case illustrates.* For a student of natural language processing:

#obj[A rule system (STE) can be encoded directly as rules over statistical features — no training data needed.]
#obj[Curated, extensible data decides what the checker can say; coverage is the binding constraint.]
#obj[Evaluation design matters: precision and recall are only as meaningful as the annotated suite.]
#obj[Automation stops at semantics: approved meanings, topic sentences, and comprehension stay with the human reviewer.]

*Future work.* Coverage can expand toward all 53 rules and a larger dictionary; LLM-assisted rephrasing could be verified by the rule engine, following the STEMG's caution that AI text must be checked, not assumed compliant. S1000D/DITA-aware checking, a web interface, and a larger open annotated corpus would support reproducible benchmarking.

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
