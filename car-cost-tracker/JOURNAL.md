# Car Cost Tracker — Development Journal

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

| Metric        | Total                |
| ------------- | -------------------- |
| Commits       | 339                  |
| PRs merged    | 47                   |
| Issues closed | 7                    |
| Weeks active  | 15                   |
| Period        | Jan 5 — Apr 30, 2026 |

---

## Entries

### Week of Apr 27 - May 3, 2026

> 24 commits | 3 PRs merged | 1 issue closed

**Worked on:**

- **PR #55 (Apr 28) — Visual Refresh Block 4: Checks (types + logs):** cluster surfaces with
  status-driven left borders, telltale dots in badges, mono mini-tables (INTERV. / DERNIER /
  PROCHAIN), composite kicker + h1 headers; `LogCheckDialog` enriched with a live "Prochain contrôle
  calculé" panel.
  - New `Button` variant `destructive-outline` for outlined danger CTAs (promoting the local pattern
    from Block 3)
  - `Select` and `Textarea` rewritten to match `Input` (caught inherited DaisyUI defaults Block 1
    missed)
  - `SUGGESTED_CHECK_TYPES` expanded 3 → 7 (Frein, Lave-glace, Éclairage, Essuie-glaces); "Niveau de
    liquide de refroidissement" → "Liquide de refroidissement" for mockup parity
  - `check-logs/components/index.ts` barrel completed (was exporting 3 of 8 components)
- **PR #56 (Apr 29) — Visual Refresh Block 5: Dashboard + MVP-Core widgets.**
  - Cockpit layout `lg:grid-cols-[360px_1fr]` (sidebar + main column), sr-only h1, mobile-only
    `À traiter` banner
  - 8 dashboard surfaces refreshed (3 renamed, 3 new: TelltaleGrid, UpcomingChecksGrid,
    RecentTimeline)
  - 2 net-new MVP-Core widgets: `BudgetPanel` (dual mensuel + annuel) and `RecentExpensesPanel` (3
    rows + tinted category badges)
  - `LogCheckDialog` gains a picker mode (consumed by `UpcomingChecksGrid` CTA)
  - `useDashboard` exposes `healthScore` (`100 − 15·overdue − 8·dueSoon − 3·never`, clamped) +
    `tellTaleSummaries` (top-6 by status priority)
  - Plan deviation: bottom `lg:grid-cols-2` row abandoned (visible gap below `LastEntryCard`) —
    final layout puts `BudgetPanel` at the bottom of the sidebar, `RecentExpensesPanel` at the
    bottom of the main column
