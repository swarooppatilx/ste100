import pytest

from src.pipeline import MODEL, analyze, get_pipeline, load_pipeline


def test_load_pipeline():
    nlp = load_pipeline()
    assert nlp("test").text == "test"


def test_load_pipeline_missing_model(monkeypatch):
    def fail(model):
        raise OSError(f"can not find model '{model}'")

    monkeypatch.setattr("src.pipeline.spacy.load", fail)
    with pytest.raises(RuntimeError, match=f"python -m spacy download {MODEL}"):
        load_pipeline()


def test_sentence_segmentation():
    doc = analyze("Open the access door. Remove the filter.")
    sents = list(doc.sents)
    assert len(sents) == 2
    assert sents[0].text == "Open the access door."
    assert sents[1].text == "Remove the filter."


def test_tokenization():
    doc = analyze("Remove the filter.")
    assert [t.text for t in doc] == ["Remove", "the", "filter", "."]
    assert doc[0].lemma_ == "remove"
    assert doc[0].pos_ == "VERB"


def test_pipeline_is_cached():
    assert get_pipeline() is get_pipeline()
