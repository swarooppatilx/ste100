from src.dictionary import DATA_DIR, Dictionary

DICT = Dictionary(DATA_DIR)


def test_loads_all_sections():
    assert DICT._approved
    assert DICT._unapproved
    assert DICT.technical_nouns
    assert DICT.technical_verbs


def test_approved_pos():
    assert DICT.is_approved("test")
    assert DICT.approved_pos("test") == "NOUN"
    assert DICT.approved_pos("start") == "VERB"


def test_unknown_word_not_approved():
    assert not DICT.is_approved("xyzzy")
    assert DICT.approved_pos("xyzzy") is None


def test_alternative_for_unapproved():
    assert DICT.alternative("utilize") == ["use"]
    assert DICT.alternative("commence") == ["start"]


def test_alternative_missing():
    assert DICT.alternative("xyzzy") == []


def test_technical_membership():
    assert "actuator" in DICT.technical_nouns
    assert "switch on" in DICT.technical_verbs


def test_is_known():
    assert DICT.is_known("use")
    assert DICT.is_known("actuator")
    assert not DICT.is_known("xyzzy")
