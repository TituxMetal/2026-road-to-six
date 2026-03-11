# Claude Code Tool Kit — Development Journal

## How to use this file

This journal tracks the evolution of the **claude-code-tool-kit** — the methodological backbone
powering all Road to Six projects. Skills, coaching agents, hooks, commands, and configuration
that structure the "Learn By Doing" workflow.

**Repo:** [TituxMetal/claude-code-tool-kit](https://github.com/TituxMetal/claude-code-tool-kit)

---

## Cumulative Stats

| Metric        | Total                 |
| ------------- | --------------------- |
| Commits       | 46                    |
| PRs merged    | 19                    |
| Issues closed | 1                     |
| Weeks active  | 6                     |
| Period        | Jan 25 — Mar 11, 2026 |

---

## Entries

### Week of Mar 10-11, 2026 (partial)

> 2 commits | 1 PR merged

**Worked on:**

- **PR #37:** coaching-review agent strengthened with correctness and coherence checks — catches logic errors, not just style
- Ship-scanner gained 4 new convention checks (CS-7 through CS-10) based on real-world patterns encountered during car-cost-tracker development

**Learned:**

- Agent rules need to evolve from real usage — the new scanner checks came directly from patterns that slipped through in actual PRs
- Correctness checks (does the code do what it says?) are more valuable than style checks in code review

**Blockers:**

- None

---

### Week of Mar 3-9, 2026

> 5 commits | 2 PRs merged

**Worked on:**

- **PR #34:** Feature-shape template enhanced with UI Reference section and Design System guidance — born from the car-cost-tracker DaisyUI migration experience
- **PR #36:** `/coach` command removed entirely, `/start` made the single entry point for all sessions. Simplified the command surface: fewer commands = less confusion for the AI
- References and install counts updated after /coach removal

**Learned:**

- Having too many entry-point commands (`/start`, `/coach`, `/coaching`) confused the AI about which to use — consolidating into one eliminates that ambiguity
- Adding a UI Reference section to feature shapes forces design decisions to happen during planning, not during implementation

**Blockers:**

- None

---

### Week of Feb 24 - Mar 2, 2026

> 7 commits | 2 PRs merged | 1 issue closed

**Worked on:**

- **PR #32:** Autonomous coaching pipeline — `/coach` command with context and auditor sub-agents for self-audit
- **PR #33:** `/ship` post-implementation shipping pipeline with 4 sub-agents: ship-scanner (convention violations), ship-planner (atomic commit sequence), ship-verifier (test/typecheck/lint/format), ship-progress (PROGRESS.md updates)
- Ship pipeline fixes: commit planning and progress update issues resolved

**Learned:**

- Breaking the shipping process into 4 specialized agents (scan -> plan -> verify -> progress) mirrors a real CI/CD pipeline but with human-in-the-loop approval
- The coaching pipeline's self-audit step catches issues before the human sees them — reduces review friction

**Blockers:**

- None

---

### Week of Feb 9-15, 2026

> **claude-code-tool-kit** 25 commits | 14 PRs merged

**Worked on:**

- **Hooks system launched:** commit-validator, code-guardian, task-checker — injected into settings.json at install time via jq
- Fixed hooks: `git diff HEAD` to catch both staged and unstaged changes, reduced false positives in commit-validator and code-guardian
- **Pragmatic review:** added code-review-pragmatic skill, fixed subagent type, removed non-standard frontmatter fields
- YAML frontmatter added to 4 skills that were missing it
- **Coaching refinements:** pattern verification in agents, git-workflow integrated into coaching checkpoint, clarified test scaffold replication scope, MODE OVERRIDE refinement (autonomy granularity, cleanup ownership, agent clarity)
- CLAUDE.md: simplified coaching section to reduce instruction dilution, updated AugsterSystemPrompt tool references for Claude Code, fixed typos and formatted tool names with backticks
- Plan template fix: resolved nested code blocks issue
- Documentation: hooks system section added to CLAUDE.md, README updated with architecture and hook flow diagrams

**Learned:**

- Hook injection at install time (via jq into settings.json) is elegant but requires jq as a dependency — worth the trade-off
- Reducing instruction "surface area" in CLAUDE.md (fewer conflicting directives) measurably improves AI behavior
- False positives in commit-validator were caused by overly strict pattern matching — loosening the rules paradoxically improved quality

**Blockers:**

- None

---

### Week of Feb 2-8, 2026

> **claude-code-tool-kit** 5 commits

**Worked on:**

- **Major coaching rewrite:** mode override system, agent orchestration with 3 specialized agents (scaffold, guide, review)
- Agents directory support added to installer
- Documentation updated: CLAUDE.md and README refreshed with agents and coaching rules

**Learned:**

- Splitting coaching into 3 agents (scaffold creates structure, guide provides examples, review checks quality) mirrors a real pair-programming workflow
- The mode override concept allows switching between "coaching" (human writes code) and "autonomous" (AI writes code) without changing the overall methodology

**Blockers:**

- None

---

### Week of Jan 19-25, 2026

> **claude-code-tool-kit** 1 commit (creation)

**Worked on:**

- **Repository created on Jan 25** with initial commit: skills, commands, and configuration
- This is the birth of the tooling that structures all of Road to Six: code-style rules, git-workflow, coaching methodology, feature-shape planning, frontend and backend architecture patterns

**Learned:**

- Centralizing Claude Code configuration into a reusable toolkit means every new project starts with the same quality bar
- Skills as YAML-frontmatter markdown files are a clean, portable format

**Blockers:**

- None

---

_Add new entries above this line, newest first._
