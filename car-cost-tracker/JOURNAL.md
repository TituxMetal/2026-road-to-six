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
| Commits       | 160                   |
| PRs merged    | 24                    |
| Issues closed | 6                     |
| Weeks active  | 10                    |
| Period        | Jan 5 — Mar 11, 2026  |

---

## Entries

### Week of Mar 10-11, 2026 (partial)

> 8 commits | 1 PR merged

**Worked on:**

- **Final design system migration block (PR #35):** migrated profile, admin, and vehicle features to DaisyUI semantic colors and card layouts
- Auth pages and misc components migrated to semantic color tokens
- ConfirmDialog overlay migrated to semantic color
- Removed `react-icons` and `astro-icon` dependencies entirely — replaced by local Astro icon components and Lucide icons

**Learned:**

- Cleaning up unused icon libraries at the end of a migration reduces bundle size and eliminates phantom dependencies
- Semantic color tokens (DaisyUI) mean you never hardcode colors — theme changes propagate everywhere automatically

**Blockers:**

- None

---

### Week of Mar 3-9, 2026

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

### Week of Feb 24 - Mar 2, 2026

> 5 commits | 1 PR merged

**Worked on:**

- **Check-types CRUD flows (PR #27):** create, edit, and delete flows wired into CheckTypeContainer
- DeleteCheckTypeDialog component added
- CheckTypeList simplified to pure card renderer (single responsibility)
- Plan phases 13-16 revised and open questions resolved

**Learned:**

- Keeping CheckTypeList as a pure renderer and lifting state management to the Container follows the presentational/container pattern — easier to test each in isolation
- Revising the plan mid-feature (phases 13-16) based on what you've learned while building is healthy, not a sign of poor planning

**Blockers:**

- None

---

### Week of Feb 17-23, 2026

> 37 commits | 7 PRs merged

**Worked on:**

- **Check-types feature — full backend in 3 days:**
  - PR #18: Application layer — DTOs, mapper, CRUD use cases, CheckType service facade
  - PR #19: Infrastructure layer — Prisma repository, infrastructure mapper, REST controller with vehicle ownership verification
  - Module wiring and app registration
- **Check-types frontend kickoff:**
  - PR #22: Frontend setup — type definitions, Zod validation schemas, page, navigation link
  - PR #24: Data layer — API service, Nanostores state store, useCheckTypes hook (all with tests)
  - PR #25: UI components — CheckTypeCard, CheckTypeList, CheckTypeContainer with tests, mounted in Astro page
  - PR #26: CheckTypeForm component, Textarea shared UI component
- PR #23: Fixed deprecated Zod v4 API usage across all validation schemas
- Bug fixes in shared UI: Input `w-full` and `aria-invalid` bugs, Select `aria-invalid` bug, missing tests added for Button, Label

**Learned:**

- Building the second feature (check-types) went much faster than vehicles — the patterns from hexagonal architecture were already established
- Zod v4 deprecated some APIs (`.refine()` signature change) — catching these early prevents runtime surprises
- Adding tests for shared UI components (Button, Label, Input, Select) retroactively pays off immediately when those components get modified

**Blockers:**

- None

---

### Week of Feb 9-15, 2026

> 38 commits | 5 PRs merged | 6 issues

**Worked on:**

- Vehicle page finale: VehicleContainer with all modes (create, edit, view, delete), page wiring, navigation link
- Big CI fix round: test isolation (mock.module vs spyOn), turbo cache disabled, Bun bump 1.3.3 -> 1.3.5
- Frontend components finalized: VehicleForm, VehicleProfile, ConfirmDialog, DeleteVehicleDialog, VehicleEmptyState, QuickMileageUpdate, formatMileage/formatDate utilities
- **Massive refactoring on Feb 15**: shared handleApiResponse extraction, dynamic year validation (no more hardcoded 2030), console.log replaced with Logger service, double timeout memory leak fix in apiRequest, duplicate /api prefix fix, changePasswordSchema moved out of auth feature
- 6 issues opened (refactoring + bugs) then closed in one go
- PR #12 "Release: Vehicle Profile feature + auth fixes" merged

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