- **Issue #57 / PR #58 (Apr 29 → Apr 30) — Production hotfix: DELETE blocked in production.**
  - Astro 5 `security.checkOrigin: true` rejected every `DELETE` with 403 because
    `Content-Type: application/json` was only set when a body was present; CSRF check fired before
    the proxy route — masked in the UI by a _second_ bug where `parseErrorResponse` consumed the
    body twice (`response.json()` then `response.text()` always threw "Body has already been
    consumed")
  - Fix: drop the `options.body &&` guard so every fetch carries `Content-Type: application/json`;
    rewrite `parseErrorResponse` to `text()` once and `JSON.parse` in memory; 3 new tests (1137
    total)
  - Local dev mode worked because Vite's dev proxy bypasses Astro entirely — bug invisible until
    live deploy
  - Follow-up commit `fix(web): scope default Content-Type to state-changing methods` narrows the
    change to mutation methods only
- **Marketing + alpha gating polish (post-hotfix, direct to develop):**
  - Anonymous landing copy refreshed with alpha banner, dual CTA, brand tagline
  - `/auth/verification-pending` reframed around manual activation (matches the admin-only
    onboarding model from PR #51)
  - Signup mode shows an alpha-private notice with admin mailto

**Learned:**

- Astro 5 `security.checkOrigin` is stricter than it looks. A simple `Content-Type` omission moves a
  JSON request into the "simple request" CSRF surface — always set the header on state-changing
  methods even when there's no body.
- `Response` body is a one-shot read. `await response.json()` consumes the body — `response.text()`
  in the catch then fails. Read once via `text()`, parse in memory.
- Bugs that only show in production builds (Vite dev proxy bypassing Astro) need at least one local
  `astro build && astro start` cycle before claiming an end-to-end fix.
- Don't trust dev-mode greens. A green test suite + working dev mode hid a 100%-broken DELETE path
  in production.

**Blockers:**

- None

---

### Week of Apr 20-26, 2026

> 76 commits | 7 PRs merged

**Worked on:**

- **PR #48 (Apr 20) — Feature 06 (Expenses) frontend:** full CRUD UI on `/expenses` over the
  already-merged backend.
  - Types + `amount` utils with FR-locale parser (`89,50` / `89.50` / `89` all accepted), category
    labels and badge colors
  - Zod schemas with `.transform()` string → cents, RHF 3-generic form value types
  - API service, Nanostores store with computed money atoms (`$totalCents`, `$filteredTotalCents`,
    `$totalsByCategory`), `useExpenses` hook
  - Presentational set: `ExpenseCard`, `ExpensesList`, `ExpensesEmptyState`, `ExpenseForm`,
    `ExpenseFormDialog`, `DeleteExpenseDialog`, `ExpensesHeader`, `ExpensesFilter`
  - Container with state machine (loading → list), redirect on no-vehicle, success/error feedback
  - Page shell at `/expenses` + nav link
- **PR #49 (Apr 22) — Feature 07 (Budget) backend:** full hexagonal stack on a 1:1 Vehicle relation.
  - Shared `Amount` VO + validation hoisted from `expenses/domain/` to `shared/domain/` so Expense
    and Budget consume the same value object
  - Prisma `Budget` model + migration, `BudgetPeriod` enum, `@unique` 1:1 to Vehicle, cascade delete
  - Domain: `Budget` entity with focused `updateAmount` / `updatePeriod` / `updateBoth` mutators
    (mirrors Expense), `BudgetId`, validation constants, repository port, exceptions
  - Application: Upsert + Get DTOs, mapper, `GetBudgetByVehicle` / `UpsertBudget` / `DeleteBudget`,
    `BudgetService` facade
  - Infrastructure: `PrismaBudget` repo using `upsert` (aligned with the 1:1 constraint), REST
    controller `GET/PUT/DELETE /vehicles/:vehicleId/budget`, `BudgetsModule` wired into `AppModule`
- **PR #50 (Apr 23) — Feature 07 (Budget) frontend:** outside-in.
  - Relocated shared `amount.utils` to `~/shared/utils`, swept 5 Expense imports
  - Extended Expense store with `$spentThisMonthCents` / `$spentThisYearCents` (ISO prefix, mockable
    clock)
  - Full `features/budget` module: types, schema, API, period + status utils, store + `useBudget`
    hook, 7 components (EmptyState, Status dual-panel, Form, FormDialog, Header, DeleteDialog,
    Container), `/budget` page + nav
  - 975 tests (+98); `getBudget` swallows the missing-budget HTTP 500 to `null` until the backend
    `ExceptionFilter` lands (logged in PROGRESS.md backlog)
- **PR #51 (Apr 24) — Feature 08 (Admin Onboarding):** three admin actions on `/admin/users` via the
  Better Auth 1.5.5 admin plugin, zero backend changes — unblocks tester onboarding without email
  infrastructure.
  - Create user dialog (`admin.createUser` + `emailVerified: true`), verify-email button
    (`admin.updateUser`), reset-password dialog (`admin.setUserPassword`, password `type='text'` so
    the admin can read before out-of-band transmission)
  - 14 new files, 5 modified, 37 new tests (1012 total)
- **PR #52 (Apr 25) — Feature 09 (Visual Refresh) Block 1: Foundation:** V01 Cluster theme, fonts,
  primitives, layout, brand identity. Frontend-only.
  - `globals.css` rewritten with the V01 palette (warmer amber, darker base, squarer radii);
    self-hosted Oxanium + JetBrains Mono (zero `fonts.googleapis.com` calls)
  - New primitives: `Gauge` (`role='meter'`, 270° arc, no inline `style`) and `TelltaleLight`
    (`role='status' | 'alert'`)
  - `Button` gains a `warning` variant + cluster baseline; `DialogShell` becomes a full-screen sheet
    on mobile
  - `Main.astro` rebuilt: desktop top-bar, mobile bottom tab bar (Dash / Auto / Contrôles / Logs /
    Dépenses), avatar dropdown
  - COST.LOG brand identity: favicon, anonymous landing rebuilt as a cluster hero
- **PR #53 (Apr 26) — Visual Refresh Block 2: Auth:** every auth surface ported onto the cluster
  shell.
  - New `Auth.astro` layout + cluster primitives (`AuthShell`, `AuthHero`, `AuthHeader`,
    `SystemStatusPanel`)
  - `Input`, `Label`, `FormWrapper` rewritten cluster-only (variant prop dropped, daisy classes
    removed)
  - `LoginForm` + `SignupForm` consolidated into `AuthContainer`; FR error copy
  - `SessionList` rebuilt with double-click guards on revoke actions
- **PR #54 (Apr 26) — Visual Refresh Block 3: Vehicles + mileage history:** cluster restyle + new
  frontend-only feature.
  - Cluster restyle of `VehicleProfile`, `QuickMileageUpdate`, `VehicleContainer`, `VehicleForm`,
    `VehicleEmptyState`
  - New mileage history (utils + atom + hook + `MileageHistoryCard`) backed by `localStorage`,
    capped at 20 entries per vehicle, surfaced beside the compteur
  - `formatMileage` simplified to invariant `${km} km` (correct French)
  - Destructive-outline pattern emerges: `btn-outline` applied locally on `VehicleProfile`'s
    Supprimer + cancel buttons; promoted to a real `destructive-outline` Button variant in Block 4
  - Real cross-device storage parked in `BACKLOG.md` as a `Mileage Log` backend feature

**Learned:**

- Sharing a domain VO across features works as long as the VO is stateless. Hoisting
  `AmountValueObject` from `expenses/domain/` to `shared/domain/` was friction-free because the VO
  has no entity dependencies — Budget and Expense both consume the same money primitive without
  knowing about each other.
- `upsert` + `@unique` is the right Prisma pattern for 1:1 relations. Two endpoints (PUT to upsert,
  DELETE) replace the usual create/update/delete trio when the parent already enforces uniqueness.
- A "missing budget returns HTTP 500" frontend-side fallback is acceptable temporarily as long as
  the swallow is documented with a backlog item for the global `ExceptionFilter`. Better than
  blocking the feature on a cross-cutting refactor.
- Better Auth's admin plugin can carry an entire onboarding flow client-side when the trust model
  permits (admin creates pre-verified testers). Zero backend changes for Feature 08.
- DaisyUI primitives keep leaking into "rewritten" components. Block 1 thought it had fully purged
  daisy from `Input` / `Label`; Block 4 caught the same on `Select` / `Textarea` only when the
  browser smoke test exposed inherited defaults — every primitive needs to be browsed, not just
  unit-tested.
- Self-hosting fonts (woff2 + OFL.txt under `/fonts/`) is a one-time setup that pays back forever —
  Lighthouse a11y stays at 100 across `/auth` desktop and mobile, zero runtime Google calls.

**Blockers:**

- None

---

### Week of Apr 13-19, 2026

> 15 commits | 1 PR merged

**Worked on:**

- **PR #47 — Feature 06 (Expenses) backend:** full hexagonal stack shipped in one day.
  - Prisma `Expense` model + migration (`ExpenseCategory` enum, indexes, Vehicle relation)
  - Domain: Value Objects (`ExpenseId`, `OccurredAt`, `Amount` with `fromCents` / `fromEuros`),
    validation constants, entity with 4 focused `update*()` methods, exceptions, repository port
  - Application: DTOs (Create / partial Update / Get) + mapper, 5 use cases (Create, Update, Delete,
    GetById, ListByVehicle), `ExpenseService` facade
  - Infrastructure: Prisma mapper + repository (`P2025 → ExpenseNotFoundException`)
  - REST controller under `/vehicles/:vehicleId/expenses` + DI wiring
  - 116 new tests; 1249 total pass / 0 fail
- Ownership verification kept at controller level (CheckLog pattern) rather than duplicated in each
  use case.
- Post-PR polish: centralized `EXPENSE_VALIDATION` constants, `ListExpenses` use case relies on
  repository ordering, test coverage for ownership mismatch, editor pins TypeScript to the workspace
  version.
- **V1 Cluster visual refresh handoff archived** (docs/polish).

**Learned:**

- Amounts stored as integer cents end-to-end avoids float drift — `Math.round(euros * 100)` is
  non-negotiable (`2.995 €` → `300` cents, not `299`).
- `EXPENSE_VALIDATION.CATEGORIES` was removed because it created a circular import between
  `entities/` and `validation/`; inline `Object.values(ExpenseCategory)` does the job without
  breaking layer boundaries.
- Ownership checks belong at the controller, not inside each use case — plan wording was "in every
  use case", but reusing the CheckLog trade-off kept the application layer free of HTTP concerns.
- Partial update orchestration — only apply `update*()` methods for fields `!== undefined`; `null`
  clears, `undefined` leaves unchanged — matches Prisma semantics and avoids silent data loss.

**Blockers:**

- None

---

### Week of Apr 6-12, 2026

> 7 commits | 1 PR merged

**Worked on:**

- **PR #46:** Feature 05 Dashboard — dashboard feature composing existing hooks, centralized act
  export in test-utils, scoped container spec spies, fixed duplicate fetchStatuses call in logCheck
- Feature 05 phases marked complete in PROGRESS.md
- Config cleanup: removed deprecated baseUrl from tsconfigs
- Feature 06 (Expenses) shape document written, progress tracking updated

**Learned:**

- Dashboard as a composition of existing hooks (not new data fetching) validates the hexagonal
  approach — the feature is thin UI over already-tested application logic
- Scoping spies to each test (`beforeEach`) instead of sharing them across the suite prevents flaky
  test interactions

**Blockers:**

- None

---

### Week of Mar 23-29, 2026

> 33 commits | 6 PRs merged

**Worked on:**

- **Check-logging feature — full stack in 4 days (PRs #40-43):**
  - **PR #40 (Mar 25) — Block 1:** Prisma CheckLog model, domain entity, value objects, repository
    interface
  - **PR #41 (Mar 27) — Block 2:** Application DTOs, mapper with status computation
    (overdue/due-soon/ok/never), use cases with date arithmetic, infrastructure layer, NestJS module
  - **PR #42 (Mar 28) — Block 3:** Frontend API service, Nanostores store, useCheckLogs hook, leaf
    components, LogCheckForm/LogCheckDialog, CheckLogList, CheckLogContainer
  - **PR #43 (Mar 28) — Block 4:** Integration into check-types (status badges, log buttons),
    check-logs Astro page, layout polish
- **PR #44 (Mar 28):** DialogShell extracted as shared Radix Dialog component — ConfirmDialog and
  LogCheckDialog both refactored to use it
- **PR #45 (Mar 28 → main):** Release of check-logging feature + dashboard planning docs
- Feature 05 (Dashboard) shape document written, PROGRESS.md updated
- Auth fix: reverted useSecureCookies — Better Auth prefixes cookies with `__Secure-` when enabled,
  breaking cross-origin session detection

**Learned:**

- Third feature (check-logging) built even faster than check-types — hexagonal patterns are now
  muscle memory
- Status computation logic (overdue/due-soon/ok/never) based on date arithmetic belongs in the
  application mapper, not the frontend — single source of truth
- Extracting DialogShell after two dialogs existed (ConfirmDialog, LogCheckDialog) is the right
  moment — pattern proven, not speculative

**Blockers:**

- None

---

### Week of Mar 9-15, 2026

> 24 commits | 5 PRs merged

**Worked on:**

- **PR #35 (Mar 11) — Final design system migration block:** profile, admin, and vehicle features
  migrated to DaisyUI semantic colors and card layouts; auth pages and misc components migrated to
  semantic color tokens; ConfirmDialog overlay migrated; `react-icons` and `astro-icon` dependencies
  removed entirely, replaced by local Astro icon components and Lucide icons.
- **PR #36 (Mar 12 → main):** Release — Features 02 (Check Types) + 03 (UI Design System).
- **PR #37 (Mar 12):** Full dependency update across the project, Bun bumped 1.3.5 → 1.3.10.
- **PR #38 (Mar 14) — Fly.io deployment:** Docker hardening (production flag, Prisma in deps),
  cross-origin auth adaptation, server-side API proxy for same-origin cookie flow, `tsc-alias` for
  path resolution in build output, Fly.io config added.
- **PR #39 (Mar 14 → main):** Release — Blocks 2-4 (Docker fixes, dependency updates, Fly.io
  deployment).
- MVP and PROGRESS docs updated for post-Feature 03 housekeeping.

**Learned:**

- Cross-origin auth with Better Auth requires careful cookie handling — server-side API proxy keeps
  cookies on the same origin.
- `tsc-alias` is needed to resolve TypeScript path aliases (`@/...`) in compiled output — TSC
  doesn't do this natively.
- Pinning `better-auth` to an exact version prevents surprise breaking changes from minor updates.
- Cleaning up unused icon libraries at the end of a migration reduces bundle size and eliminates
  phantom dependencies.
- Semantic color tokens (DaisyUI) mean you never hardcode colors — theme changes propagate
  everywhere automatically.

**Blockers:**

- None

---

### Week of Mar 2-8, 2026

> 40 commits | 7 PRs merged

**Worked on:**

- **Check-types feature completed:** suggested check types with pill-button design, feature barrel
  export, container integration (PR #28)
- **Design system migration kicked off — 6 PRs in one week:**
  - PR #29: Foundation — DaisyUI + Radix UI + Lucide installed, custom dark theme configured, base
    styles simplified
  - PR #30: Shared UI components migrated — Button (btn classes), Input, Label, Textarea, Select
    (DaisyUI form classes), FormWrapper (DaisyUI alert), ConfirmDialog (Radix UI Dialog)
  - PR #31: Layouts migrated — Main.astro (DaisyUI navbar with responsive menu), AdminLayout
    (DaisyUI menu)
  - PR #32: Auth components migrated to DaisyUI semantic classes, ARIA live-region roles added
  - PR #33: Vehicle feature migrated — VehicleForm with fieldset grouping and responsive grid,
    VehicleContainer and VehicleProfile with semantic classes
  - PR #34: Check-types feature migrated — CheckTypeCard, CheckTypeList, CheckTypeContainer with
    empty state, SuggestedCheckTypes pill-button design
- Label component enhanced with error prop and aria-hidden required indicator
- Input, Textarea, Select now integrate Label with fullWidth default
- fade-in-up animation utility added
- astro-icon integration removed, replaced by local Astro icon components

**Learned:**

- DaisyUI's semantic class system (`btn-primary`, `input-bordered`, `card`) eliminates the need for
  custom Tailwind utility soup — much more readable
- Radix UI Dialog handles focus trapping, scroll locking, and accessibility out of the box — no more
  custom ConfirmDialog logic
- Migrating a design system systematically (foundation -> shared UI -> layouts -> features) prevents
  cascading breakage
- Integrating Label directly into Input/Textarea/Select reduces boilerplate in every form

**Blockers:**

- None

---

### Week of Feb 23 - Mar 1, 2026

> 19 commits | 3 PRs merged

**Worked on:**

- **PR #25 (Feb 23):** Check-types container, list, and card components — presentational/container
  split with CheckTypeContainer state management.
- **PR #26 (Feb 23):** CheckTypeForm component + shared Textarea UI component, plus fixes to shared
  UI component bugs.
- **PR #27 (Feb 28) — Check-types CRUD flows:** create, edit, and delete flows wired into
  CheckTypeContainer; DeleteCheckTypeDialog component added; CheckTypeList simplified to pure card
  renderer (single responsibility).
- Plan phases 13-16 revised and open questions resolved.

**Learned:**

- Keeping CheckTypeList as a pure renderer and lifting state management to the Container follows the
  presentational/container pattern — easier to test each in isolation.
- Revising the plan mid-feature (phases 13-16) based on what you've learned while building is
  healthy, not a sign of poor planning.

**Blockers:**

- None

---

### Week of Feb 16-22, 2026

> 31 commits | 7 PRs merged | 6 issues closed

**Worked on:**

- **Check-types feature kickoff (domain → infrastructure → frontend scaffolding):**
  - **PR #17 (Feb 16):** Domain layer — entity, value objects, repository interface, exceptions.
  - **PR #18 (Feb 17):** Application layer — DTOs, mapper, CRUD use cases, CheckType service facade.
  - **PR #19 (Feb 19):** Infrastructure layer — Prisma repository, infrastructure mapper, REST
    controller with vehicle ownership verification; module wiring and app registration.
- **Check-types frontend scaffolding:**
  - **PR #22 (Feb 19):** Frontend setup — type definitions, Zod validation schemas, `/check-types`
    page, navigation link.
  - **PR #23 (Feb 19):** Fixed deprecated Zod v4 API usage across all validation schemas.
  - **PR #24 (Feb 22):** Data layer — API service, Nanostores state store, `useCheckTypes` hook (all
    with tests).
- **PR #12 (Feb 16 → main):** Release — Vehicle Profile feature + auth fixes.
- **6 issues (#6, #7, #8, #9, #10, #11) opened and closed in one go on Feb 16** — memory leak in
  apiRequest, cross-feature import in ChangePasswordForm, hardcoded year 2030, duplicated
  handleApiResponse helper, console.log replacement with Logger service, missing useEffect
  dependency in VehicleContainer.
- Bug fixes in shared UI: Input `w-full` and `aria-invalid` bugs, Select `aria-invalid` bug, missing
  tests added for Button, Label.

**Learned:**

- Building the second feature (check-types) went much faster than vehicles — the patterns from
  hexagonal architecture were already established.
- Zod v4 deprecated some APIs (`.refine()` signature change) — catching these early prevents runtime
  surprises.
- Adding tests for shared UI components (Button, Label, Input, Select) retroactively pays off
  immediately when those components get modified.
- Batching refactor issues (6 opened then closed in one day) trains the `/ship` workflow without
  scattering the effort across weeks.

**Blockers:**

- None

---

### Week of Feb 9-15, 2026

> 38 commits | 4 PRs merged

**Worked on:**

- **PR #4 (Feb 14) — Vehicle profile frontend complete:** VehicleContainer with all modes (create,
  edit, view, delete), page wiring, navigation link; VehicleForm, VehicleProfile, ConfirmDialog,
  DeleteVehicleDialog, VehicleEmptyState, QuickMileageUpdate, formatMileage/formatDate utilities.
- Big CI fix round: test isolation (`mock.module` vs `spyOn`), turbo cache disabled, Bun bumped
  1.3.3 → 1.3.5.
- **Massive refactoring on Feb 15 — 3 PRs landed the same day:**
  - **PR #14:** Replace hardcoded year 2030 with dynamic validation.
  - **PR #15:** Consolidate duplicated `handleApiResponse` helper.
  - **PR #16:** Remove cross-feature import in ChangePasswordForm.
- Console.log replaced with Logger service, double-timeout memory leak fixed in `apiRequest`,
  duplicate `/api` prefix fix, `changePasswordSchema` moved out of auth feature — all opened as
  issues mid-refactor, closed the following Monday.

**Learned:**

- Bun's `mock.module` behaves differently from `spyOn` for test isolation in CI — `spyOn` can leak
  between tests
- Turbo cache can hide test failures in CI — disabled for reliability
- `useEffect` hooks with stable functions (via `useCallback`) prevent unnecessary re-renders
- A double `setTimeout`/`AbortController` in apiRequest was causing a memory leak — one is enough

**Blockers:**

- CI test isolation took time to diagnose (no issues locally)
- Duplicate `/api` prefix (client-side + proxy) caused silent 404s

---

### Week of Feb 2-8, 2026

> 11 commits | 2 PRs merged

**Worked on:**

- **Full infrastructure layer**: PrismaVehicleRepository, infrastructure mapper (Prisma <-> domain),
  REST controller for vehicle endpoints, VehiclesModule wired into app
- PR #2 merged: infrastructure layer (Phase 4)
- PR #3 merged: VehiclesModule wiring
- **Frontend kickoff**: client-side types + Zod schemas, API service for vehicle endpoints,
  Nanostores store, useVehicle hook (Nanostores -> React bridge), reusable Select component
- sample-project (base template) fixes: post-signup redirect path, email verification URL, duplicate
  /api prefix removal in browser requests

**Learned:**

- The infrastructure mapper translates between Prisma types and domain — key isolation layer in
  hexagonal architecture
- Nanostores is lightweight and framework-agnostic, ideal for a shared store between Astro/React
  components
- Fixing the /api prefix in sample-project propagates to all projects using that template

**Blockers:**

- None

---

### Week of Jan 26 - Feb 1, 2026

> 0 commits (pause week — see cube-master/JOURNAL.md)

**Worked on:**

- Car-cost-tracker on pause this week
- CubeMaster detour: Spark AI session (see cube-master/JOURNAL.md for the explosive details), then
  clean restart with React/Vite and a proper vision document

**Learned:**

- Sometimes you need to "chew on a bone" so you don't abandon the steak (Road to Six philosophy in
  action)
- Spark AI and the frustration of debugging a Rubik's Cube algorithm that says "SOLVED" when the
  cube clearly isn't

**Blockers:**

- None (voluntary pause)

---

### Week of Jan 19-25, 2026

> 13 commits | 1 PR merged

**Worked on:**

- **Full application layer**: application mapper, CreateVehicle and GetVehicleByUser use cases, then
  all remaining use cases (update, delete, get by id)
- VehicleService orchestration layer — facade coordinating use cases
- Barrel exports for DTOs and use cases
- **PR #1 merged on Jan 25**: Vehicle Profile backend (Phase 1-3) — first real milestone
- Post-merge fixes: improved DTO validation (mileage excluded from UpdateVehicleDto), undefined
  instead of null for optional fields, fuelType nullable in GetVehicleDto, perf optimization (single
  DB query instead of multiple)

**Learned:**

- Optimizing use cases to a single DB query instead of multiple — significant perf impact
- The difference between `null` and `undefined` for optional fields in TypeScript with Prisma —
  `undefined` = "don't touch", `null` = "erase"
- Barrel exports keep imports clean between layers

**Blockers:**

- None

---

### Week of Jan 12-18, 2026

> 5 commits

**Worked on:**

- **Domain layer finalized**: VehicleEntity with validated mutations and tests, repository interface
  and domain exceptions
- **Application layer started**: DTOs for vehicle operations (Create, Update, Get), validation
  constants
- Cleaned up a leftover TODO comment in Year.vo.spec.ts

**Learned:**

- Domain Value Objects (VehicleId, Vin, Year, Mileage) encapsulate business validation rules — the
  domain is self-protecting
- The repository interface in the domain defines the contract without depending on an implementation
  (Dependency Inversion)

**Blockers:**

- None

---

### Week of Jan 5-11, 2026

> 3 commits

**Worked on:**

- **Project launch**: initial setup on Jan 10 (monorepo, config, structure)
- First domain steps: Vehicle model in Prisma schema, Value Objects (VehicleId, Vin, Year, Mileage)
  with tests
- In parallel: forklift-fleet-check repo created with initial setup on Jan 7

**Road to Six context:**

- The road-to-six meta-repo was created on Jan 3 with full documentation structure (README,
  PROJECTS.md, MVPs, JOURNALs for each project)
- Feature Shape Template added on Jan 5
- Detailed MVPs for car-cost-tracker and trading-journal on Jan 4

**Learned:**

- Monorepo structure with Turborepo + Bun allows sharing config between apps/api and apps/web
- Starting with the domain layer in hexagonal architecture = solid foundations before anything else

**Blockers:**

- None

---

_Add new entries above this line, newest first._
