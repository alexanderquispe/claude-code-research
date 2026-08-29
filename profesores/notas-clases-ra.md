# Notes from the RA classes → improvements for the faculty workshop

Source: Whisper transcriptions from the two classes taught to Q‑LAB RAs
(Aug 17–18, 2026, ~97 min + ~86 min). Timestamps `[MM:SS]` refer to
`transcripts/clase1-*.txt` and `clase2-*.txt` (local, not versioned).
New audience: faculty at the School of Social Sciences, 2 sessions × 3 h,
**assuming no terminal, Git, or markdown**.

---

## 1. Structural finding: time calibration

- Day 1 material ran out in ~59 minutes of a class planned for 2 h
  (C1 [60:07] *“I ran out… I thought it’d take longer”*); the ~38 minutes
  left were improvised with Day 2 material (MCPs).
- Class 2 finished ~15 minutes early (C2 [77:03]).
- **Implication for faculty:** with a non‑technical audience the pace will be 2–3×
  slower (install, terminal, new concepts). For 3 h: plan ~2 h of core content
  + 45 min guided exercises + buffer. Each block with a “natural cutoff” so you
  can extend or skip without improvising.

## 2. Startup friction (first 15 minutes of C1)

What happened: links that didn’t load [00:25–00:48], sharing the screen twice
[00:56, 11:32], computers setting up during class [00:19], a 30,000‑file demo repo
that never finished cloning and had to be swapped live [10:37–13:55] (confirmed
by the automatic feedback: *“you picked a repo too large for the demo”* C2 [64:14]).

**For faculty:**
- One short URL **on the board/handout**, tested beforehand.
- Demo repo/folder **small and pre‑cloned** (and a local copy in case there’s no internet).
- 5‑minute AV checklist before starting: shared screen, terminal zoom, large font.

## 3. Product confusion — the block to watch most

- Even the RAs confused Claude AI / Cowork / Code (C1 [03:20–03:25]);
  you yourself anticipated: *“when you help set up professors, I want you to
  explain this”* [03:05] and *“professors will say: I already use Claude,
  why do I need you to install things?”* [03:10].
- Familiar analogies worked very well live and must be kept:
  the fashion‑designer mom with Cowork [04:24], the condo maintenance uncle
  who went from Excel‑only to Cowork (C1 [76:50]).
- Constraint confirmed in class: **Cowork requires a subscription ($20+)**;
  **Claude Code runs with an API key** [04:52–05:15] — it’s already in the RA slides;
  for faculty give it its own slide with the practical decision (“what do I buy?”).

## 4. Terminal: minimum viable + rescue kit

- What worked: reducing bash to **one command** (`cd` + paste path with
  VS Code’s *copy path*) [14:44–15:38]; the *new terminal window* tip (and that you
  sometimes have to open terminal once before it shows up) [11:57–12:52].
- ⚠️ Fix in the new slides: it was said *“CD is current directory”*
  [15:22] — it’s **change directory**. Minor, but faculty will copy it verbatim.
- What was missing and needed live: a student got trapped in the wrong folder and we
  had to rescue them with Ctrl+C ×2 dictated out loud [47:24–48:04].
  **For faculty: a “rescue kit” slide**: <kbd>Esc</kbd> interrupts,
  <kbd>Ctrl+C</kbd> ×2 exits Claude, how to resume (`claude --resume`, shown
  at [59:29]), and “if all else fails, close the terminal and open another.”
- A didactic moment worth replicating on purpose: you didn’t know how to view
  hidden files on Mac and **asked Claude with a screenshot**
  (Cmd+Shift+. appeared instantly) [30:33–32:58]. Explicit message for faculty:
  *“use Claude to solve your doubts about Claude and your computer.”*

## 5. Models and costs: give ONE rule

The automatic feedback flagged it as contradictory (C2 [64:27]): first
“Sonnet is cheap and good for code and will last longer” [19:18], then
“I barely use Sonnet; I use Opus and Fable” [19:47].

**For faculty, one actionable rule:** *do everything with Opus; Fable only for
fine paper writing (and know it caps quickly); ignore the rest of the menu.*
With the API price table next to it ($/M tokens) and the reminder of `/model` to
check what’s selected [18:39–20:14].

## 6. What worked and must be kept (pedagogical core)

1. **`/init` over a real, messy folder** — the demo landed well and the instruction
   “enter your thesis folder, even if it’s messy, it’s fine” connected
   [28:03–28:27]. For faculty: “bring a real folder from your research.”
2. **Memory hierarchy** explained as user → project → subfolder,
   with the live example of creating `~/.claude/CLAUDE.md` (“always Python”)
   [29:00–35:38]. Keep the nested‑boxes diagram from the RA slides.
3. **Plan mode with a real case** (review notebooks from an old course)
   [40:00–46:36] — though there was a stumble switching modes with Shift+Tab
   [43:41–44:51]: **rehearse the mode sequence beforehand**, and in the
   faculty slides show the bottom bar with a screenshot (“this is how it looks in
   plan mode”).
4. **`/compact` with the analogy** “100 pages → 10 that say the same thing”
   [63:20–63:26] and the corner warning “about to hit the context limit” [63:56].
5. **The Whisper → Claude pipeline was Class 2’s wow moment**: 97 minutes of
   video transcribed in 90 seconds [52:49–53:01] and Claude critiquing your own
   class live [63:45–65:00]. It’s THE closing demo for faculty: “record your
   classes/seminars and turn them into working material.” Before running, you
   taught asking Claude about the machine specs (GPU/CPU/RAM)
   [46:18–47:16] — keep that step. (Minor precision: Apple Silicon does have
   integrated GPU; avoid “Macs don’t have GPUs, they have cores/MCMs” [52:18].)
   For Windows: faster‑whisper [66:47].
