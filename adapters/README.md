# Adapter notes

The `skills/` directory is the single source of truth. The installer maps it to
each agent's discovery directory; there are no forked skill copies here.

Claude Code and Codex also have native plugin manifests. Cursor and OpenCode
use their native skill directories. Copilot and Gemini support Agent Skills in
documented personal/project locations. `AGENTS.md` is a thin fallback for tools
that read repository instructions but do not discover skills automatically.
