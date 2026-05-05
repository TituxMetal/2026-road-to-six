# Projects — Status Dashboard

Live snapshot of all Road to Six tracked projects. For the why and the philosophy, see
[README.md](./README.md).

_Last updated: 2026-05-05_

---

## Status taxonomy

- **📝 Spec drafted** — `MVP.md` written with substantial content
- **📋 Spec stub** — `MVP.md` exists but is mostly TODOs, not yet matured
- **🌱 Initialized** — repo created, scaffold pushed, no product code yet
- **🚧 In progress** — active development
- **⏸ Paused** — repo with real product code, currently inactive
- **✅ Shipped** — meets the "presentable" criteria from [README.md](./README.md)
- **🪦 Abandoned** — explicitly dropped (none currently)

---

## Tier 1 — Semester 1 (January → June)

| Project            | Status                  | Live                                             | Last activity                                                  |
| ------------------ | ----------------------- | ------------------------------------------------ | -------------------------------------------------------------- |
| Trading Journal    | 📝 Spec drafted         | —                                                | —                                                              |
| Car Cost Tracker   | ✅ Shipped Apr 30, 2026 | [cost-log.tuxlab.fr](https://cost-log.tuxlab.fr) | [Week of Apr 27 - May 3, 2026](./car-cost-tracker/JOURNAL.md)  |
| ForkliftFleetCheck | 🌱 Initialized Jan 7    | —                                                | [Week of Jan 5-11, 2026](./forklift-fleet-check/JOURNAL.md)    |
| PIF Is Fake        | ✅ Shipped May 4, 2026  | [pif.tuxlab.fr](https://pif.tuxlab.fr)           | [Week of May 4-10, 2026 _(partial)_](./pif-is-fake/JOURNAL.md) |

> ForkliftFleetCheck repo was scaffolded from `sample-project` on Jan 7 with one initial commit and
> never touched again. The earlier Spark prototype (FleetChariot, listed in
> [README → Prototypes](./README.md#prototypes-spark)) is separate and predates Road to Six.

## Tier 1 — Semester 2 (July → December)

| Project          | Status           | Live | Last activity                                      |
| ---------------- | ---------------- | ---- | -------------------------------------------------- |
| Portfolio + Blog | 📋 Spec stub     | —    | —                                                  |
| GuardStore       | 📝 Spec drafted  | —    | —                                                  |
| CubeMaster       | ⏸ Paused Apr 12  | —    | [Week of Apr 6-12, 2026](./cube-master/JOURNAL.md) |

> CubeMaster started early as a graduated Bone Pile project (Jan 26). 64 commits and 8 PRs merged
> on the active [cube-master](https://github.com/TituxMetal/cube-master) repo (develop), no activity
> since Apr 12. Earlier work on the abandoned `rubiks-cube-solver-codespace` and Spark cubemaster
> repos is documented in [cube-master/JOURNAL.md](./cube-master/JOURNAL.md).

## Méta projets

These aren't Tier 1 themselves, but they support the system.

| Project              | Role                                                                                                               | Last activity                                               |
| -------------------- | ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------- |
| claude-code-tool-kit | Methodology backbone (skills, hooks, agents) — tracked in [claude-project/JOURNAL.md](./claude-project/JOURNAL.md) | [Week of Apr 27 - May 3, 2026](./claude-project/JOURNAL.md) |
| 2026-road-to-six     | This repo — accountability system, journals, MVPs                                                                  | (continuous)                                                |

## Bone Pile

The Bone Pile is described in [README.md → The "Bone Pile"](./README.md#the-bone-pile). PIF Is Fake
bypassed the pile and shipped directly to Tier 1 — no other bones formally tracked at this time.

---

## Roll-up Stats

Aggregated across all `JOURNAL.md` files at the date above.

| Metric                           | Value                                                                            |
| -------------------------------- | -------------------------------------------------------------------------------- |
| Tier 1 projects shipped          | 2 / 6 (Car Cost Tracker, PIF Is Fake)                                            |
| Tier 1 paused                    | 1 (CubeMaster)                                                                   |
| Tier 1 initialized               | 1 (ForkliftFleetCheck — scaffold only)                                           |
| Tier 1 spec drafted              | 2 (Trading Journal, GuardStore)                                                  |
| Tier 1 spec stub                 | 1 (Portfolio + Blog)                                                             |
| Total commits (Tier 1)           | 341 (car-cost-tracker) + 49 + 64 + 1 = **455**                                   |
| Total commits (méta)             | 62 (claude-code-tool-kit)                                                        |
| Total PRs merged (Tier 1 + méta) | 47 (car-cost-tracker) + 4 + 8 + 0 + 21 = **80**                                  |
| First journal entry              | Jan 5, 2026 (car-cost-tracker, forklift-fleet-check)                             |
| First Tier 1 ship                | Apr 30, 2026 (Car Cost Tracker)                                                  |
| Most recent Tier 1 ship          | May 4, 2026 (PIF Is Fake)                                                        |

> Stats are recomputed manually from each project's `Cumulative Stats` table. Numbers drift between
> updates — the source of truth is each `JOURNAL.md`.
