# CODEX_PHASE_PROMPTS.md - Copy-Ready Build Prompts

Paste one prompt at a time. After each phase, review the code, run the application and confirm the acceptance criteria before proceeding.

## Global Starter Prompt

```text
You are the lead engineer implementing my university project: AI Pac-Man: CF321 Search Lab (PAC-MIND).
Read AGENTS.md, PROJECT_SPEC.md, COURSE_ALIGNMENT.md and START_HERE.md completely.
PROJECT_SPEC.md is the binding product and architecture contract.
This is an academic classical-AI project, not a machine-learning project.
Use React + TypeScript + Vite + Phaser 3. Keep the AI algorithms in pure TypeScript modules.
Build incrementally. Implement PHASE 0 ONLY from CODEX_PHASE_PROMPTS.md.
Do not create fake AI behavior, hard-coded search paths, random ghost decisions or invented benchmark values.
Add tests for implemented functionality. Run the checks that are available and report exact commands and actual outcomes.
Do not start Phase 1 until I explicitly ask.
Stop after Phase 0 and use the handoff report format in AGENTS.md.
```

## Phase 0 - Repository and Development Bootstrap

**Goal:** create a clean, runnable application foundation.

```text
Implement Phase 0 only.
Create a Vite + React + TypeScript application and install/configure Phaser 3.
Enable strict TypeScript. Add ESLint, Prettier and Vitest with working starter tests.
Create the source folders described in PROJECT_SPEC.md for app, components, game, AI search, agents, adversarial search, visualization, state and styles.
Create a basic React app shell with a dark neon theme and placeholder navigation for Main Game, Search Lab and AI Duel. Do not represent those modes as implemented yet.
Add a minimal Phaser scene that can be mounted and destroyed safely from React.
Add npm scripts: dev, build, preview, lint, format, typecheck, test and test:watch.
Add README setup instructions and .gitignore. No backend, database, external AI API or secrets.
Run npm install, lint, typecheck, tests and build. Report actual results. Stop after Phase 0.
```

**Acceptance criteria:** app starts with `npm run dev`; Phaser mounts and unmounts without duplicate listeners; scripts run; TypeScript is strict; no later-phase feature is faked as complete.

## Phase 1 - Playable Maze Foundation

**Goal:** create the first playable game without AI ghosts.

```text
Implement Phase 1 only, following PROJECT_SPEC.md.
Create one original grid-based maze and a validated MazeMap representation. Add wall, floor, pellet, power-pellet, player-spawn and ghost-spawn tile types.
Render the maze in Phaser using original vector/simple shapes. Add a Pac-Man character with smooth tile-to-tile interpolation and a mouth animation.
Implement Arrow-key and WASD movement, buffered turns, wall collision, pellet collection, score, lives, pause, resume, restart, level-complete and game-over states.
Use a fixed simulation tick separate from render FPS. Add a HUD in React.
Do not add moving ghosts or search algorithms yet. Add unit/integration tests for maze validation, legal movement, pellet scoring, collision boundaries, restart and state transitions.
Run lint, typecheck, tests and build. Stop after Phase 1.
```

**Acceptance criteria:** Pac-Man moves only through corridors; pellets are collected once; score/lives update correctly; pause/restart work; the scene does not duplicate event listeners.

## Phase 2 - Uninformed Search: BFS, DFS and UCS

**Goal:** implement the core search engine independently of Phaser.

```text
Implement Phase 2 only.
Create pure TypeScript SearchProblem, SearchNode, SearchResult and SearchTraceEvent types based on PROJECT_SPEC.md.
Implement deterministic neighbor generation in the order UP, RIGHT, DOWN, LEFT.
Implement Breadth-First Search with a FIFO queue, Depth-First Search with a LIFO stack, and Uniform-Cost Search with a min-priority queue ordered by accumulated path cost g(n).
Use stable state keys and duplicate-state handling. Reconstruct paths from parent links. Return a real failure result when no path exists.
Record expanded count, generated count, maximum frontier size, elapsed algorithm time and ordered trace events.
Do not connect algorithms to ghosts or create fake animation yet.
Add tests: BFS shortest path on a known unit-cost maze; DFS valid path without a shortest-path assertion; UCS minimum cost on a positive weighted graph; BFS/UCS equal optimal path cost on a unit-cost maze; unreachable goal; path reconstruction; repeated-state handling.
Run lint, typecheck, tests and build. Stop after Phase 2.
```

**Acceptance criteria:** all three algorithms return valid results; BFS/UCS meet their cost guarantees; DFS is not labelled optimal; tests are deterministic.

## Phase 3 - Informed Search: Greedy, A* and Graph Search

**Goal:** implement the lecture's heuristic algorithms and their guarantees.

```text
Implement Phase 3 only.
Add Manhattan distance and implement Greedy Best-First Search ordered by f(n)=h(n).
Implement A* ordered by f(n)=g(n)+h(n), using a min-priority queue.
Implement graph search with a Set-based closed set. Track best known g-costs and correctly update/reopen a state if a cheaper path is found where required.
Test the goal when the node is removed from the frontier, not merely when it is generated.
Document the course conditions: A* tree search is optimal with an admissible heuristic; A* graph search is optimal with a consistent heuristic; consistency implies admissibility; UCS is A* with h(n)=0.
For the MVP's four-direction, unit-cost maze with no portals, test that Manhattan distance is admissible and consistent.
Add tests that A* and BFS return equal optimal path costs on the same unit-cost mazes, Greedy is not assumed optimal, closed states are not expanded repeatedly, and no-path cases terminate.
Do not add ghosts yet. Run all checks and stop after Phase 3.
```

**Acceptance criteria:** Greedy uses h only; A* uses g+h; graph search uses a closed set; A* goal termination and heuristic tests pass.

