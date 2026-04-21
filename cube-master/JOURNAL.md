# CubeMaster — Development Journal

## How to use this file

Log your progress here. Each entry should include:

- **Date**
- **Time spent** (approximate)
- **What you worked on**
- **What you learned/discovered** (optional but valuable)
- **Blockers** (if any)

Don't overthink it. Short entries are fine. The goal is to have a record you can look back on.

---

## Cumulative Stats

| Metric        | Total                                                    |
| ------------- | -------------------------------------------------------- |
| Commits       | ~116 (101 pushed + ~15 local Spark cubemaster)           |
| PRs merged    | 13                                                       |
| Issues closed | 0                                                        |
| Weeks active  | 5                                                        |
| Period        | Jan 26 — Apr 7, 2026                                     |

---

## Entries

### Week of Apr 6-12, 2026

> **cube-master** 14 commits | 2 PRs merged

**Worked on:**

- **PR #8:** Solver solution view — PhaseList and StepControls components, MoveGroup type for step-by-step navigation, D-face sticker mapping fix, theme color adjustments
- **PR #9:** Fly.io deployment — fly.toml, /health endpoint, Dockerfile, renamed fly.toml to fly-web.toml for GitHub integration

**Learned:**

- Fly.io deployment required renaming fly.toml to fly-web.toml — GitHub integration expects a specific config path
- Step-by-step solution navigation needed a MoveGroup abstraction to group moves by solver phase

**Blockers:**

- None

---

### Week of Mar 30 - Apr 5, 2026

> **cube-master** 50 commits | 6 PRs merged — **rubiks-cube-solver-codespace** 5 commits | 1 PR merged

**Worked on:**

- **cube-master — full project launch from scratch in one week:**
  - **PR #1:** Astro replaced with Hono + Vite SPA — client-side router, Layout, pages, App root
  - Cube engine built: 3x3 domain model, permutation tables for 6 base moves, applyMove/applyMoves, invertMoves, reconstructState, generateScramble
  - **PR #2:** Interactive CubePlayground with MoveControls, ActionBar, MoveHistory, cube state store (nanostores)
  - **PR #3:** Scramble generator wired into playground
  - **PR #4:** Timer mode — session store with persistence, timer loop hook, ScrambleDisplay, TimerDisplay, SolveHistory, StatsPanel
  - **PR #5:** Solver input UI with color painting, validation, and cube state reconstruction
  - **PR #6:** Solver algorithm engine — white cross, white corners, second layer edges, yellow cross, yellow layer (BFS), benchmark script
- **rubiks-cube-solver-codespace:** move token types, isFaceMove guard, permutation tables, applyMove/applyMoves (domain layer parity with cube-master engine)

**Learned:**

- Building the full cube solver (white cross -> yellow layer) in a few days proved the hexagonal/domain-first approach — engine has zero UI dependencies, solver is pure functions over the domain
- BFS for the yellow layer phase works but is brute-force — good enough for 3x3, would need Kociemba-style pruning for speed
- Hono + Vite as Astro replacement gives full control over SSR/SPA split — simpler mental model for a client-heavy app

**Blockers:**

- None

---

### Week of Mar 23-29, 2026

> **rubiks-cube-solver-codespace** 16 commits | 3 PRs merged

**Worked on:**

- **Project restructuring:** PRD written, feature shapes added (design system as Feature 01), README rewritten, PROGRESS.md with milestone tracking
- **Tooling migration:** npm → Bun, Prettier configured
- **PR #2 — Design system migration:** DaisyUI + Radix Dialog installed, custom "rubiks" dark theme (OKLch colors), cube-specific color tokens (`bg-cube-*`), all cube components migrated to semantic HTML (figure/figcaption, aria-labels, role="img"), app layout with navbar and About dialog via DialogShell
- Accessibility expanded: semantic HTML, ARIA labels, AAA contrast tracking added to PROGRESS.md
- Copilot review feedback addressed (button types, dialog props, README format)

**Learned:**

- Applying the same DaisyUI migration pattern from car-cost-tracker to a different project confirms the approach is portable — custom theme + semantic tokens + Radix primitives
- OKLch color space for theme definition produces more perceptually uniform colors than hex/HSL
- Cube sticker colors as custom Tailwind tokens (`bg-cube-white`, `bg-cube-red`, etc.) decouple visual representation from theme — cube colors stay fixed while UI theme can change

**Blockers:**

- None

---

### Week of Feb 2-8, 2026

> **rubiks-cube-solver-codespace** 2 commits — **road-to-six** 1 PR merged

**Worked on:**

- CubeMaster officially added as the 6th project in Road to Six (Semester 2)
- PR #1 merged on Feb 7 in the road-to-six meta-repo
- **rubiks-cube-solver-codespace:** 2 commits on Feb 2 (Cube type scaffolding continuation)

**Learned:**

- Having a "Bone Pile" philosophy works — the Spark frustration and the clean restart proved enough interest to promote CubeMaster from experiment to Tier 1

**Blockers:**

- None

---

### Week of Jan 26 - Feb 1, 2026

> **cubemaster** ~15 local commits (never pushed) — **rubiks-cube-solver-codespace** 11 commits

**Worked on:**

- **Jan 26 — The Spark AI session (cubemaster repo):** Attempted to build a Rubik's Cube solver using Spark AI. What started as an exploration turned into a legendary frustration session. The AI-generated solving algorithm claimed "SOLVED" but the cube absolutely wasn't. Color placement was wrong, move notation was broken, one-move-away test patterns generated absurd 22-move sequences. The commit messages tell the story better than any journal entry ever could.
- **Jan 28-29 — Clean restart (rubiks-cube-solver-codespace repo):** After the Spark disaster, started fresh with React + Vite. Proper approach this time: wrote a vision document outlining goals, architecture, and implementation plan. Added Cube type definitions with initial tests for color, face, corner, and edge positions. Set up vitest as test runner.

**Learned:**

- AI code generation (Spark) without understanding the domain leads to frustrating dead ends — especially for algorithmic problems like cube solving (Kociemba, CFOP)
- Starting over with a clear vision document and proper tests is infinitely better than patching broken AI-generated code
- The emotional rollercoaster of "this AI will solve it for me" -> "WHY IS NOTHING WORKING" -> "ok let me do this properly" is a valuable lesson in itself
- Rubik's Cube solving algorithms are genuinely complex — not something to vibe-code through

**Blockers:**

- The Spark-generated algorithm was fundamentally broken (wrong solution validation, incorrect move notation, bad state representation)
- Abandoned the cubemaster repo entirely in favor of rubiks-cube-solver-codespace

---

_Add new entries above this line, newest first._
