# Car Cost Tracker — README

Web app to track vehicle maintenance, recurring checks, and costs (FR UI).
Repo: [TituxMetal/car-cost-tracker](https://github.com/TituxMetal/car-cost-tracker) · Live
(self-hosted): [cost-log.tuxlab.fr](https://cost-log.tuxlab.fr).

## Definition of done (current baseline — evolved MVP; design counted since 2026-03-03)

App core:

- [x] Deployed to a public URL — self-hosted (Docker/Portainer, owner's server)
- [x] Auth (register, login, logout)
- [x] Create and manage ONE vehicle (full CRUD)
- [x] Custom check types with day-interval scheduling
- [x] Log checks, compute next due date, view history
- [x] Dashboard — vehicle status, overdue/upcoming, health score
- [x] Track expenses with categories and totals
- [x] Budget comparison (spent vs budget)
- [x] Core features tested
- [x] Basic setup documentation

Design system / "Cluster" Visual Refresh (Feature 09, in MVP since 2026-03-03) — 5/8 blocks:

- [x] Foundation · Auth · Vehicles · Checks · Dashboard
- [ ] Expenses · Budget · Profile/Admin
- [ ] Mobile-responsive sign-off (gated on the blocks above)

(Stretch "Nice to Have", NOT counted: multi-car ✗ · vehicle switcher ✗ ·
public profile ✗ · multi-user ✓ already shipped)

## Scorecard (dated, may evolve)

- Complexity: 7/10 — Turborepo monorepo, NestJS hexagonal API + Astro/React web, Prisma/SQLite,
  Better Auth, self-hosted Docker/Portainer with same-origin cookie proxy, full test suite. Most
  involved build of the set.
- Completion: ~80% — app core done; design overhaul 5/8 blocks, responsive sign-off pending.
  Counting the design lowers the % on purpose: it's in scope, not a bonus.
- Status: 🚀 Released — live; current-baseline DoD not yet 100%.
- Personal note: 15 weeks, 341 commits — my longest sustained build. The prod DELETE hotfix
  (CSRF + double-consumed body) taught me dev-green ≠ prod-green.
- Re-baseline: project being promoted personal → more ambitious; expect a new dated DoD baseline
  when that brainstorm happens.

## Beyond the original idea (bonus — NOT counted in %)

- Mileage history (localStorage, 20/vehicle; cross-device backend deferred to BACKLOG)
- Admin onboarding (Better Auth admin plugin) — alpha-tester gating without email infra

_Last updated: 2026-06-10_
