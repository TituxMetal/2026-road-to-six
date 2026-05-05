# PIF Is Fake — Development Journal

## How to use this file

Log your progress here. Each entry should include:

- **Date**
- **Time spent** (approximate)
- **What you worked on**
- **What you learned/discovered** (optional but valuable)
- **Blockers** (if any)

Don't overthink it. Short entries are fine. The goal is to have a record you can look back on.

**Repo:** [TituxMetal/pif-is-fake](https://github.com/TituxMetal/pif-is-fake) — **Live:** [pif.tuxlab.fr](https://pif.tuxlab.fr)

---

## Cumulative Stats

| Metric        | Total                |
| ------------- | -------------------- |
| Commits       | 49                   |
| PRs merged    | 4                    |
| Issues closed | 4                    |
| Weeks active  | 2                    |
| Period        | Apr 30 — May 4, 2026 |

---

## Entries

### Week of May 4-10, 2026 (partial)

> 4 commits | 1 PR merged

**Worked on:**

- **PR #9 merged Mon 08:42 CEST** — sharing actions, hidden `/dispatch` view, prod stack
  (Inter font, design tokens, Docker pipeline, robots.txt). The slice 4 work pushed late
  Sunday landed in main this morning, unlocking the prod deploy.
- Polish commits before going live: `pickNIndexes` helper + `fix(dispatch): pick motif
  indexes once per view to avoid duplicates across cards`, expanded content banks
  (colleagues, motifs, loading steps), GitHub repo link surfaced in both disclaimer
  themes (Terminal + Manifeste).
- **Live at pif.tuxlab.fr ~ noon** — goal of the long weekend hit ahead of Monday
  morning, with a margin.

**Learned:**

- Shipping pride is independent of project utility. PIF serves no real-world need,
  probably won't be visited in two weeks, and yet the pride from getting it live in the
  self-imposed window is real. The discipline held — that's what's worth tracking.
- The 4-day execution wasn't a shortcut, it was the dividend of car-cost-tracker.
  Hexagonal reflexes, slice-based PRs, ISO journaling, the two-layer hook regime — all
  the methodology pinned down on the steak made the bone trivial to chew.

**Blockers:**

- None

---

### Week of Apr 27 - May 3, 2026

> 45 commits | 3 PRs merged | 4 issues closed

**Worked on:**

- **The trigger (Tue night → Wed Apr 29).** Two emails from my manager offering Wed and
  then Thu off because of low activity at work. Accepted both, which sur-boosted me into
  finishing car-cost-tracker, deploying it, and burning down the production hotfix
  cluster (PR #58 — Astro `security.checkOrigin` blocking DELETE) until past 23h after
  being up since 02h.
- **Brainstorm Thu Apr 30.** Couldn't face more car-cost-tracker, so I dedicated the
  whole day to a full-scope brainstorm with Claude on a micro-idea I'd been chewing on
  for a week — a sarcastic parody of an arbitrary "prime" attribution scheme at work.
  The day produced the spec (`docs/MVP.md`), the design language (`docs/design.md`,
  vest-roles, content banks, disclaimer copy), and the slicing strategy (4 vertical
  slices, each merge-able on its own).
- **Fri May 1 — scaffold day (jour férié).** Repo created on GitHub, license + README +
  gitignore, then `chore: scaffold hono + react + vite + tailwind + biome` + the design
  docs ported into the repo + a weekend tracking dashboard committed under
  `docs/progress/`.
- **Sat May 2 — slices 1 + 2 (PR #5, PR #6).**
  - **Slice 1 — generation engine.** Typed content banks (`prenom`, `sigle`, `vest`,
    `motif`), pure generation primitives + roll composer, 35-bit base62 hash codec for
    permalinks, prenom + sigle sanitizers, minimal Home page wired into App. Slice 1
    closed in the afternoon.
  - **Slice 2 — salarié routes + permalink + loading mouline.** `validatePrenom` with
    Title Case normalization, URL parsing + path building primitives, `Loading`
    component for the mouline phase, `useRouteIntent` hook, route intent + permalink
    replace orchestration in Home, `Disclaimer` feature module, App-level branching
    between Home and Disclaimer, refactor lifting route subscription to App via shared
    `useRouteIntent`. Slice 2 closed late evening.
- **Sun May 3 — slices 3 + 4 (PR #7, plus slice 4 commits direct on main).**
  - **Slice 3 — visual themes (Terminal + Manifeste).** Tailwind v4 theme tokens, Inter
    font, theme primitives lib with persistence hook, `AppShell` with header / footer /
    theme switcher, Home + Disclaimer + result surfaces restyled with theme tokens,
    storage access hardened, theme applied before paint, `aria-pressed` for the theme
    switcher. Slice 3 closed mid-morning via PR #7.
  - **Slice 4 — sharing + dispatch + prod stack.** Crypto-safe id generator (with
    non-secure-context fallback), trigger sigle set + dispatch view composer, theme
    hoisted to a `useSyncExternalStore` singleton, header split into `TerminalChrome` +
    `ManifesteChrome`, Disclaimer split into Terminal + Manifeste variants sharing one
    copy bank, share actions feature (copy link, web share, toast feedback), hidden
    `/dispatch` route with pinned colleagues + optional intérim count, Home split into
    Terminal + Manifeste surfaces, `useDisplayPath` observer, prod stack wired (Inter
    font, design tokens, Docker pipeline, robots). Slice 4 work merged Monday morning
    via PR #9.

**Learned:**

- **Brainstorm as a discrete day pays off.** Dedicating Thursday entirely to scoping
  with Claude (spec, design language, content banks, slicing strategy) before touching
  any code is the reason 4 days of dev was enough. Without that day, I'd still be
  writing motifs.
- **Vertical slices with their own PR turn an MVP into a series of presentable
  milestones.** Each of the 4 slices is by itself a working subset of the app — slice 1
  alone (generation engine + minimal home) is shippable. The slicing isn't ceremony,
  it's risk control.
- **Composition over abstraction for the dual themes.** Splitting Home + Disclaimer +
  Header into Terminal/Manifeste variants that share a single copy bank produced two
  visually distinct experiences without an over-engineered theming layer. The
  `useSyncExternalStore` singleton was the only "infrastructure" piece needed.
- **Hono SSR + selective React hydration is the right weight class for an app like
  this.** Faster boot than Astro, full control over the SSR/SPA split, and no
  framework-level islands abstraction to fight when a feature needs JavaScript.
- **35-bit base62 hash as permalink seed.** Encoding the roll into a 6-character base62
  hash means every generated "prime" is shareable, reproducible, and validatable
  client-side without server state. The decoder rejects out-of-range values so the URL
  surface is its own contract.

**Blockers:**

- None

---

_Add new entries above this line, newest first._