6. **Dashboard with the dataviz skill** over real thesis data
   [28:26–30:14, 54:00] and sharing by link. Remember the step that failed live:
   you must set *share → anyone with the link* before sending it
   [54:51–55:10].
7. **“PowerPoint has no code; LaTeX is code”** [84:21–84:35] — central
   argument for faculty, with the ≤15‑slide Beamer demo for Thesis 1
   [74:15–74:52]. Requires asking for LaTeX installation BEFORE (you reminded
   yourself at [37:44]); the workshop README already solves it with MiKTeX/Tectonic.
8. **The framing “you are research leads with assistants”** — one session per
   task (literature / data / writing) distributing like to assistants
   [15:08–15:31]. Excellent metaphor for professors advising theses.

## 7. `/deep-research`: clarifications for the new class

- In class it was called “Deep Search” the whole time and the first attempt **failed
  because it was asked in prose**: *“what do you mean you didn’t do DeepSearch?…
  it’s a workflow, not a command”* (C2 [10:28–11:16]). In the faculty slides:
  the exact command is **`/deep-research <question>`** with the slash, and it’s
  already correct in the RA deck.
- The mechanism explanation (fan‑out → fetch → voting → report) landed well
  [06:59–07:55]; the real run took 15–20 minutes and you managed it by alternating
  tasks — for faculty: **launch it at the start of the block** and review the
  result at the end (also teaches that it runs in the background).
- The recipe to teach: *“use deep‑research + create me a folder and download
  the related papers”* [08:29–09:05] — the papers ended up organized by thematic
  blocks and citable [56:30–58:00].
- Student question faculty will repeat: “it gets working papers; what about published ones?” [58:09].
  The right answer for PUCP is the **library proxy (elogim)** — already documented
  in `profesores/README.md` §5. Avoid the Anna’s Archive tangent that came up
  in class [58:52–60:04] (Claude itself flagged it as a copyright violation).
- A limit you noted — and that matters a LOT in the social sciences: for **books**
  (anthropology, sociology) it helps little [60:26–60:39]. Say it plainly and
  connect to the library.

## 8. Plan B for demos that depend on the internet

The INEI/ENAHO website went down mid‑demo and killed every attempt
(direct web, R library, Python package — all depended on the same site)
[16:33–27:03]; it was salvaged by using the student’s already‑cloned clean data. There
was also a Claude “AP error” with ~6 dead minutes [77:23–79:45], and Ctrl+B
(background) had changed versions since you last used it [81:15–81:52].

**Workshop rule:** every demo has (a) inputs already downloaded locally,
(b) a screenshot or short clip of the expected result as backup, and
(c) nothing essential depends on a live external website. Also assume the
tool changes quickly: teach principles (the slides) and re‑check commands
the day before.

## 9. What NOT to teach faculty (decisions made on audio)

- **GitHub MCP / pull requests / issues**: your own doubt live — *“I’m not sure
  I want to teach PRs to profs; they’d need to know what GitHub is”* (C1 [86:03]).
  Also the merge was blocked by guardrails and consumed ~10 minutes of friction
  [82:47–88:53]. Keep it out of the faculty session; RAs can provide Git support after.
- **Custom multi‑agents/sub‑agents**: only mention that it happens automatically [96:49].
- **`--dangerously-skip-permissions`**: tell it as a risk anecdote
  (the story of the friend whose “files got touched” [57:41–57:57]) but do not
  teach it as practice.
- **WhatsApp MCP**: a fun anecdote [67:15–68:13], not an exercise.

## 10. Suggested skeleton for the 2 faculty sessions (3 h each)

Cross what worked with the RAs with the script in `profesores/README.md`:

**Session 1 — Trust and verification (3 h)**
1. What it is and isn’t: AI / Cowork / Code + prices, with the familiar analogies (30')
2. Safety rules: passwords, permissions, the “you log in, it works” pattern (20')
3. Verified setup with the README’s diagnostic exercise (“check my environment”) (30')
4. Minimal terminal: cd + copy path + rescue kit + `/init` over a real folder (45')
5. **The citation trap** (README exercise 3 — the heart) (30')
6. University library: elogim proxy + download a real paper (25')

**Session 2 — The research flow (3 h)**
1. Recap + plan mode with a real case (30')
2. `/deep-research` launched at the start, explained while it runs (30')
3. Local data → shareable dashboard (40')
4. Literature review → LaTeX → Beamer compiled (40')
5. Whisper: transcribe a class/seminar and ask for feedback (the wow moment) (30')
6. How to ask for things + common mistakes + next steps (README §7–8) (20')

## 11. Errata to fix when building the faculty slides

| Said in class | Should say |
|---|---|
| “CD is current directory” [C1 15:22] | `cd` = **change directory** |
| “Deep Search” (plain) | `/deep-research` (slash command) |
| Sonnet is cheap/lasts longer *and also* “I only use Opus/Fable” | One rule: Opus for everything; Fable only fine writing |
| “Macs don’t have GPUs; they have cores/MCMs” [C2 52:18] | Apple Silicon ships an integrated GPU (MLX uses it) |
| Anna’s Archive as a way to get papers [C2 58:52] | University library proxy (elogim) + open versions (NBER/SSRN/arXiv) |

