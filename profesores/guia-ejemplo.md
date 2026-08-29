# Instructor’s guide — example project

**Folder:** `ejemplo-mineria-conflicto/` · **Size:** ~41 MB · 27 files

This document is for the instructor, not participants. It contains the answer key for the exercises and what should happen in each.

---

## 1. What the project is

A real research project, half‑started and deliberately messy, on **mining and social conflict in Peru**. It anchors the exercises in both sessions.

**Research question:**

> In Peru’s mining departments, does mining revenue reduce social conflict —
> or does it mainly change what people protest about?

It’s designed to **break if you remove either data type**. The first half is answered with CSVs; the second requires reading text. That’s why it works across four disciplines at once:

| Discipline | Its version of the question | Data used |
|---|---|---|
| Economics | Does mining intensity correlate with conflict frequency? | Mining output and employment |
| Political Science | Does the legislative agenda respond to on‑the‑ground conflicts? | Bills (JSON) |
| Sociology | Which actors appear and how does the repertoire change? | Ombudsman narratives |
| Anthropology | Is it framed as water and territory, or as jobs and revenue? | Ombudsman narratives |

**The project does NOT ship with `CLAUDE.md`.** Generating it with `/init` is the Block 5 exercise in Session 1.

---

## 2. What’s in the folder

### `datos/`

| File | What it is | Detail |
|---|---|---|
| 10 Ombudsman PDFs | Monthly reports no. 258–269 (Aug 2025 – Jul 2026) | 99–122 pp. each, with text layer |
| `produccion-minera-2025.zip` | 2025 mining production | 3 XLSX inside |
| `produccion minera ene-may 2026.zip` | Jan–May 2026 production | spaces in name, on purpose |
| `empleo_minero_2020_may2026.xlsx` | Mining employment by department | 35 rows × 92 columns, wide format |
| `mesas-dialogo.csv` | Dialogue tables (Prime Minister’s Office) | 19 records, 13 regions |
| `compromisos-dialogo.csv` | Government commitments in dialogue tables | 506 records, free text + status |
| `proyectos-ley-mineria.json` | 251 mining/canon bills | Congress API |

**Reports 261 and 263 are missing.** Not a mistake: the Ombudsman didn’t publish them with any derivable URL. If someone notices, it’s a good moment to discuss missing data in official sources.

### `papers/`

Eight PDFs with deliberately chaotic names (`descarga.pdf`,
`el pasado importa - copia (2).pdf`, `articulo minería (1).pdf`…). Raw material for the renaming exercise.

**Three are off‑topic** (one on Colombia, one literature review, one methods article). Intentional: every real folder has noise, and spotting it is part of the exercise.

### Others

- `bibliografia-borrador.md` — ★ the file with planted errors (§4)
- `notas/ideas sueltas.md` — the “researcher’s” notes; includes hints on the canon proxy decision and suspicious citations
- `descargar-datos.sh` — reproducibility; data already shipped downloaded

---

## 3. Real technical traps (use them, don’t avoid them)

All verified. They show up by themselves if someone tries to automate:

1. **`wc -l` ≠ number of records.** `compromisos-dialogo.csv` has 634 lines but **506 records**: there are line breaks inside text fields. Great to show why “count lines” is misleading.
2. **Encoding and separator.** PCM CSVs are **latin‑1** with **`;`** as separator. Opening them “normally” produces mojibake.
3. **An official typo.** The `mesas` CSV header says `ENTIDENTIDAD QUE PRESIDE EL ESPACIOAD`. Official data come dirty too.
4. **`www.datosabiertos.gob.pe` requires the `www.`** — without it DNS doesn’t resolve.
5. **Script‑hostile portals.** gob.pe returns HTTP 418 and Congress’s API returns 403 if the User‑Agent doesn’t look like a browser.
6. **Wide format.** The mining employment XLSX has months in 92 columns. You must reshape it before analyzing.

---

## 4. ★ Answer key: the eight errors in `bibliografia-borrador.md`

All **real and verifiable against Crossref**. The exercise is to ask Claude to verify each citation; it should find them all.

| # | What the draft says | What Crossref says |
|---|---|---|
| 1 | Loayza, **Mier y Teran** & Rigolini (2016), *World Development* | Only **Loayza and Rigolini**. Mier y Teran is an author on the 2013 working paper (IZA DP 7226) and disappears in the published version |
| 2 | Aragón & Rud, **“The Blessing of Natural Resources”** | The published title is **“Natural Resources and Local Communities.”** “The Blessing…” is the BCRP working paper title (2009) |
| 3 | …in *AEJ: **Applied Economics*** | It’s *AEJ: **Economic Policy*** |
| 4 | Aragón & Winkler, DOI `…resourpol.2023.**104612**` | That DOI **exists but is a different paper**: Zhang et al. (2024), “Resilient recovery strategies.” The correct one is `104305` |
| 5 | Arellano‑Yanguas, **“A Thoroughly Modern Resource Curse?”** in *JDS* 47(4) | The published article is **“Aggravating the Resource Curse.”** That title is from IDS Working Paper 300 |
| 6 | **Dargent, P.** | It’s **Eduardo** Dargent |
| 7 | Bebbington, **Bury, Humphreys Bebbington**, … | In *World Development* the order is **Humphreys Bebbington, Bury** — positions 2 and 3 swapped |
| 8 | Salas Carreño (**2016**), vol. 22(2) | Print is **2017**; online Dec‑2016. Volume 22(2) is 2017, so the draft contradicts itself |

