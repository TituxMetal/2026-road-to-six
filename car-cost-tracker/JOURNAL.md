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

| Metric        | Total                 |
| ------------- | --------------------- |
| Commits       | 255                   |
| PRs merged    | 38                    |
| Issues closed | 6                     |
| Weeks active  | 13                    |
| Period        | Jan 5 — Apr 20, 2026  |

---

## Entries

### Week of Apr 20-26, 2026 (partial)

> 16 commits | 1 PR merged

**Worked on:**

- **PR #48 — Feature 06 (Expenses) frontend:** full CRUD UI on `/expenses` over the already-merged backend.
  - Types + `amount` utils with FR-locale parser (`89,50` / `89.50` / `89` all accepted), category labels and badge colors
  - Zod schemas with `.transform()` string → cents, RHF 3-generic form value types
  - API service wrapping `/vehicles/:vehicleId/expenses`
  - Nanostores store with computed money atoms (`$totalCents`, `$filteredTotalCents`, `$totalsByCategory`) and CRUD actions
  - `useExpenses` hook binding store to React
  - Presentational set: `ExpenseCard`, `ExpensesList`, `ExpensesEmptyState`, `ExpenseForm`, `ExpenseFormDialog`, `DeleteExpenseDialog`, `ExpensesHeader`, `ExpensesFilter`
  - Container wiring with state machine (loading → list), redirect on no-vehicle, success/error feedback
  - Page shell at `/expenses` + nav link in `Main.astro` (desktop + mobile)
- Post-merge fixes: category select placeholder typo, empty-string default on create, `today` computation unified on local time, numeric-input rejection in `parseEurosToCents`.
- Review backlog logged in PROGRESS.md; Feature 06 frontend phases marked complete.

**Learned:**

- React Hook Form's 3-generic pattern — `useForm<CreateExpenseFormValues, unknown, CreateExpenseSchema>` — decouples raw form strings (what `register` sees) from the transformed submit output (cents as number). Cleaner than manual conversion in `onSubmit`.
- Input typed `<input type="text">` (not `number`) is the only way to let the FR comma through to `parseEurosToCents` — native number inputs reject the locale separator.
- `description: null` on PATCH explicitly clears the field, `undefined` leaves it unchanged. Sending `''` deliberately on edit fixes a silent "description stuck" bug when users clear the field.
- Fourth feature (Expenses) shipped backend + frontend in 3 days — hexagonal scaffolding is now automatic; no friction on layer boundaries.

**Blockers:**

- None

---

### Week of Apr 13-19, 2026

> 15 commits | 1 PR merged

**Worked on:**

- **PR #47 — Feature 06 (Expenses) backend:** full hexagonal stack shipped in one day.
  - Prisma `Expense` model + migration (`ExpenseCategory` enum, indexes, Vehicle relation)
  - Domain: Value Objects (`ExpenseId`, `OccurredAt`, `Amount` with `fromCents` / `fromEuros`), validation constants, entity with 4 focused `update*()` methods, exceptions, repository port
  - Application: DTOs (Create / partial Update / Get) + mapper, 5 use cases (Create, Update, Delete, GetById, ListByVehicle), `ExpenseService` facade
  - Infrastructure: Prisma mapper + repository (`P2025 → ExpenseNotFoundException`)
  - REST controller under `/vehicles/:vehicleId/expenses` + DI wiring
  - 116 new tests; 1249 total pass / 0 fail
- Ownership verification kept at controller level (CheckLog pattern) rather than duplicated in each use case.
- Post-PR polish: centralized `EXPENSE_VALIDATION` constants, `ListExpenses` use case relies on repository ordering, test coverage for ownership mismatch, editor pins TypeScript to the workspace version.
- **V1 Cluster visual refresh handoff archived** (docs/polish).

**Learned:**

- Amounts stored as integer cents end-to-end avoids float drift — `Math.round(euros * 100)` is non-negotiable (`2.995 €` → `300` cents, not `299`).
- `EXPENSE_VALIDATION.CATEGORIES` was removed because it created a circular import between `entities/` and `validation/`; inline `Object.values(ExpenseCategory)` does the job without breaking layer boundaries.
- Ownership checks belong at the controller, not inside each use case — plan wording was "in every use case", but reusing the CheckLog trade-off kept the application layer free of HTTP concerns.
- Partial update orchestration — only apply `update*()` methods for fields `!== undefined`; `null` clears, `undefined` leaves unchanged — matches Prisma semantics and avoids silent data loss.

**Blockers:**

- None

---

### Week of Apr 6-12, 2026

> 7 commits | 1 PR merged

**Worked on:**

