# Claude Code for Research — QLab PUCP

A 4-hour hands-on course (2 sessions × 2 hours) introducing agentic AI workflows for empirical research with [Claude Code](https://code.claude.com/docs).

**Instructor:** Alexander Quispe · QLab, Artificial Intelligence Laboratory, PUCP · August 2026

## Slides

Built with [Quarto](https://quarto.org) + reveal.js. Source in `slides/`, rendered HTML in `docs/`.

| Session | Source | Topics |
|---------|--------|--------|
| Day 1 — Foundations | `slides/day1-foundations.qmd` | claude.ai vs. Cowork vs. Claude Code · agent loop · `/init` & `CLAUDE.md` · permission modes · Plan Mode |
| Day 2 — Power Tools | `slides/day2-power-tools.qmd` | custom commands & subagents · MCP · dashboards · Whisper for paper discussions · Sant'Anna academic workflow |

## Build

```bash
quarto render            # renders everything into docs/
quarto preview           # live-reload while editing
```

Publish to GitHub Pages: Settings → Pages → deploy from branch `main`, folder `/docs`.

## Credits

Course design draws heavily on Pedro H. C. Sant'Anna's
[*My Claude Code Workflow*](https://psantanna.com/claude-code-my-workflow/workflow-guide.html)
and the [claude-code-my-workflow](https://github.com/pedrohcgs/claude-code-my-workflow) template (MIT).
