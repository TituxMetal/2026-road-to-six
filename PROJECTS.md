# Projects — Status Dashboard

Live snapshot of all Road to Six tracked projects. For the why and the philosophy, see
[README.md](./README.md).

_Last updated: 2026-06-10_

---

## Status taxonomy

The status is the **furthest milestone reached**, not the current activity — activity lives in each
`JOURNAL.md`. A status climbs; it never falls back.

- **🌰 Seed** — declared on the challenge, still holds a legacy `MVP.md`, not yet brainstormed into
  the incubator
- **🌱 Germinating** — brainstormed in the incubator (new workflow), goals extracted to its
  `README.md`, not really started
- **🌿 Growing** — actively built, lives in `MBP/AAAAMMJJ-name/`, GitHub activity, JOURNAL kept
- **🚀 Released** — a release is live, but the original objective is **not** met (< 100%)
- **✅ Shipped** — live **and** the original objective is met (100%)
- **🪦 Abandoned** — explicitly dropped (none currently)

> `Released → Shipped` when completion reaches 100% (98% is still Released). The completion `%` is
> the barrier; per-project detail lives in each project's `README.md` scorecard.

---

## Tier 1 — Semester 1 (January → June)

| Project            | Status                  | Live                                             | Last activity                                                  |
| ------------------ | ----------------------- | ------------------------------------------------ | -------------------------------------------------------------- |
| Trading Journal    | 🌰 Seed                 | —                                                | —                                                              |
| Car Cost Tracker   | 🚀 Released             | [cost-log.tuxlab.fr](https://cost-log.tuxlab.fr) | [Week of Apr 27 - May 3, 2026](./car-cost-tracker/JOURNAL.md)  |
| ForkliftFleetCheck | 🌰 Seed                 | —                                                | [Week of Jan 5-11, 2026](./forklift-fleet-check/JOURNAL.md)    |
| PIF Is Fake        | ✅ Shipped              | [pif.tuxlab.fr](https://pif.tuxlab.fr)           | [Week of May 4-10, 2026 _(partial)_](./pif-is-fake/JOURNAL.md) |
| grimoire-arch      | 🚀 Released             | [tituxmetal.github.io/grimoire-arch](https://tituxmetal.github.io/grimoire-arch/) | [Week of Jun 1-7, 2026](./grimoire-arch/JOURNAL.md) |

> ForkliftFleetCheck is **Seed**, not started: the repo was scaffolded from `sample-project` on
> Jan 7 with one motivation-init commit and nothing inside, then never touched. It keeps its legacy
> `MVP.md` until a real start. The earlier Spark prototype (FleetChariot, listed in
> [README → Prototypes](./README.md#prototypes-spark)) is separate and predates Road to Six.

> grimoire-arch was unplanned — a FR Arch Linux wiki (Astro Starlight, GitHub Pages) built and
> shipped in early June with the new workflow. It is **Released** (~60%): Act I (the published wiki)
> is live, Act II (devbox migration, ~July 2026) is ahead. It carries a
> [README](./grimoire-arch/README.md) scorecard, no legacy `MVP.md`. Listed in Semester 1 like PIF
> Is Fake: Road to Six tracks what gets built, not the launch list.

## Tier 1 — Semester 2 (July → December)

| Project          | Status                 | Live                                                | Last activity                                      |
| ---------------- | ---------------------- | --------------------------------------------------- | -------------------------------------------------- |
| Portfolio + Blog | 🌰 Seed                | —                                                   | —                                                  |
| GuardStore       | 🌰 Seed                | —                                                   | —                                                  |
| CubeMaster       | 🚀 Released            | [cube-master.fly.dev](https://cube-master.fly.dev/) | [Week of Apr 6-12, 2026](./cube-master/JOURNAL.md) |

> CubeMaster started early as a graduated Bone Pile project (Jan 26). 64 commits and 8 PRs merged
> on the active [cube-master](https://github.com/TituxMetal/cube-master) repo (develop), deployed to
> [cube-master.fly.dev](https://cube-master.fly.dev/) on Apr 7 (Solver + Timer + playground, live).
> Now **Released** (~70%): Coach is the remaining mode, a resume planned via the new workflow.
> Earlier work on the abandoned `rubiks-cube-solver-codespace` and Spark cubemaster repos is
> documented in [cube-master/JOURNAL.md](./cube-master/JOURNAL.md).

## Méta projets

These aren't Tier 1 themselves, but they support the system.

| Project              | Role                                                                                                               | Last activity                                               |
| -------------------- | ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------- |
| claude-code-tool-kit | Methodology backbone (skills, hooks, agents) — tracked in [claude-project/JOURNAL.md](./claude-project/JOURNAL.md) | [Week of Apr 27 - May 3, 2026](./claude-project/JOURNAL.md) |
| 2026-road-to-six     | This repo — accountability system, journals, project READMEs                                                       | (continuous)                                                |

## Bone Pile

The Bone Pile is described in [README.md → The "Bone Pile"](./README.md#the-bone-pile). PIF Is Fake
bypassed the pile and shipped directly to Tier 1 — no other bones formally tracked at this time.

---

## Completion (Released / Shipped projects)

Per-project completion against each project's definition of done (see its `README.md`).

| Project          | Completion | Complexity | Status      |
| ---------------- | ---------- | ---------- | ----------- |
| PIF Is Fake      | 100%       | 4/10       | ✅ Shipped  |
| Car Cost Tracker | ~80%       | 7/10       | 🚀 Released |
| CubeMaster       | ~70%       | 6/10       | 🚀 Released |
| grimoire-arch    | ~60%       | 6/10       | 🚀 Released |

> Complexity-weighted average completion: **~76%** — each project's `%` is weighted by its
> complexity, so ~80% of a 7/10 counts more than 100% of a 4/10. The weight keeps the dashboard
> honest: the hard, nearly-done builds carry more than the easy, finished ones.

## Monthly pulse

A trend, not a journal — the weekly detail lives in each `JOURNAL.md`. Numbers from
`scripts/weekly-stats.sh`.

> **Jun 2026 (to date): 24 commits · 0 PRs** (−30 commits · −4 PRs vs May) — **May 2026: 54
> commits · 4 PRs · 4 issues**. June so far is grimoire-only (shipped Jun 3).

---

## Roll-up Stats

Aggregated across all `JOURNAL.md` files at the date above.

| Metric                           | Value                                                                            |
| -------------------------------- | -------------------------------------------------------------------------------- |
| Tier 1 shipped (100%)            | 1 (PIF Is Fake)                                                                  |
| Tier 1 released (live, < 100%)   | 3 (Car Cost Tracker, CubeMaster, grimoire-arch)                                  |
| Tier 1 growing / germinating     | 0 / 0                                                                            |
| Tier 1 seed                      | 4 (Trading Journal, ForkliftFleetCheck, GuardStore, Portfolio + Blog)           |
| Total commits (Tier 1)           | 341 (car-cost-tracker) + 49 + 64 + 1 + 24 = **479**                              |
| Total commits (méta)             | 62 (claude-code-tool-kit)                                                        |
| Total PRs merged (Tier 1 + méta) | 47 (car-cost-tracker) + 4 + 8 + 0 + 0 + 21 = **80** (grimoire shipped direct-to-main) |
| First journal entry              | Jan 5, 2026 (car-cost-tracker, forklift-fleet-check)                             |
| First Tier 1 live                | Apr 7, 2026 (CubeMaster)                                                         |
| Most recent Tier 1 live          | Jun 3, 2026 (grimoire-arch)                                                      |

> Roll-up counts are recomputed manually from each project's `Cumulative Stats` table and may drift
> between updates — the source of truth is each `JOURNAL.md`. The Completion and Monthly pulse blocks
> above are sourced from `scripts/weekly-stats.sh` and the per-project README scorecards.