- **PR #46:** Feature 05 Dashboard — dashboard feature composing existing hooks, centralized act export in test-utils, scoped container spec spies, fixed duplicate fetchStatuses call in logCheck
- Feature 05 phases marked complete in PROGRESS.md
- Config cleanup: removed deprecated baseUrl from tsconfigs
- Feature 06 (Expenses) shape document written, progress tracking updated

**Learned:**

- Dashboard as a composition of existing hooks (not new data fetching) validates the hexagonal approach — the feature is thin UI over already-tested application logic
- Scoping spies to each test (`beforeEach`) instead of sharing them across the suite prevents flaky test interactions

**Blockers:**

- None

---

### Week of Mar 23-29, 2026

> 33 commits | 6 PRs merged

**Worked on:**

- **Check-logging feature — full stack in 4 days (PRs #40-43):**
  - **PR #40 (Mar 25) — Block 1:** Prisma CheckLog model, domain entity, value objects, repository interface
  - **PR #41 (Mar 27) — Block 2:** Application DTOs, mapper with status computation (overdue/due-soon/ok/never), use cases with date arithmetic, infrastructure layer, NestJS module
  - **PR #42 (Mar 28) — Block 3:** Frontend API service, Nanostores store, useCheckLogs hook, leaf components, LogCheckForm/LogCheckDialog, CheckLogList, CheckLogContainer
  - **PR #43 (Mar 28) — Block 4:** Integration into check-types (status badges, log buttons), check-logs Astro page, layout polish
- **PR #44 (Mar 28):** DialogShell extracted as shared Radix Dialog component — ConfirmDialog and LogCheckDialog both refactored to use it
- **PR #45 (Mar 28 → main):** Release of check-logging feature + dashboard planning docs
- Feature 05 (Dashboard) shape document written, PROGRESS.md updated
- Auth fix: reverted useSecureCookies — Better Auth prefixes cookies with `__Secure-` when enabled, breaking cross-origin session detection

**Learned:**

- Third feature (check-logging) built even faster than check-types — hexagonal patterns are now muscle memory
- Status computation logic (overdue/due-soon/ok/never) based on date arithmetic belongs in the application mapper, not the frontend — single source of truth
- Extracting DialogShell after two dialogs existed (ConfirmDialog, LogCheckDialog) is the right moment — pattern proven, not speculative

**Blockers:**

- None

---

### Week of Mar 9-15, 2026

> 24 commits | 5 PRs merged

**Worked on:**

- **PR #35 (Mar 11) — Final design system migration block:** profile, admin, and vehicle features migrated to DaisyUI semantic colors and card layouts; auth pages and misc components migrated to semantic color tokens; ConfirmDialog overlay migrated; `react-icons` and `astro-icon` dependencies removed entirely, replaced by local Astro icon components and Lucide icons.
- **PR #36 (Mar 12 → main):** Release — Features 02 (Check Types) + 03 (UI Design System).
- **PR #37 (Mar 12):** Full dependency update across the project, Bun bumped 1.3.5 → 1.3.10.
- **PR #38 (Mar 14) — Fly.io deployment:** Docker hardening (production flag, Prisma in deps), cross-origin auth adaptation, server-side API proxy for same-origin cookie flow, `tsc-alias` for path resolution in build output, Fly.io config added.
- **PR #39 (Mar 14 → main):** Release — Blocks 2-4 (Docker fixes, dependency updates, Fly.io deployment).
- MVP and PROGRESS docs updated for post-Feature 03 housekeeping.

**Learned:**

- Cross-origin auth with Better Auth requires careful cookie handling — server-side API proxy keeps cookies on the same origin.
- `tsc-alias` is needed to resolve TypeScript path aliases (`@/...`) in compiled output — TSC doesn't do this natively.
- Pinning `better-auth` to an exact version prevents surprise breaking changes from minor updates.
- Cleaning up unused icon libraries at the end of a migration reduces bundle size and eliminates phantom dependencies.
- Semantic color tokens (DaisyUI) mean you never hardcode colors — theme changes propagate everywhere automatically.

**Blockers:**

- None

---

### Week of Mar 2-8, 2026

> 40 commits | 7 PRs merged

**Worked on:**

- **Check-types feature completed:** suggested check types with pill-button design, feature barrel export, container integration (PR #28)
- **Design system migration kicked off — 6 PRs in one week:**
  - PR #29: Foundation — DaisyUI + Radix UI + Lucide installed, custom dark theme configured, base styles simplified
  - PR #30: Shared UI components migrated — Button (btn classes), Input, Label, Textarea, Select (DaisyUI form classes), FormWrapper (DaisyUI alert), ConfirmDialog (Radix UI Dialog)
  - PR #31: Layouts migrated — Main.astro (DaisyUI navbar with responsive menu), AdminLayout (DaisyUI menu)
  - PR #32: Auth components migrated to DaisyUI semantic classes, ARIA live-region roles added
  - PR #33: Vehicle feature migrated — VehicleForm with fieldset grouping and responsive grid, VehicleContainer and VehicleProfile with semantic classes
  - PR #34: Check-types feature migrated — CheckTypeCard, CheckTypeList, CheckTypeContainer with empty state, SuggestedCheckTypes pill-button design
- Label component enhanced with error prop and aria-hidden required indicator
- Input, Textarea, Select now integrate Label with fullWidth default
- fade-in-up animation utility added
- astro-icon integration removed, replaced by local Astro icon components

**Learned:**

- DaisyUI's semantic class system (`btn-primary`, `input-bordered`, `card`) eliminates the need for custom Tailwind utility soup — much more readable
- Radix UI Dialog handles focus trapping, scroll locking, and accessibility out of the box — no more custom ConfirmDialog logic
- Migrating a design system systematically (foundation -> shared UI -> layouts -> features) prevents cascading breakage
- Integrating Label directly into Input/Textarea/Select reduces boilerplate in every form

**Blockers:**

- None

---

### Week of Feb 23 - Mar 1, 2026

> 19 commits | 3 PRs merged

**Worked on:**

- **PR #25 (Feb 23):** Check-types container, list, and card components — presentational/container split with CheckTypeContainer state management.
- **PR #26 (Feb 23):** CheckTypeForm component + shared Textarea UI component, plus fixes to shared UI component bugs.
- **PR #27 (Feb 28) — Check-types CRUD flows:** create, edit, and delete flows wired into CheckTypeContainer; DeleteCheckTypeDialog component added; CheckTypeList simplified to pure card renderer (single responsibility).
- Plan phases 13-16 revised and open questions resolved.

**Learned:**

- Keeping CheckTypeList as a pure renderer and lifting state management to the Container follows the presentational/container pattern — easier to test each in isolation.
- Revising the plan mid-feature (phases 13-16) based on what you've learned while building is healthy, not a sign of poor planning.

**Blockers:**

- None

---

### Week of Feb 16-22, 2026

> 31 commits | 7 PRs merged | 6 issues closed

**Worked on:**

- **Check-types feature kickoff (domain → infrastructure → frontend scaffolding):**
  - **PR #17 (Feb 16):** Domain layer — entity, value objects, repository interface, exceptions.
  - **PR #18 (Feb 17):** Application layer — DTOs, mapper, CRUD use cases, CheckType service facade.
  - **PR #19 (Feb 19):** Infrastructure layer — Prisma repository, infrastructure mapper, REST controller with vehicle ownership verification; module wiring and app registration.
- **Check-types frontend scaffolding:**
  - **PR #22 (Feb 19):** Frontend setup — type definitions, Zod validation schemas, `/check-types` page, navigation link.
  - **PR #23 (Feb 19):** Fixed deprecated Zod v4 API usage across all validation schemas.
  - **PR #24 (Feb 22):** Data layer — API service, Nanostores state store, `useCheckTypes` hook (all with tests).
- **PR #12 (Feb 16 → main):** Release — Vehicle Profile feature + auth fixes.
- **6 issues (#6, #7, #8, #9, #10, #11) opened and closed in one go on Feb 16** — memory leak in apiRequest, cross-feature import in ChangePasswordForm, hardcoded year 2030, duplicated handleApiResponse helper, console.log replacement with Logger service, missing useEffect dependency in VehicleContainer.
- Bug fixes in shared UI: Input `w-full` and `aria-invalid` bugs, Select `aria-invalid` bug, missing tests added for Button, Label.

**Learned:**

- Building the second feature (check-types) went much faster than vehicles — the patterns from hexagonal architecture were already established.
- Zod v4 deprecated some APIs (`.refine()` signature change) — catching these early prevents runtime surprises.
- Adding tests for shared UI components (Button, Label, Input, Select) retroactively pays off immediately when those components get modified.
- Batching refactor issues (6 opened then closed in one day) trains the `/ship` workflow without scattering the effort across weeks.

**Blockers:**

- None

---

### Week of Feb 9-15, 2026

> 38 commits | 4 PRs merged

**Worked on:**

- **PR #4 (Feb 14) — Vehicle profile frontend complete:** VehicleContainer with all modes (create, edit, view, delete), page wiring, navigation link; VehicleForm, VehicleProfile, ConfirmDialog, DeleteVehicleDialog, VehicleEmptyState, QuickMileageUpdate, formatMileage/formatDate utilities.
- Big CI fix round: test isolation (`mock.module` vs `spyOn`), turbo cache disabled, Bun bumped 1.3.3 → 1.3.5.
- **Massive refactoring on Feb 15 — 3 PRs landed the same day:**
  - **PR #14:** Replace hardcoded year 2030 with dynamic validation.
  - **PR #15:** Consolidate duplicated `handleApiResponse` helper.
  - **PR #16:** Remove cross-feature import in ChangePasswordForm.
- Console.log replaced with Logger service, double-timeout memory leak fixed in `apiRequest`, duplicate `/api` prefix fix, `changePasswordSchema` moved out of auth feature — all opened as issues mid-refactor, closed the following Monday.

**Learned:**

- Bun's `mock.module` behaves differently from `spyOn` for test isolation in CI — `spyOn` can leak between tests
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

- **Full infrastructure layer**: PrismaVehicleRepository, infrastructure mapper (Prisma <-> domain), REST controller for vehicle endpoints, VehiclesModule wired into app
- PR #2 merged: infrastructure layer (Phase 4)
- PR #3 merged: VehiclesModule wiring
- **Frontend kickoff**: client-side types + Zod schemas, API service for vehicle endpoints, Nanostores store, useVehicle hook (Nanostores -> React bridge), reusable Select component
- sample-project (base template) fixes: post-signup redirect path, email verification URL, duplicate /api prefix removal in browser requests

**Learned:**

- The infrastructure mapper translates between Prisma types and domain — key isolation layer in hexagonal architecture
- Nanostores is lightweight and framework-agnostic, ideal for a shared store between Astro/React components
- Fixing the /api prefix in sample-project propagates to all projects using that template

**Blockers:**

- None

---

### Week of Jan 26 - Feb 1, 2026

> 0 commits (pause week — see cube-master/JOURNAL.md)

**Worked on:**

- Car-cost-tracker on pause this week
- CubeMaster detour: Spark AI session (see cube-master/JOURNAL.md for the explosive details), then clean restart with React/Vite and a proper vision document

**Learned:**

- Sometimes you need to "chew on a bone" so you don't abandon the steak (Road to Six philosophy in action)
- Spark AI and the frustration of debugging a Rubik's Cube algorithm that says "SOLVED" when the cube clearly isn't

**Blockers:**

- None (voluntary pause)

---

### Week of Jan 19-25, 2026

> 13 commits | 1 PR merged

**Worked on:**

- **Full application layer**: application mapper, CreateVehicle and GetVehicleByUser use cases, then all remaining use cases (update, delete, get by id)
- VehicleService orchestration layer — facade coordinating use cases
- Barrel exports for DTOs and use cases
- **PR #1 merged on Jan 25**: Vehicle Profile backend (Phase 1-3) — first real milestone
- Post-merge fixes: improved DTO validation (mileage excluded from UpdateVehicleDto), undefined instead of null for optional fields, fuelType nullable in GetVehicleDto, perf optimization (single DB query instead of multiple)

**Learned:**

- Optimizing use cases to a single DB query instead of multiple — significant perf impact
- The difference between `null` and `undefined` for optional fields in TypeScript with Prisma — `undefined` = "don't touch", `null` = "erase"
- Barrel exports keep imports clean between layers

**Blockers:**

- None

---

### Week of Jan 12-18, 2026

> 5 commits

**Worked on:**

- **Domain layer finalized**: VehicleEntity with validated mutations and tests, repository interface and domain exceptions
- **Application layer started**: DTOs for vehicle operations (Create, Update, Get), validation constants
- Cleaned up a leftover TODO comment in Year.vo.spec.ts

**Learned:**

- Domain Value Objects (VehicleId, Vin, Year, Mileage) encapsulate business validation rules — the domain is self-protecting
- The repository interface in the domain defines the contract without depending on an implementation (Dependency Inversion)

**Blockers:**

- None

---

### Week of Jan 5-11, 2026

> 3 commits

**Worked on:**

- **Project launch**: initial setup on Jan 10 (monorepo, config, structure)
- First domain steps: Vehicle model in Prisma schema, Value Objects (VehicleId, Vin, Year, Mileage) with tests
- In parallel: forklift-fleet-check repo created with initial setup on Jan 7

**Road to Six context:**

- The road-to-six meta-repo was created on Jan 3 with full documentation structure (README, PROJECTS.md, MVPs, JOURNALs for each project)
- Feature Shape Template added on Jan 5
- Detailed MVPs for car-cost-tracker and trading-journal on Jan 4

**Learned:**

- Monorepo structure with Turborepo + Bun allows sharing config between apps/api and apps/web
- Starting with the domain layer in hexagonal architecture = solid foundations before anything else

**Blockers:**

- None

---

_Add new entries above this line, newest first._
