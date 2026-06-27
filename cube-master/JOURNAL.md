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
| Commits       | ~159 (144 pushed on develop, GitHub API + ~15 local Spark cubemaster) |
| PRs merged    | 17                                                       |
| Issues closed | 11                                                       |
| Weeks active  | 7                                                        |
| Period        | Jan 26 — Jun 27, 2026                                    |

---

## Entries

### Week of Jun 22-28, 2026

> **cube-master** 24 commits | 1 PR merged — **Coach mode v1 merged & hardened**

**Worked on:**

- **PR #11 merged (Jun 22)** — Coach mode v1 went into `develop` (the build itself landed across the
  two prior weeks; see below). Live alongside Solver and Timer.
- **CI:** a Claude PR Assistant workflow (auto branch/PR/issue creation, `gh pr` permissions).
- **Post-review reliability pass:** wrapped the Coach route in a recovery `ErrorBoundary` and made
  "Réessayer" actually recover the route (not a no-op); fail loudly on out-of-range demo
  `groupIndex`; stopped a stale step index from auto-completing the next chapter; degrade milestone
  computation to solved cubes on failure.
- **Router/storage hardening:** decode percent-encoded route params in `matchRoute` (guarded against
  malformed encoding), gate the storage version-mismatch warning behind `import.meta.env.DEV`.
- **Perf + tests:** prewarm the milestone cache during idle so the first lesson opens unblocked;
  cover the LessonPlayer last-step navigation fork and the milestone degrade-on-throw fallback.
- **Refactor/docs:** extract shared `applySeq` into teaching helpers; capture Coach reactive-store
  render/effect hazards and the LessonPlayer sibling-effect ordering contract as solution docs.

**Learned:**

- A reactive lesson store needs explicit guards at its seams — out-of-range demo indices, stale step
  indices, and milestone-compute failures each had to degrade or fail loudly rather than silently
  corrupt lesson progress.

**Blockers:**

- None — Coach v1 is live; what's left of the original "beginner → advanced" promise is the advanced
  tutorials (the beginner layer-by-layer method is taught end to end).

---

### Week of Jun 15-21, 2026

> **cube-master** 38 commits — **the heart of the Coach v1 build** (PR #11 opened Jun 21)

**Worked on:**

- **The teaching solver** (`packages/cube-engine` teaching layer) — a pure-TS sibling to the Solver
  that shares none of its phases: `planWhiteCorners`, a second-layer planner (two inserts, four
  slots), and last-layer planners with a corner-safe edge 3-cycle. Fails loudly on incomplete plans
  and verifies each milestone.
- **Chapters 2–7 reworked onto the teaching solver** — explicit per-case demos, chained milestones,
  French gesture badges, single-insert Ch3 demos, orientation-safe corner placement on a yellow-down
  frame. Promoted `white-cross-flip` and `ua-perm` into the algorithm catalog.
- **Milestone-demo model + interactive practice** (per-chapter practice from the previous milestone).
- **CubeNet visuals finished** — fluid `rem` sizing (viewport units collapsed at 13"), ruwix-style
  band move-arrows, dim-veil highlights, stacked mobile layout to kill horizontal scroll.
- **Docs:** placement-pedagogy brainstorm/plan + TS-0 feasibility, the teaching-solver ADR, and
  solution docs for cross-browser CubeNet sizing, the move-arrow band model, and yellow-down framing.

**Learned:**

- The teaching solver had to be a **separate** pure-TS module from the Solver phases — keeping lesson
  moves on their own deterministic planners is what stops them drifting as the Solver evolves.
- Teaching the layer-by-layer method reads better on a **fixed, no-rotation frame** (flat CubeNet,
  white-up/green-front) than on a free-rotating 3D cube.

**Blockers:**

- None

---

### Week of Jun 8-14, 2026

> **cube-master** 18 commits | 1 PR merged — harness doctrine + Coach groundwork & proof slice

**Worked on:**

- **PR #10 — Heart of Gold harness doctrine:** adopted the AGENTS.md + docs taxonomy (the same
  workflow baseline used to ship grimoire-arch), giving Coach v1 a place to land its ADRs, stories,
  and solution docs as the work happened.
- **Coach planning:** brainstorm, v1 stories + architecture, the build plan, and ADR 0006
  (algorithm catalog in the domain layer).
- **Shared groundwork:** an in-domain algorithm catalog (consumed by the Solver), a versioned
  localStorage helper, and single-segment param matching for the hand-rolled router.
- **Coach proof slice:** the Second Layer slice (lesson model, store, player), then the White Cross
  and White Corners chapters — replacing the old "Coming soon" stub with a functional lesson browser.

**Learned:**

- Laying the harness doctrine and a proof slice down first meant the rest of Coach built on a
  verified vertical rather than a guess — the Second Layer slice proved the lesson/store/player shape
  before the other chapters were authored.

**Blockers:**

- None

---

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