There’s also a softer ninth detail: in “To review” you’ll find **“Orihuela, O.”** in the *Fading local effects* citation. It’s **José Carlos** Orihuela. Crossref also returns a *Carlos Orihuela* (UNALM) who is **a different person** — a good author‑disambiguation example.

**The most valuable is #4.** A broken DOI is caught at the first click; a DOI that resolves to the wrong article can survive peer review. It’s exactly the kind of error that only shows up if you truly verify.

**The prompt that exposes them all:**

```text
Verify each citation in bibliografia-borrador.md against Crossref.
For each one, tell me what doesn’t match and what the correct data is.
Don’t tell me it’s fine if you couldn’t check it.
```

---

## 5. ★ The coding‑audit exercise (Session 2)

The one that moves the workshop’s lesson —memory vs. verification— from citations to data.

**Step 1.** Claude extracts cases from the PDF reports to a CSV. In report no. 268, the text narrates **103 cases** with fields `Case`, `Start date`, `Type`, `Location`, `Case description`, and actors.

**Step 2.** Claude classifies each demand into categories (water, land and territory, local employment, revenue/compensation, prior consultation/procedures, breach of agreements).

**Step 3 — the heart.** Each participant **reads 20 cases by hand** and compares with Claude’s classification. How many are wrong? That error rate is a project datum, not an anecdote: if it’s 15%, you must say so in the paper.

**Step 4 — validation with the source. Here’s the exercise’s best surprise.**

Official figures for report no. 268 (June 2026), verified in the PDF:

| Official figure | Value |
|---|---|
| Conflicts recorded that month | **197** |
| Active / latent | 151 (76.6%) / 46 (23.4%) |
| In dialogue process | 90 |
| **Socio‑environmental** conflicts | **96** |
| Of those, **mining** | **61 cases = 63.5%** |
| Active with **no events** that month | **81** |

Monthly series of socio‑environmental conflicts, Jun‑2025 to Jun‑2026:  
`99, 100, 98, 98, 97, 99, 101, 99, 98, 98, 97, 98, 96`

**Naive extraction will NOT match — and that’s what’s valuable.** A straight extraction of `Type:` fields recovers ~103 cases and ~42 socio‑environmental ones, vs. the official **197 and 96**.

Why? Because the report **narrates in detail only the cases with new events that month**; the other 81 appear only in aggregate tables. The dataset built from running text covers **just over half the universe**.

A participant who doesn’t validate walks away with a biased dataset — overrepresents active, noisy conflicts — **and doesn’t know it**. In a paper, that bias is fatal.

::: NOTE TO THE INSTRUCTOR
Let them discover the discrepancy themselves. The moment someone says “I get 42 but the PDF says 96” is the session’s peak. Only then explain where the gap comes from.
:::

---

## 6. Methodological decisions to say out loud

**Why we’re not using the mining canon (revenue transfers).** It’s the ideal variable, but the Finance Ministry only exposes it in an early‑2000s ASP.NET frameset with postback navigation: there’s no programmatic export. We use **mining output and employment as a proxy**, which is defensible because the canon is 50% of the corporate income tax on mining companies distributed to producing areas.

Say it plainly: real research is full of substitutions like this, and what distinguishes good work isn’t avoiding them but **declaring them**. It’s noted in `notas/ideas sueltas.md`, where participants will find it on their own.

**Why there are no interviews.** We searched Harvard Dataverse, QDR, Zenodo, ICPSR, ALICIA, and PUCP’s repository: **there are no open‑access interviews on Peruvian mining**. The Ombudsman narratives serve that function and are exactly on topic.

**Why there’s no press.** La República’s `robots.txt` blocks by name `ClaudeBot`, `anthropic-ai`, and `GPTBot`; El Comercio forbids crawling of its historical archive. It’s the best concrete example that **“public” does not mean “reusable,”** and it’s worth showing on screen.

**About Congress’s API.** It’s public and doesn’t ask for authentication, but **it’s undocumented and unlicensed**. It can break without notice. Present it as such.

---

## 7. Before class

- [ ] Verify that the folder is on each participant’s computer (or cloned from the repo). **Do not rely on downloading it live.**
- [ ] Confirm `python3` with `pypdf`, `pandas`, and `openpyxl` installed.
- [ ] Keep a screenshot of each exercise’s expected result handy, in case a demo fails.
- [ ] Reminder: the data are already downloaded. `descargar-datos.sh` is for reproducibility, not for running in class.

