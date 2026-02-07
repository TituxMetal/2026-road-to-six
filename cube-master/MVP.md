# CubeMaster — MVP Definition

## Overview

A complete Rubik's Cube companion app combining three modes: **Solver** (input cube state, get
step-by-step solution), **Coach** (learn solving methods from beginner to advanced), and **Timer**
(speedcube timer with scrambles and stats).

**Primary User:** Someone returning to cubing (or starting fresh) who wants to rebuild their skills
**Core Problem:** Going from "I'm stuck" to "I'm getting faster" with a single integrated tool

## MVP Scope

### What MVP Delivers

- Solver: input any valid cube state, receive a working step-by-step solution
- Coach: learn the beginner method from scratch using progressive tutorials
- Timer: practice speedsolving with scrambles and track progress
- Clean TypeScript engine with domain-driven architecture

### What MVP Does NOT Include

- Kociemba optimal solver (significant complexity, v2)
- 3D cube visualization
- Bluetooth smart cube integration
- User accounts / cloud sync
- Competition mode (WCA regulations)
- Other cube sizes (2×2, 4×4, etc.)

## Architecture Foundation

The project is built on a clean TypeScript engine:

- `cube/domain`: Pure model (pieces, state, moves, geometry)
- `cube/application`: Use-cases (solve, scramble, apply moves)
- `cube/infrastructure`: Adapters (rendering, random)
- `features/cube`: React UI (components, stores, hooks)

The Solver engine is the backbone — Coach and Timer both leverage it.

## Mode 1: Solver

### Purpose

User inputs their cube state → receives a step-by-step solution.

### Features

