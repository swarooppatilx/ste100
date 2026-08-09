import json

from typer.testing import CliRunner

from src.cli import app

runner = CliRunner()


def test_cli_text_output(tmp_path):
    target = tmp_path / "doc.txt"
    target.write_text("Utilize the wrench.")
    result = runner.invoke(app, [str(target)])
    assert result.exit_code == 0
    assert "Utilize" in result.stdout
    assert "Violations: 1" in result.stdout


def test_cli_json_output(tmp_path):
    target = tmp_path / "doc.txt"
    target.write_text("Utilize the wrench.")
    result = runner.invoke(app, [str(target), "--format", "json"])
    assert result.exit_code == 0
    data = json.loads(result.stdout)
    assert data["total"] == 1
    assert data["violations"][0]["suggestion"] == "use"


def test_cli_clean_file(tmp_path):
    target = tmp_path / "doc.txt"
    target.write_text("Remove the filter.")
    result = runner.invoke(app, [str(target)])
    assert result.exit_code == 0
    assert "Violations: 0" in result.stdout


def test_cli_short_format_flag(tmp_path):
    target = tmp_path / "doc.txt"
    target.write_text("Utilize the wrench.")
    result = runner.invoke(app, [str(target), "-f", "json"])
    assert result.exit_code == 0
    assert json.loads(result.stdout)["total"] == 1


def test_cli_missing_file():
    result = runner.invoke(app, ["no_such_file.txt"])
    assert result.exit_code == 2
    assert "no_such_file.txt" in result.stderr
