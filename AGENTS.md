# AGENTS.md

- Always use ASD-STE100 Simplified Technical English in all comments and documentation.
- Keep each Markdown prose paragraph on one source line. Preserve structural line breaks in lists, tables, and code blocks.
- Format Markdown tables with aligned columns, consistent cell padding, and a header separator row.
- After edits, run `mise run format`. Then run `mise run check`.
- When the work is complete and the required checks pass, run `git diff HEAD`. Also inspect untracked files from `git status --short`. Include one commit title that covers all changes in the final response.
