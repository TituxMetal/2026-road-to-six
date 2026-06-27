# CubeMaster — README

A Rubik's Cube companion app — three modes over one clean TypeScript engine: Solver, Coach, Timer.
Repo: [TituxMetal/cube-master](https://github.com/TituxMetal/cube-master) · Live:
[cube-master.fly.dev](https://cube-master.fly.dev/).

## Definition of done (frozen — the original idea: a three-mode cube companion)

- [x] **Solver** — input any valid cube state → working step-by-step layer-by-layer solution, with
      tap-to-paint input, validation, and prev/next step navigation
- [x] **Timer** — scramble generator, spacebar/tap timer, session history, Best / Ao5 / Ao12 stats,
      localStorage persistence
- [~] **Coach** — progressive tutorials (beginner → advanced) — **v1 live**: eight-chapter beginner
      layer-by-layer journey (Ch0 notation → Ch7 finish); advanced tutorials still ahead
- [x] **Coach** — live algorithm demos + practice mode — **built** (placement-aware demos +
      full-chapter practice, on a dedicated teaching solver)
- [x] Clean TypeScript domain-driven engine (`packages/cube-engine`) — the shared backbone Solver
      and Timer both reuse
- [x] Cohesive UI shell — landing + the three mode surfaces + design system (Vite + React SPA)
- [x] Deployed to a public URL — live at `cube-master.fly.dev`

## Scorecard (dated, may evolve)

- Complexity: 6/10 — no backend or database (localStorage only), a single Vite + React SPA, but the
  layer-by-layer solver algorithm and cube domain model are genuinely hard (the earlier Spark
  prototype failed at exactly this).
- Completion: ~90% — all three modes are now live. Coach v1 (PR #11, Jun 22) landed the teaching
  solver, the eight-chapter beginner journey, placement-aware demos and full-chapter practice. What
  keeps it under 100% is the original "beginner → advanced" promise: the beginner layer-by-layer
  method is taught end to end, advanced tutorials remain.
- Status: 🚀 Released — live, all three modes shipped; advanced Coach tutorials are the remaining gap.
- Personal note: born from the legendary Spark "SOLVED" (it wasn't) disaster. The clean React/Vite
  restart, domain-first, is what finally made a real solver work.

## Beyond the original idea (bonus — NOT counted in %)

- Interactive CubePlayground on the landing page — free move manipulation with history, beyond the
  three core modes

_Last updated: 2026-06-27_
