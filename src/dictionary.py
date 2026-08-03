import json
from pathlib import Path
from typing import Any

DATA_DIR = Path(__file__).resolve().parent.parent / "data"


class Dictionary:
    def __init__(self, data_dir: Path = DATA_DIR) -> None:
        self._approved = self._load(data_dir / "approved.json")
        self._unapproved = self._load(data_dir / "unapproved.json")
        self._technical = self._load(data_dir / "technical.json")

    @staticmethod
    def _load(path: Path) -> Any:
        with open(path, encoding="utf-8") as f:
            return json.load(f)

    def is_approved(self, word: str) -> bool:
        return word in self._approved

    def approved_pos(self, word: str) -> str | None:
        return self._approved.get(word)

    def is_unapproved(self, word: str) -> bool:
        return word in self._unapproved

    def is_technical(self, word: str) -> bool:
        return word in self._technical["nouns"] or word in self._technical["verbs"]

    def is_known(self, word: str) -> bool:
        return self.is_approved(word) or self.is_technical(word)

    def alternative(self, word: str) -> list[str]:
        value = self._unapproved.get(word)
        if value is None:
            return []
        return value if isinstance(value, list) else [value]

    @property
    def technical_nouns(self) -> list[str]:
        return self._technical["nouns"]

    @property
    def technical_verbs(self) -> list[str]:
        return self._technical["verbs"]
