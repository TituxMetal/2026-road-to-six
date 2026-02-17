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

| Metric        | Total                                                  |
| ------------- | ------------------------------------------------------ |
| Commits       | ~20 (across cubemaster + rubiks-cube-solver-codespace) |
| PRs merged    | 1 (road-to-six meta-repo)                              |
| Issues closed | 0                                                      |
| Weeks active  | 2                                                      |
| Period        | Jan 26 — Feb 7, 2026                                   |

---

## Entries

### Week of Feb 3-9, 2026

> **road-to-six** 1 PR merged

**Worked on:**

- CubeMaster officially added as the 6th project in Road to Six (Semester 2)
- PR #1 merged on Feb 7 in the road-to-six meta-repo

**Learned:**

- Having a "Bone Pile" philosophy works — the Spark frustration and the clean restart proved enough interest to promote CubeMaster from experiment to Tier 1

**Blockers:**

- None

---

### Week of Jan 26 - Feb 1, 2026

> **cubemaster** ~15 commits | **rubiks-cube-solver-codespace** 5 commits

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
