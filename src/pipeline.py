import spacy
from spacy.language import Language
from spacy.tokens import Doc

MODEL = "en_core_web_sm"

_pipeline: Language | None = None


def load_pipeline(model: str = MODEL) -> Language:
    return spacy.load(model)


def get_pipeline() -> Language:
    global _pipeline
    if _pipeline is None:
        _pipeline = load_pipeline()
    return _pipeline


def analyze(text: str, nlp: Language | None = None) -> Doc:
    if nlp is None:
        nlp = get_pipeline()
    return nlp(text)
