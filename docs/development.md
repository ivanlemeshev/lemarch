# Development tasks

Run these tasks on Linux or in WSL.

## Install the tools

From the project directory, run:

```bash
mise install
```

The tool versions are set in `mise.toml`.

## Run the tasks

| Command                 | Action                                  |
| ----------------------- | --------------------------------------- |
| `mise run format`       | Format Markdown, JSON, TOML, and Bash   |
| `mise run format:check` | Check the format without changes        |
| `mise run lint`         | Run markdownlint, Tombi, and ShellCheck |
| `mise run check`        | Run all checks                          |

Each successful step prints one line, such as `Formatting TOML: OK`. If a step fails, it prints `Formatting TOML: ERROR` and the tool output. The task stops with the tool exit code. Checks run in order.

The settings match the Neovim configuration. Prettier preserves paragraph line breaks. shfmt uses two spaces and indents case statements. markdownlint permits long lines. Tombi formats and checks TOML files.
