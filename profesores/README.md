# Claude Code for research in the social sciences

**Faculty workshop — Faculty of Social Sciences, PUCP**  
Alexander Quispe · [Q-LAB](https://qlab.pucp.edu.pe/), Laboratory of AI and Computational Methods in the Social Sciences

This document serves two purposes: as the session script and as a manual you can come back to. Everything here was tested in a real case — preparing a course, downloading its bibliography through the university library proxy, and auditing the citations — not a feature list copied from the docs.

## Workshop materials

| File | What it is |
|---|---|
| `sesion1-confianza.qmd` | Slides — Session 1: what it is and isn’t, safety, minimal terminal, `/init`, the citation trap, university library proxy |
| `sesion2-flujo.qmd` | Slides — Session 2: Plan Mode, `/deep-research`, from PDFs to a dataset, LaTeX, Whisper |
| `guia-ejemplo.md` | **Instructor’s guide** for the example project: answer key and gotchas |
| `notas-clases-ra.md` | Lessons from the pilot classes with Q‑LAB RAs |
| [`../ejemplo-mineria-conflicto/`](../ejemplo-mineria-conflicto/) | **The example project** used by participants |

### The example project

A ~41 MB folder with a real research project, half‑started and deliberately messy, on **mining and social conflict in Peru**. It exists because the exercises need real data, and because an anthropology professor shouldn’t have to arrive with a neat CSV.

> **The question:** in Peru’s mining departments, does mining revenue reduce
> social conflict — or does it mainly change what people protest about?

It combines **structured data** (mining output and employment from MINEM, dialogue tables and commitments from the Prime Minister’s Office, 251 congressional bills as JSON) with **unstructured text** (10 monthly Ombudsman reports, each with a narrative description per case). All sources were verified with real downloads in August 2026.

Details — what’s inside, the eight planted bibliography errors, technical traps, and the answer key — are in **`guia-ejemplo.md`**.

---

## 1. Claude Code, in one sentence

An agent that lives in your terminal, can see your files, and can run commands for you. It’s not a chat where you paste text: **it works inside your computer**.

That changes what you can ask. Instead of “write me a summary of this paper,” you ask “read the 40 PDFs in this folder, tell me which ones use panel data, and make a table.” The difference isn’t writing quality: it’s that it can open, count, compare, and write files.

### What it did in the real case I’ll show

In a real work session, for a theory course:

- Read the syllabus and verified **every citation** against Crossref, NBER, and arXiv.  
  Found **four wrong citations**, including one where the paper title didn’t exist and another where a coauthor was missing.
- Downloaded 28 papers, several through the university library proxy (PUCP).
- Wrote the syllabus in LaTeX, compiled it, and reviewed the resulting PDF.
- Built the course website and published it.
- Created the weekly assignments as GitHub issues.

None of that requires programming. It does require knowing **what to ask and how to verify**, which is what this workshop covers.

---

## 2. The workshop’s central idea

> **The most valuable thing the agent did wasn’t writing: it was finding errors.
> And it also made some.**

Both halves matter equally.

**It found real errors.** A paper cited in the syllabus as *“Coding Beyond Your Training”* turned out to be titled *“Agentic Delegation and the Language Frontier of Software Developers”*, to have a coauthor that wasn’t listed, and a sample of 5,346 observations instead of 5,838. Nobody had noticed.

**It made errors.** In that same work, the agent wrote down an invented DOI for a *Management Science* article. It was discovered only when trying to download it: the page failed. The correct DOI appeared by checking Crossref.

The practical conclusion for researchers: **the agent is excellent at verifying against sources and unreliable at recalling from memory.** Anything it produces “from memory” — a citation, a date, a page number — needs verification. Anything it verifies against a primary source, with a visible link, is solid.

---

## 3. Before class: what to install

Ask participants to arrive with this ready. It takes ~30 minutes and it’s better not to spend them in class.

| Tool | What for | Note |
|---|---|---|
| **Claude Code** | The agent | Instructions at [docs.claude.com/claude-code](https://docs.claude.com/en/docs/claude-code) |
| **Git** | Version control | On Mac it comes with Xcode Command Line Tools |
| **GitHub account** | Save and share work | With credentials configured |
| **Visual Studio Code** | Editor | Optional but recommended |
| **LaTeX** | Documents and presentations | MiKTeX on Windows; MacTeX or Tectonic on Mac |
| **Python 3** | Scripts and analysis | With `pypdf` or `pymupdf` to read PDFs |

**About LaTeX:** two paths. MacTeX or MiKTeX install everything (several GB).  
[Tectonic](https://tectonic-typesetting.github.io/) is a single binary that downloads each package the first time it’s needed. If you’ll compile rarely, Tectonic is much lighter.

### One-step verification

Have them open a terminal, type `claude`, and ask literally this:

> Check my environment: tell me which versions of git, python, and latex I have,
> whether my GitHub credentials are configured, and what I’m missing.

It’s the first exercise and the diagnostic at once. If something’s missing, the agent will usually tell them how to install it.

---

## 4. Safety rules, explained upfront

Say these at the start, or people will hit them and think the tool is broken.

### It will never type your password

**Claude Code does not enter passwords into login forms.** Not yours, not anyone’s. No matter if you hand it over, explicitly authorize it, or insist: it’s a no‑exceptions rule.

It also won’t create accounts, enter card details, or solve CAPTCHAs.

**This isn’t a roadblock: it’s a task‑split change.** The correct pattern:

1. **You** log in in the browser, once.
2. **The agent** works over that already‑open session.

It works just as well and takes thirty seconds. In the real case, that’s how six papers from subscribed sources were downloaded: the professor logged in; the agent did the rest.

### Other actions it will ask before doing

- Downloading files
- Accepting terms and conditions
- Sending emails or messages
- Publishing content
- Deleting or overwriting things

That’s healthy. When it asks, read what it’s about to do.

---

## 5. University library access (proxy)

This is what will help you most day to day — and what we discovered by trying.

### The entry point

Your university library has a proxy that logs you in once and lets subscribed journals open as if you were on campus. At PUCP that proxy is called **elogim**. The general URL is:

```
https://pucp.elogim.com/auth-meta/login.php?url=<PUBLISHER_URL>
```

Paste any journal URL after `url=` and, if the university has a subscription, it opens with institutional access. The proxy rewrites the host to `<resource>.pucp.elogim.com`.

Example, for a JSTOR article:

```
https://pucp.elogim.com/auth-meta/login.php?url=https://www.jstor.org/stable/2171832
```

### Three things that take a while to discover alone

**Your personal account is not institutional access.** If you log into JSTOR with your personal user, you’ll see “100 free articles this month” and will only be able to *read on screen*. The download button appears only under the university session. This is the most common mistake.

**The session is by cookie.** Any command‑line tool —`curl`, `wget`, a Python script— will receive the login page, not the PDF. It has to be a logged‑in browser. If you ask the agent “download this paper” and it uses `curl`, it will fail: tell it to use the browser.

**A server reply doesn’t mean there’s a subscription.** Testing, the INFORMS host responded perfectly… and the article asked for “Request Access”. PUCP doesn’t have *Management Science*. Verifying that the page loads isn’t enough: you must reach the PDF.

### What exists, and with what confidence

It helps to distinguish two levels — exactly the error the workshop itself trains you to avoid.

**Confirmed by downloading the full PDF** (Aug 2026): JSTOR, Science/AAAS, Wiley, AEA (AER, JEL, AEJ).

**Appears in the library catalog**, not confirmed to the PDF level:  
ACM Digital Library, ACS, AIP, American Physical Society, Annual Reviews,
APA PsycNet, Brill, Cambridge Core, De Gruyter, EBSCO, Edward Elgar,
ProQuest Ebook Central.

**Proxy server responds**, the weakest of the three:  
Emerald, IEEE Xplore, Nature, PNAS, Project MUSE, SAGE, ScienceDirect, Springer,
Taylor & Francis, Scopus, Web of Science. Treat it as a list of candidates to test, not confirmed subscriptions.

**Confirmed we do NOT have:** Management Science / INFORMS, and Oxford University Press (i.e., no QJE or Review of Economic Studies through this route).

### When there’s no access

There’s almost always an open version:

- **NBER, SSRN, arXiv, RePEc** — working‑paper versions
- **Institutional repositories** by the authors
- **Google Scholar** often shows a [PDF] link on the right

With one important caveat: **the working paper is not the published article**. In one case we found the SSRN version had one author and the final published one had two, and another where the title had changed completely. For citing, cite the published one; for reading, either is fine — but know which you have.

---

## 6. Exercises

Ordered from smaller to larger. Each one includes what to observe — that matters more than completing it.

### Exercise 1 — Environment diagnostics (5 min)

> Check my working environment and tell me what I have installed and what I’m missing.

**What to observe:** the agent runs commands and shows you what it does. It’s not answering from memory: it’s looking at your machine.

### Exercise 2 — Put a folder in order (10 min)

Have them use a real folder with downloaded PDFs and inconsistent names.

> In this folder there are article PDFs. Open them and rename them as
> lastName-year-keyword.pdf. Before renaming anything, show me the list
> of changes you plan to make.

**What to observe:** asking for the plan before execution is a good habit. And the agent reads the PDF content; it doesn’t guess from filename.

### Exercise 3 — The citation trap (15 min) ← the most important one

First part, without verification:

> Give me the full APA citation for Noy and Zhang’s paper on ChatGPT’s
> effects on productivity. Include volume, issue, pages, and DOI.

Second part:

> Now verify each element of that citation against Crossref and tell me
> exactly what was wrong.

**What to observe:** it’s very common that something is off — page range, year, DOI. And the very same agent detects it when asked to verify. **That’s the workshop’s central lesson:** it’s not about “lying”; memory and verification are two distinct modes, and you must explicitly ask for the second.

### Exercise 4 — Download from the library (15 min)

Have them log into the library portal first, in the browser. Then:

> I’m logged into the university library proxy. Find this article [DOI]
> and download it to the papers/ folder. If we don’t have access, tell
> me where else it can be obtained.

**What to observe:** the division of labor — they authenticate, the agent operates — and that the agent reports honestly when there’s no access, instead of inventing.

### Exercise 5 — A reproducible document (20 min)

> Take these data and build me a table in LaTeX, compile it to PDF, and
> show me the result. If something doesn’t compile, fix it and try again.

**What to observe:** the write–compile–review–fix loop without intervention. This is where the tool clearly departs from a chat.

### Exercise 6 — Git without fear (20 min)

> Create a repository for this project, make the first commit, create a
> branch called analysis, and explain in plain language what you just did
> and why.

**What to observe:** you can learn Git *by using it with an explaining agent*, instead of reading a tutorial first.

---

## 7. How to ask for things

Four habits that make almost all the difference.

**Ask for the plan before the action.** “Before doing anything, tell me what you’re going to do.” Especially when it will modify or delete files.

**Say where truth lives.** “Verify against the PDF in this folder,” “consult Crossref,” “check the official page.” An agent with an assigned source is far more reliable than one answering from memory.

**Ask it to show the work.** “Show me the command you used,” “paste the snippet you pulled that from.” Verifiable beats “correct.”

**When it’s wrong, say so directly.** No need to be diplomatic. “That’s wrong, the year is 2025” is the most efficient correction.

---

## 8. Common mistakes in the first sessions

**Treating it like a search engine.** “What do you think of theory X?” wastes the tool. It shines working over *your* files and *your* data.

**Accepting the first answer without looking.** Especially with numbers, citations, and dates.

**Asking for too much at once.** “Reorganize my whole project” goes poorly. “Rename these 12 PDFs with this criterion” goes well. Bounded tasks, verifiable one by one.

**Not using version control.** If the agent will touch files, put them under Git. Then every change is reversible and you see exactly what was modified.

**Insisting on passwords.** It won’t happen. Log in yourself.

---

## 9. Suggested session script

| Time | Block |
|---|---|
| 0:00–0:10 | What it is and isn’t. The real case as a demo |
| 0:10–0:20 | Safety rules. Why it won’t type passwords |
| 0:20–0:50 | Exercises 1 and 2: environment and folder |
| 0:50–1:10 | **Exercise 3: the citation trap.** The heart of the workshop |
| 1:10–1:30 | University library: the proxy, and exercise 4 |
| 1:30–1:45 | Exercise 5 or 6, depending on the audience |
| 1:45–2:00 | How to ask, common mistakes, Q&A |

If time shrinks, **exercise 3 is the one you cannot skip**. Everything else can be learned later; the verification habit cannot.

---

## 10. To continue after the workshop

Have them start with a real, small task from their own research. The ones that work best at first:

- Sort and rename a folder of accumulated PDFs
- Verify the bibliography of a paper in progress
- Extract a table from a PDF to CSV
- Turn notes into a formatted document
- Automate something they do by hand every week

What **not** to start with: asking it to rewrite an entire chapter, or to analyze data whose cleaning they cannot verify.