| Feature             | MVP | Details                                              |
| ------------------- | --- | ---------------------------------------------------- |
| Cube input          | ✓   | 2D net view, tap square to cycle colors              |
| Input validation    | ✓   | Detect invalid states (wrong color count, impossible) |
| Solution generation | ✓   | Layer-by-layer method (~50-100 moves)                |
| Solution display    | ✓   | List of moves in standard notation (R, U', F2, etc.) |
| Step navigation     | ✓   | Prev/Next buttons to walk through solution           |
| Cube visualization  | ✓   | 2D net updates to show current step                  |
| Move animation      | ○   | Optional: animate face rotation                      |
| Optimal solver      | ✗   | Kociemba algorithm (v2, significant complexity)      |

### Technical Requirements

- `applyMove(state, token)` for all 18 moves (U, U', U2, R, R', R2, etc.)
- Layer-by-layer solver algorithm:
  1. White cross
  2. White corners
  3. Second layer edges
  4. Yellow cross
  5. Yellow edges
  6. Yellow corners position
  7. Yellow corners orientation
- Solution stored as `MoveToken[]`

## Mode 2: Coach

### Purpose

Progressive tutorials to learn solving methods, using the Solver engine for demonstrations.

### Features

| Feature           | MVP | Details                                               |
| ----------------- | --- | ----------------------------------------------------- |
| Lesson browser    | ✓   | Categories: Beginner / Intermediate / Advanced        |
| Lesson content    | ✓   | Text explanation + algorithms + cube visualization    |
| Algorithm display | ✓   | Standard notation with optional finger tricks         |
| Live demo         | ✓   | Show algorithm effect on cube (uses Solver engine)    |
| Practice mode     | ✓   | Scramble to specific case, user applies algorithm     |
| Progress tracking | ○   | Mark lessons as learned (localStorage)                |
| Quiz mode         | ✗   | Test recognition of cases (v2)                        |

### Content Structure

**Beginner (Layer-by-Layer)**

- White cross
- White corners
- Second layer (F2L basics)
- Yellow cross
- Yellow face
- Final layer

**Intermediate**

- Intuitive F2L (First Two Layers)
- 2-look OLL (Orientation Last Layer)
- 2-look PLL (Permutation Last Layer)

**Advanced**

- Full OLL (57 algorithms)
- Full PLL (21 algorithms)
- Advanced F2L tricks

### Technical Requirements

- Reuses `CubeState`, `applyMove`, `toStickers` from Solver
- Lesson data structure: title, category, explanation, algorithms[], practice cases[]
- Practice mode: generate specific scramble that creates target case

## Mode 3: Timer

### Purpose

Speedcube timer with scrambles and session tracking.

### Features

| Feature            | MVP | Details                                          |
| ------------------ | --- | ------------------------------------------------ |
| Scramble generator | ✓   | Random 20-25 move scramble, standard notation    |
| Scramble display   | ✓   | Text notation                                    |
| Scramble preview   | ○   | 2D net showing scrambled state                   |
| Timer              | ✓   | Start/stop with spacebar or tap                  |
| Inspection time    | ○   | Optional 15-second countdown before solve        |
| Session history    | ✓   | List of times with scrambles                     |
| Statistics         | ✓   | Best, Worst, Average of 5, Average of 12         |
| Progression graph  | ○   | Chart showing improvement over time              |
| Session management | ○   | Multiple sessions, session names                 |
| Data persistence   | ✓   | localStorage for times                           |

### Technical Requirements

- Scramble uses `Random` contract (reproducible for tests)
- Timer precision: milliseconds display, centiseconds minimum
- Stats calculations: Ao5/Ao12 exclude best and worst times
- Session data: `{ scramble: string, time: number, date: Date, dnf?: boolean }`

## UI/UX

### Visual Design

- Dark theme (primary)
- Cube colors: refined palette, not toy-store RGB
- Clean typography, generous spacing
- Mobile-first, comfortable on desktop

### Navigation

- Home: Three mode cards (Solve / Learn / Train)
- Persistent nav bar for direct access to any mode
- Back navigation within each mode

### Key Components

- `CubeNet`: 2D unfolded view (shared across all modes)
- `MoveNotation`: Display move sequences with optional highlighting
- `Timer`: Reusable timer component with keyboard support

## Development Phases

### Phase 0: Engine Foundation

- [x] Domain constants (Color, Face, positions)
- [x] Guards (type safety)
- [x] Piece types (Corner, Edge)
- [x] CubeState structure
- [x] createSolvedState
- [x] Sticker mapping (geometry)
- [x] toStickers (render adapter)
- [ ] Nanostore integration
- [ ] UI binding (CubeNet displays real state)

### Phase 1: Moves & Manipulation

- [ ] Move tokens (U, U', U2, etc.)
- [ ] Move tables (cycles + orientation deltas)
- [ ] applyMove implementation
- [ ] All 18 basic moves
- [ ] Tests (move × 4 = identity)
- [ ] UI controls (buttons for moves)

### Phase 2: Timer Mode

- [ ] Scramble generator
- [ ] Timer component
- [ ] Session storage (localStorage)
- [ ] Statistics calculations
- [ ] Timer UI (scramble + timer + history)

### Phase 3: Solver Mode

- [ ] Layer-by-layer algorithm
  - [ ] White cross solver
  - [ ] White corners solver
  - [ ] Second layer solver
  - [ ] Yellow cross solver
  - [ ] Yellow edges solver
  - [ ] Yellow corners solver
- [ ] Solution display component
- [ ] Step-by-step navigation
- [ ] Cube input UI (tap to change colors)
- [ ] Input validation

### Phase 4: Coach Mode

- [ ] Lesson data structure
- [ ] Beginner content
- [ ] Lesson browser UI
- [ ] Algorithm demonstration
- [ ] Practice mode (scramble to case)
- [ ] Intermediate content
- [ ] Advanced content (if time permits)

### Phase 5: Polish

- [ ] Responsive design pass
- [ ] Keyboard shortcuts
- [ ] Error handling
- [ ] Performance optimization
- [ ] PWA support (optional)

## Tech Stack

- Vite + React + TypeScript
- Nanostore (state management)
- Vitest (testing)
- Tailwind CSS v4
- No backend, no database (localStorage only)

## Success Criteria

MVP is complete when:

1. **Solver**: User can input any valid cube state and receive a working solution
2. **Coach**: User can learn the beginner method from scratch using the tutorials
3. **Timer**: User can practice speedsolving with scrambles and track their progress

## Prototype

- [rubiks-cube-solver-codespace](https://github.com/TituxMetal/rubiks-cube-solver-codespace) —
  Spark/Codespace prototype (Phase 0 engine foundation)