## Phase 4 - Search Lab and Animated Search Visualization

**Goal:** make the algorithms visible and comparable.

```text
Implement Phase 4 only.
Build the Search Lab UI using the existing search engine. Let the user select a map, start cell, goal cell and one of BFS, DFS, UCS, Greedy or A*.
Visualize the actual ordered SearchTraceEvent stream: unvisited, frontier, current expanded node, closed/expanded cells, start, goal and final path.
Add Play, Pause, Step, Reset and speed controls. Add a permanent legend and textual algorithm explanation.
Build an Algorithm Comparison view that runs all five algorithms against the exact same map, start, goal, neighbor order and movement costs.
Display actual path cost, path length, expanded nodes, generated nodes, maximum frontier and measured algorithm execution time. Do not include visualization playback time in the algorithm runtime. Do not hard-code metrics or fake search events.
Add tests for trace order, reset behavior, comparison input equality and UI state. Run all checks and stop after Phase 4.
```

**Acceptance criteria:** every animated cell state comes from a real algorithm trace; comparisons use identical inputs; metrics are measured; controls work.

## Phase 5 - Intelligent Ghost Agents and Main Game Integration

**Goal:** make the ghosts plan and move using the implemented algorithms.

```text
Implement Phase 5 only.
Create GhostAgent and GhostManager modules. Each ghost must have a configurable search algorithm and target policy.
Default demonstration mapping: Red=A*, Pink=Greedy, Cyan=BFS, Orange=DFS. Make UCS selectable in ghost settings and Search Lab.
For each planning snapshot, use the ghost's current cell as start and Pac-Man's current cell as goal. Run the configured algorithm and follow the returned path one tile at a time.
Re-plan when Pac-Man changes grid cell, the target/map changes or a configured interval expires. Never run search on every render frame.
Implement chase, frightened and respawning modes. In frightened mode, choose a legal move that increases maze distance from Pac-Man and label this as a flee heuristic, not A* or Minimax.
Add an AI Overlay that displays the selected ghost's target, frontier, expanded/closed cells and current path.
Handle no-path cases and scene restart safely. Add tests for ghost legal movement, target changes, re-planning, algorithm assignment, frightened behavior and collision integration.
Run all checks and stop after Phase 5.
```

**Acceptance criteria:** ghosts follow legal routes; algorithm choice changes search behavior; overlay reflects real trace events; no frame-by-frame pathfinding; collision and respawn work.

## Phase 6 - Adversarial Search: Minimax and Alpha-Beta AI Duel

**Goal:** demonstrate Lecture 5 in a correct alternating-turn environment.

```text
Implement Phase 6 only.
Create a separate turn-based AI Duel mode. Pac-Man is MAX and one ghost is MIN. Each ply is one legal move by one player. Use a configurable fixed search depth, default 4 plies.
Define an immutable duel state containing Pac-Man position, ghost position, remaining objective pellets, active player and terminal status.
Implement Minimax with MAX taking the maximum child value and MIN taking the minimum child value. Use terminal utilities for caught/win states and the documented non-terminal evaluation function from PROJECT_SPEC.md.
Implement Alpha-Beta pruning with alpha as MAX's best bound and beta as MIN's best bound. Prune when alpha >= beta.
Return the same move/value as Minimax for identical state, depth, evaluation and move ordering. Record nodes visited, leaves evaluated, alpha/beta updates and pruned branches.
Visualize the game tree with MAX/MIN labels, leaf values, backed-up values and pruned branches. Add tests on hand-calculated trees and verify Alpha-Beta equivalence to Minimax.
Do not apply Minimax to the normal real-time chase. Run all checks and stop after Phase 6.
```

**Acceptance criteria:** turn order is explicit; Minimax and Alpha-Beta choose the same move/value for identical inputs; alpha>=beta pruning is tested and visible.

## Phase 7 - Final Polish, Evaluation and Submission Readiness

**Goal:** make the project stable, understandable and ready to demonstrate.

```text
Implement Phase 7 only.
Review the full application against PROJECT_SPEC.md and COURSE_ALIGNMENT.md.
Polish the neon interface, menus, HUD, ghost labels, legends, responsive layout, keyboard focus and reduced-motion support. Add sound toggle if assets are available and properly licensed.
Add or complete Playwright end-to-end tests for Main Game, Search Lab comparison and AI Duel.
Profile rendering and search on the supplied maps. Fix memory leaks, duplicate Phaser listeners, timer bugs and restart issues.
Add DLS, IDS or bidirectional search only if all required algorithms and tests are already stable; treat them as optional extensions.
Create README, COURSE_ALIGNMENT.md, DEMO_SCRIPT.md and a final evaluation template. Run and report actual lint, typecheck, unit/integration/e2e tests and production build results.
Do not invent accuracy, performance or benchmark values. Stop after Phase 7 and provide a complete final report.
```

**Acceptance criteria:** all core modes work; tests and production build pass or blockers are reported; documentation explains algorithm assumptions and actual measured results.

## Targeted repair prompt

```text
Fix only the following issue in the current phase: [paste exact error or failing behavior].
First reproduce it and identify the root cause. Make the smallest appropriate change, add a regression test, run the relevant checks and report actual results. Do not implement later phases or refactor unrelated modules.
```

## Phase audit prompt

```text
Audit the current implementation against the acceptance criteria for Phase [N] in CODEX_PHASE_PROMPTS.md and PROJECT_SPEC.md. Do not add features. Inspect the code and tests, run the relevant commands, identify unmet criteria and academic inaccuracies, and produce a pass/fail checklist with file references. Pay special attention to fake traces, incorrect search priorities, goal testing on enqueue, closed-set handling, A* heuristic guarantees, and Minimax/Alpha-Beta equivalence.
```
