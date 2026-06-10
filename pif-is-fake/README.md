# PIF Is Fake — README

French-language satirical web app that randomly generates a parody "monthly bonus" (_prime au pif_).
Repo: [TituxMetal/pif-is-fake](https://github.com/TituxMetal/pif-is-fake) · Live:
[pif.tuxlab.fr](https://pif.tuxlab.fr). Full spec/design live in the repo's own `docs/` — not
duplicated here.

## Definition of done (frozen — the original idea)

- [x] Deployable to a public URL — live at `pif.tuxlab.fr`
- [x] Core features work — salarié view, hidden dispatch view, sharing, dual theming
- [x] Tested — generation engine, 35-bit base62 hash codec, validation, routing primitives
- [x] Documented — spec, design language, content banks (in repo `docs/`)
- [x] Disclaimer page (`/avertissement`) makes the parodic intent explicit
- [x] No critical bugs at ship
- [x] Constraint met: built A-to-Z in a single weekend sprint

## Scorecard (dated, may evolve)

- Complexity: 4/10 — single Hono SSR app with selective React hydration, no backend or database;
  the one genuinely clever piece is the 35-bit base62 permalink codec (deterministic, shareable
  rolls without server state).
- Completion: 100% (7/7 original items)
- Status: ✅ Shipped — live, original objective fully met
- Personal note: the one I'm proudest of in May. A real workplace frustration, shipped as a joke,
  A-to-Z in a weekend. It exists because it had to — and that was the whole point.

## Beyond the original idea (bonus — NOT counted in %)

- None planned by design — "this project is done". Issues open at ship are nice-to-haves, not a v2.

_Last updated: 2026-06-10_
