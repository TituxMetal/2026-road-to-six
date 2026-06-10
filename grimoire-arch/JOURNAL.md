# grimoire-arch — Development Journal

## How to use this file

Log your progress here. Each entry should include:

- **Date**
- **Time spent** (approximate)
- **What you worked on**
- **What you learned/discovered** (optional but valuable)
- **Blockers** (if any)

Don't overthink it. Short entries are fine. The goal is to have a record you can look back on.

**Repo:** [TituxMetal/grimoire-arch](https://github.com/TituxMetal/grimoire-arch) — **Live:**
[tituxmetal.github.io/grimoire-arch](https://tituxmetal.github.io/grimoire-arch/)

---

## Cumulative Stats

| Metric        | Total               |
| ------------- | ------------------- |
| Commits       | 24                  |
| PRs merged    | 0 (direct-to-main)  |
| Issues closed | 0                   |
| Weeks active  | 1                   |
| Period        | Jun 2 — Jun 7, 2026 |

---

## Entries

### Week of Jun 1-7, 2026

> 24 commits | 0 PRs (direct-to-main) — **Shipped Jun 3, 2026**

**Worked on:**

- **First wiki I've ever published** — a FR Arch Linux guide/wiki, Astro Starlight + Bun, deployed
  to GitHub Pages via `withastro/action` on push to `main`.
- **Built end-to-end with the new (Heart of Gold) workflow:** doctrine baseline (`harness-up` +
  ground briefing) → architect (stories + 5 ADRs) → proof-slice plan → full rollout.
- **Proof-slice first:** shipped one verifiable vertical (a single guide page + ADRs + a
  link-validation canary) and confirmed FR Pagefind search worked _in prod_ before publishing the
  rest. Then the full guide (ch. 4–13 + annexe A) with a hero sidebar, plus the substrate
  (brainstorms / findings / plans / solutions / stories) surfaced under "Coulisses".
- **FR i18n** so Pagefind builds a French search index (serve the site as French).
- **Laid the Act II structure** (the devbox migration arc): four sibling sidebar groups + landing
  pages + an ADR, additive only — structure in place, execution ahead (~July 2026).
- Captured the Starlight / GitHub Pages / Bun recipe and its silent gotchas as solution docs.

**Learned:**

- The new workflow holds up end-to-end on a real ship — a publishable wiki in roughly a day of
  focused work.
- **Proof-slice before full rollout:** shipping one verifiable page (with a search canary in prod)
  before 13 chapters de-risks the whole site — you find the deploy/i18n/search gotchas on a 1-page
  surface, not a 50-page one.
- Starlight + Pagefind needs the site served as French for a FR search index — a non-obvious i18n
  gotcha worth writing down.

**Blockers:**

- None

---

_Add new entries above this line, newest first._
