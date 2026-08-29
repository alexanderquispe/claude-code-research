# Claude Code for Research — Q-LAB PUCP

A 4-hour hands-on course (2 sessions × 2 hours) introducing agentic AI workflows for empirical research with [Claude Code](https://code.claude.com/docs).

**Instructor:** Alexander Quispe · [Q-LAB](https://qlab.pucp.edu.pe/) — Laboratorio de Inteligencia Artificial y Métodos Computacionales en Ciencias Sociales, PUCP · August 2026

## Structure — two audiences

Built with [Quarto](https://quarto.org) + reveal.js. Rendered HTML in `docs/` (GitHub Pages).

| Folder | Audience | Content |
|--------|----------|---------|
| `ras/` | Q-LAB research assistants | 4-hour hands-on course (2 decks, English): foundations · power tools |
| `profesores/` | Faculty, Faculty of Social Sciences (PUCP) | Two 3-hour step-by-step sessions (English; Spanish originals preserved under `profesores/es/`). `README.md` is the working workshop guide; slides included |
| `figures/`, `styles/` | shared | SVG diagrams and the reveal.js theme |
| `recordings/`, `transcripts/` | local only (gitignored) | class recordings and their Whisper transcriptions, used to improve the faculty material |

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
