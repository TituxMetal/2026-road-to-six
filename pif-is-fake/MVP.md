# PIF Is Fake — MVP Definition

**Status:** ✅ Shipped May 4, 2026 — live at [pif.tuxlab.fr](https://pif.tuxlab.fr)

**Repo:** [TituxMetal/pif-is-fake](https://github.com/TituxMetal/pif-is-fake)

## Overview

_What is this project and who is it for?_

A French-language satirical web app that randomly generates a "monthly bonus" — parodying
the structure of a real arbitrary corporate compensation scheme. Born from frustration with
a real "prime" system at work where some employees stack bonuses for cutting corners while
others get nothing for working diligently.

The criticism aims at the system, not at people: every name receives the same random
treatment, no job titles are displayed, and the [`/avertissement`](https://pif.tuxlab.fr/avertissement)
page makes the intent explicit.

It exists because it had to. It serves no real-world need. It will probably be ignored in
two weeks. None of that is the point.

## Core Value

_What problem does this solve?_

Channeling a real workplace frustration into something built, deployed, and shareable —
rather than letting it rot. The act of shipping the joke is the value.

## MVP Features (delivered)

- **Salarié view** (public) — visitor enters a first name, picks a vest (Aléatoire /
  Intérim / Embauché / Responsable), gets a randomly generated "prime" with sigle,
  decomposition (Production / Qualité / Sécurité), optional bonus line, total, sarcastic
  motif, and matching vest accent.
- **Permalink hash** — every roll is encoded as a 35-bit base62 hash so primes are
  deterministic, shareable, and reproducible without server state.
- **Routes** — `/`, `/<prenom>`, `/<prenom>/<boite>`, `/<prenom>/<boite>#<hash>`,
  `/avertissement`.
- **Dual visual themes** — Terminal (sober, monospace, hi-vis accent) and Manifeste
  (typographic, expressive). Switch persisted across sessions.
- **Dispatch view** (hidden) — `/dispatch` route reachable only via secret trigger sigle
  set. Displays a full monthly team distribution as a "leaked internal report".
- **Sharing actions** — copy link, Web Share API, toast feedback.
- **Loading mouline** — 2-step random animation (~4 s on first roll, ~1 s on permalink
  replay) drawn from the loading-steps content bank.
- **Footer rotation** — monospace line cycling through the four backronyms (Illusoire /
  Imaginaire / Insensée / Injuste) with snap-cut typewriter effect.

## Out of Scope (intentionally)

- User accounts, persistence, server-side state
- Analytics, tracking, ads
- Internationalization — the parody is French and stays French
- A "v2" — this project is done. Issues open at ship are nice-to-haves, not blockers.

## "Done" Criteria

- [x] Deployable to a public URL — live at `pif.tuxlab.fr`
- [x] Core features work — salarié view, dispatch view, sharing, theming
- [x] Tested — `bun run test` covers the generation engine, hash codec, validation,
      routing primitives
- [x] Documented — full spec in [`docs/MVP.md`](https://github.com/TituxMetal/pif-is-fake/blob/main/docs/MVP.md),
      design language in [`docs/design.md`](https://github.com/TituxMetal/pif-is-fake/blob/main/docs/design.md),
      content banks in [`docs/design/content-banks.md`](https://github.com/TituxMetal/pif-is-fake/blob/main/docs/design/content-banks.md)
- [x] Disclaimer page makes the parodic intent explicit
- [x] No critical bugs at ship

## Technical Notes

_Stack, architecture decisions, constraints_

- **Stack** — Hono SSR + selective React hydration, Vite, Tailwind v4 + DaisyUI,
  TypeScript, Biome, Bun. No monorepo (Hono + React single app).
- **Generation engine** — pure functions over typed content banks (`prenom`, `sigle`,
  `vest`, `motif`). Roll composer pipes through the banks; sanitizers normalize input.
- **Permalink codec** — 35-bit base62 hash decoded client-side with out-of-range
  rejection. The URL surface is its own contract.
- **Theme system** — `useSyncExternalStore` singleton, persistence via localStorage with
  hardened access, theme applied before paint to avoid flash.
- **Composition over abstraction** — Home, Disclaimer and Header each split into
  Terminal/Manifeste variants sharing one copy bank. Two visually distinct experiences
  without a heavy theming layer.
- **Prod stack** — Inter font, design tokens, Docker pipeline, robots.txt.

## Source-of-truth docs

The detailed spec, design language and content banks live in the project repo:

- [`docs/MVP.md`](https://github.com/TituxMetal/pif-is-fake/blob/main/docs/MVP.md) — routes,
  generation rules, hash codec, edge cases
- [`docs/design.md`](https://github.com/TituxMetal/pif-is-fake/blob/main/docs/design.md) —
  visual language, palettes, typography, wireframes
- [`docs/design/vest-roles.md`](https://github.com/TituxMetal/pif-is-fake/blob/main/docs/design/vest-roles.md) —
  vest → role mapping, dispatch model
- [`docs/design/content-banks.md`](https://github.com/TituxMetal/pif-is-fake/blob/main/docs/design/content-banks.md) —
  motifs, loading steps, names
- [`docs/design/disclaimer.md`](https://github.com/TituxMetal/pif-is-fake/blob/main/docs/design/disclaimer.md) —
  `/avertissement` page copy
