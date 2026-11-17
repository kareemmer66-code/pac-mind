# AI Pac-Man: CF321 Search Lab

**Project codename:** PAC-MIND  
**Edition:** Academic  
**Visual direction:** Neon arcade  
**Course:** CF321 - Fundamentals of Artificial Intelligence  
**Document type:** Product requirements, technical architecture, AI design, testing plan and implementation contract for Codex  
**Status:** Proposed specification. This document describes what Codex must build; it is not evidence that the application already exists.

## 1. Executive summary

AI Pac-Man: CF321 Search Lab is a browser-based, animated maze-chase game and interactive Artificial Intelligence laboratory. The player controls Pac-Man while intelligent ghosts navigate the maze using search algorithms taught in CF321. A separate Search Lab lets students run the same search problem with different algorithms and watch the frontier, expanded states, closed set and final path animate. A separate turn-based AI Duel demonstrates Minimax and Alpha-Beta pruning.

The project is deliberately an implementation of **classical AI**, not a machine-learning chatbot. Its intelligence comes from explicit state-space representations, rational goal-directed agents, heuristic search and adversarial game-tree search. It is designed to make the algorithms visible and measurable, so a student can explain exactly why a ghost selected a route.

**Core academic idea:** one maze can be represented as a search problem and solved using different frontier strategies. The visual game makes the consequences of those strategies observable.

## 2. Problem statement and objectives

Students often understand search algorithms as pseudocode but find it difficult to picture how a frontier is expanded, how a heuristic changes the order of exploration, why repeated states matter, or how an opponent changes a decision. A moving maze provides an intuitive, testable environment for these concepts.

The project objectives are to:

1. Build a complete, playable, visually polished 2D maze-chase game.
2. Model the maze as a state-space graph with states, actions, a successor function, a start state, a goal test and path costs.
3. Implement and compare BFS, DFS, Uniform-Cost Search, Greedy Best-First Search and A*.
4. Animate actual search events rather than fake or pre-scripted paths.
5. Create ghost agents that select actions using the implemented search algorithms.
6. Demonstrate Minimax and Alpha-Beta pruning in a clearly defined alternating-turn game mode.
7. Report measurable search statistics and explain the limitations of each algorithm.
8. Align the design and terminology with the six uploaded CF321 lectures.

## 3. Product scope

### 3.1 Included in the academic edition

- One original, hand-designed maze for the first playable release, with at least two additional maps as a stretch goal.
- Keyboard-controlled Pac-Man movement.
- Walls, corridors, pellets, power pellets, score, lives, win state and game-over state.
- Four ghost agents with configurable search algorithms.
- Search visualization with step, play, pause, reset and speed controls.
- Algorithm comparison on the same map, start cell and goal cell.
- Search metrics: path cost, path length, expanded nodes, generated nodes, maximum frontier size and measured execution time.
- A turn-based AI Duel using Minimax and Alpha-Beta pruning.
- Neon visual theme, responsive HUD, sound toggle and reduced-motion support.
- Automated unit, integration and end-to-end tests.

### 3.2 Explicitly out of scope for the first release

- Machine learning, neural networks, reinforcement learning or training a model.
- External AI APIs, LLM calls, cloud inference or a backend server.
- Multiplayer networking, accounts, leaderboards hosted on a server or LMS integration.
- Recreating an official commercial Pac-Man level, logo, soundtrack or proprietary sprites.
- Full commercial-game feature parity, dozens of levels, cutscenes or monetization.
- Claiming that Greedy Search is optimal, or that a moving-target route is globally optimal over future time.

Use original geometric/vector artwork and original or properly licensed sound effects. The project should be presented as an educational maze-chase inspired by the familiar arcade mechanic.

## 4. User experience and application modes

### 4.1 Main Game

The student controls Pac-Man using Arrow keys or WASD. Pac-Man moves through the maze, collects pellets and avoids ghosts. Ghosts re-plan routes toward Pac-Man using their configured search algorithms. The HUD shows score, lives, current level, ghost algorithm labels and a pause/restart control.

A player can toggle **AI Overlay** to see the active ghost's target, explored cells, frontier, closed set and current planned path. Overlay playback must not change the actual game state.

### 4.2 Search Lab

Search Lab isolates one search problem so algorithms can be compared fairly. The student chooses a map, start cell, goal cell and algorithm. The application runs the selected algorithm and animates the returned trace. The student can step through each event or play the trace at a selected speed.

The comparison panel runs BFS, DFS, UCS, Greedy and A* against the **same** map, start and goal. It presents actual results from each run. It must not fabricate numbers or imply that the fastest wall-clock time on a tiny map proves an algorithm is generally superior.

### 4.3 AI Duel: Minimax vs Alpha-Beta

This is a separate, small, turn-based tactical mode. Pac-Man is MAX and one ghost is MIN. Players alternate one move at a time. The AI searches to a fixed ply depth, evaluates leaf states and selects Pac-Man's move. The student can run Minimax and Alpha-Beta from the same state and compare the selected move, nodes evaluated and branches pruned.

**Important modelling boundary:** the normal arcade chase is real-time and does not alternate one complete player move with one complete opponent move. Therefore Minimax is not presented as the controller of the normal chase. The separate AI Duel creates the alternating-turn game tree required by Lecture 5.

## 5. CF321 course alignment

| Uploaded lecture | Course concepts used in the project | Project implementation |
|---|---|---|
| Lecture 1 - Introduction to AI | AI as the study/design of intelligent agents; acting rationally | Frame the ghosts as goal-directed agents whose actions are selected against a performance measure. The project does not claim human-level understanding or a Turing-test result. |
| Lecture 2 - Intelligent Agents | Agent, percepts, sensors, actuators, rationality, PEAS, task-environment properties | Define Pac-Man and ghost agents using PEAS. Identify the game as a fully observable, deterministic, sequential, dynamic, discrete, multi-agent environment from the simulator's perspective. |
| Lecture 3 - Problem Solving as Search | State-space search, problem components, state-space graph, search tree, repeated states, planning vs reflex agents | Represent maze cells as states, legal moves as actions, corridors as successor transitions, and the player/ghost destination as a goal. Store parent/action/path-cost information in search nodes. |
| Lecture 4 - Blind/Uninformed and Heuristic Strategies | BFS, DFS, depth-limited search, iterative deepening, bidirectional search, UCS, heuristic functions and repeated-state handling | Implement BFS, DFS and UCS in the core comparison. Include DLS, IDS and bidirectional search as optional extensions. Use a closed/visited structure to prevent cycles. |
| Lecture 5 - Adversarial Search | MAX/MIN, Minimax, fixed ply depth, evaluation function, Alpha-Beta pruning | Build the turn-based AI Duel. Pac-Man is MAX, the ghost is MIN, leaf states receive utility values, and Alpha-Beta prunes when alpha >= beta. |
| Lecture 6 - Informed Search | Heuristics, Greedy Search, A*, admissibility, consistency, graph search and closed set | Implement Greedy with f(n)=h(n), A* with f(n)=g(n)+h(n), Manhattan distance, graph search and a visible closed set. Lecture 6 itself includes a small Pac-Man maze example for Greedy Search. |

The project uses the course's terminology: **state, node, frontier/fringe, expand, successor, path cost g(n), heuristic h(n), evaluation f(n), closed set, MAX, MIN, ply, admissible and consistent**.

## 6. Intelligent-agent specification (PEAS)

### 6.1 Ghost agent PEAS

| PEAS element | Definition for this project |
|---|---|
| Performance measure | Catch Pac-Man when in chase mode; choose a legal route; avoid walls; avoid unnecessary loops; in frightened mode increase distance from Pac-Man; operate within the movement and re-planning budget. |
| Environment | A discrete grid maze containing walls, corridors, Pac-Man, pellets, power pellets and other ghosts. |
| Actuators | Move one tile up, down, left or right; wait; switch between chase, frightened and respawn states. |
| Sensors / percepts | Current ghost cell, Pac-Man cell, maze walls, legal neighboring cells, ghost mode, power-pellet timer and relevant map state. |

### 6.2 Pac-Man agent PEAS

In Main Game, the human supplies Pac-Man's actions through the keyboard. The game engine observes the same state variables as the ghosts. In AI Duel, the Pac-Man agent is controlled by Minimax/Alpha-Beta.

- **Performance:** collect all required pellets, maximize score, avoid capture and use lives efficiently.
- **Environment:** the maze, walls, pellets, power pellets and ghost positions.
- **Actuators:** move up, down, left or right.
- **Sensors:** current position, legal moves, nearby pellets, ghost positions and game status.

### 6.3 Task-environment classification

For the simulator, the board state is fully observable; transitions are deterministic; the game is sequential because actions affect later states; it is dynamic because positions change over time; it is discrete because positions/actions are grid-based; and it is multi-agent because Pac-Man and ghosts have competing objectives. The human player may have limited reaction time, but the simulator itself has full state access.

### 6.4 Rationality

A ghost is rational relative to its defined performance measure, percepts and available actions. A* can select a least-cost route to the current target under the specified heuristic conditions. Greedy selects the frontier node that appears closest to the goal according to h(n), but it is not guaranteed to find an optimal route. The game must show these differences rather than calling every ghost decision optimal.

## 7. Game mechanics

### 7.1 Maze representation

Use a rectangular grid with a fixed tile size. Each cell has a type:

- `WALL`: not traversable.
- `FLOOR`: traversable corridor.
- `PELLET`: traversable; awards the configured score when collected.
- `POWER_PELLET`: traversable; starts frightened mode for a configured duration.
- `PLAYER_SPAWN`: traversable starting cell for Pac-Man.
- `GHOST_SPAWN`: traversable starting cell for a ghost.
- `GHOST_GATE`: traversable only according to the chosen spawn/respawn rules.

Represent maps as typed arrays or validated row strings in source-controlled level data. Validate that there is exactly one player spawn, each ghost spawn is valid, all spawns are traversable, and required pellets are reachable. Use an original maze layout.

### 7.2 Movement and collision

- Movement is grid-based. Rendered motion is interpolated between tile centers for smooth animation.
- The simulation uses a fixed movement tick independent of render frame rate.
- A requested direction is buffered until it becomes legal at the next tile.
- A character may not move into a wall.
- Check collision after each simulation movement step. A collision occurs when Pac-Man and a ghost occupy the same cell; also handle an edge-swap crossing in which they exchange adjacent cells during the same tick.
- When a normal ghost catches Pac-Man, decrement one life and reset character positions. If lives reach zero, show Game Over.
- When a frightened ghost collides with Pac-Man, return that ghost to its spawn and award the configured bonus.

### 7.3 Scoring and game states

Suggested initial configuration (keep values in a single config file):

- Normal pellet: 10 points.
- Power pellet: 50 points.
- Frightened ghost: 200 points.
- Starting lives: 3.
- Frightened duration: 6 seconds.

Game states: `MENU`, `READY`, `PLAYING`, `PAUSED`, `LEVEL_COMPLETE`, `GAME_OVER`. Keep state transitions explicit and testable.

### 7.4 Ghost modes

- `CHASE`: ghost plans a route to Pac-Man's current cell.
- `FRIGHTENED`: ghost chooses a legal move that increases its shortest-path distance from Pac-Man. Label this as a flee heuristic, not as A* or Minimax.
- `RESPAWNING`: eaten ghost returns to its spawn using a configured path algorithm.

Do not implement complex scatter schedules or original arcade ghost personalities in the MVP.

## 8. Search problem formulation

The normal ghost route-planning problem is a graph-search problem.

| Search component | Definition |
|---|---|
| State | A traversable grid coordinate `(x, y)` for one ghost in one planning snapshot. |
| Initial state | The ghost's current grid coordinate. |
| Actions | Move one cell up, right, down or left, if the destination is traversable. |
| Successor function | Return all legal neighboring cells in a deterministic order. |
| Goal test | The candidate state equals the target cell selected for this planning snapshot. |
| Step cost | 1 for each legal move in the MVP. |
| Path cost | `g(n)`, the sum of step costs from the initial state to node n. |
| Heuristic | Manhattan distance from the current cell to the target cell. |

A search node is not the same thing as a state. A node is a data structure containing the state plus search information such as parent, action, depth, path cost and heuristic value. The final path is reconstructed by following parent links from the goal node to the start node.

Use the deterministic neighbor order `UP, RIGHT, DOWN, LEFT` for reproducible traces and tie-breaking. Do not allow diagonal moves in the MVP.

## 9. Required search algorithms

### 9.1 Breadth-First Search (BFS)

- Frontier: FIFO queue.
- Expand the shallowest node first.
- In the MVP all step costs are 1, so BFS returns a path with the minimum number of moves when a path exists.
- Use a visited/generated set to avoid enqueuing the same state repeatedly.

### 9.2 Depth-First Search (DFS)

- Frontier: LIFO stack.
- Expand the deepest available node first.
- Use a visited set or current-path cycle check so the finite maze does not loop forever.
- DFS may return a valid route that is longer than the shortest route. Do not label its result optimal.

### 9.3 Uniform-Cost Search (UCS)

- Frontier: priority queue ordered by accumulated path cost `g(n)`.
- Expand the node with the lowest path cost.
- Require positive step costs for the stated completeness/optimality assumptions.
- UCS returns a minimum-cost path. With all movement costs equal to 1, its optimal path cost is the same as BFS, though expansion order and overhead may differ.

### 9.4 Greedy Best-First Search

- Frontier: priority queue ordered by `h(n)` only.
- Evaluation: `f(n) = h(n)`.
- Expand the node that appears closest to the goal.
- In general search spaces, Greedy is not guaranteed to be complete or optimal. In this finite maze implementation, graph-search duplicate handling ensures the algorithm terminates; it can still return a longer route than BFS/UCS/A*.
- The visualization must make it clear that Greedy ignores the path cost already paid.

### 9.5 A* Search

- Frontier: priority queue ordered by `f(n) = g(n) + h(n)`.
- `g(n)` is the path cost so far; `h(n)` estimates the remaining cost.
- Use Manhattan distance: `h(n) = abs(x - goalX) + abs(y - goalY)`.
- With four-direction movement, unit positive costs and no shortcut portals, Manhattan distance never exceeds the true remaining path cost and is consistent for adjacent cells.
- Lecture 6 distinguishes A* tree-search optimality (admissible heuristic) from graph-search optimality (consistent heuristic). State this distinction in the AI explanation panel.
- Test the goal when the node is removed from the frontier, not merely when it is first generated.

### 9.6 Graph search and repeated states

Maintain a `closed` set of expanded state keys. Before expanding a node, check whether its state has already been expanded. If it has, skip it; otherwise add it to the closed set and expand it. Use a real `Set`, not a list, for efficient membership checks.

For UCS/A*, maintain the best known `g` cost per state. If a cheaper route to a state is discovered, update its parent/cost and reinsert or reopen it according to the algorithm's implementation. With the MVP's consistent Manhattan heuristic, A* graph search can use the standard closed-set optimality condition.

### 9.7 Optional course extensions

After the required algorithms work and are tested, add Depth-Limited Search, Iterative Deepening Search and Bidirectional Search to Search Lab. These are extensions, not blockers for the first complete academic release. If added, explain their assumptions and show their frontier strategy accurately.

## 10. Heuristic design and guarantees

The MVP heuristic is Manhattan distance. Because each move changes one coordinate by one and walls can only force detours, Manhattan distance is a lower bound on the true maze path length when there are no teleporters or diagonal moves.

- **Admissible:** `0 <= h(n) <= h*(n)`, where `h*(n)` is the true minimum remaining cost.
- **Consistent:** for every edge from n to n', `h(n) <= cost(n,n') + h(n')`.
- Consistency implies admissibility.
- UCS is a special case of A* with `h(n)=0`.

Do not introduce teleporters, wraparound shortcuts or diagonal movement in the MVP because they can invalidate the Manhattan-distance guarantee unless the heuristic is adjusted.

## 11. Ghost-agent design

Each ghost has an `algorithm` setting and a `targetPolicy`. Keep these separate: the algorithm decides how to search; the target policy decides which cell is the goal.

Default demonstration configuration:

| Ghost | Default search algorithm | Default target policy |
|---|---|---|
| Red | A* | Pac-Man's current cell |
| Pink | Greedy Best-First | Pac-Man's current cell |
| Cyan | BFS | Pac-Man's current cell |
| Orange | DFS | Pac-Man's current cell |

UCS must be selectable from the ghost configuration and available in Search Lab. An optional future Pink target policy may predict a cell a small number of legal steps ahead; keep it disabled by default so algorithm comparisons remain fair.

Ghost planning rules:

1. Build a search problem from the ghost's current cell to the current target cell.
2. Run the configured algorithm and reconstruct a path.
3. Move along the path one tile at a time.
4. Re-plan when Pac-Man changes tile, the target policy changes, the maze changes, or a configurable re-plan interval expires. Never run path search on every render frame.
5. If no path exists, wait or choose a documented safe fallback. Never crash or repeatedly retry in a tight loop.
6. Avoid immediate reversal when another legal move exists, unless it is needed to escape a dead end. This is a movement policy applied after path selection and must not corrupt the search trace.

For a fair algorithm comparison, give ghosts equal movement speed and run the Search Lab comparison with one common start and goal. Different target policies or speeds must not be mixed into the same algorithm benchmark.

## 12. AI Duel: Minimax and Alpha-Beta

### 12.1 Game model

AI Duel is a deterministic, alternating-turn, two-player mini-game on a small maze. Pac-Man is MAX; one ghost is MIN. A ply is one move by one player. The game tree alternates MAX and MIN levels. Use a configurable fixed depth, default 4 plies.

### 12.2 State

A duel state contains:

- Pac-Man coordinate.
- Ghost coordinate.
- Remaining objective pellets (bitset or compact immutable set).
- Whose turn it is (`MAX` or `MIN`).
- Terminal status and score-relevant counters.

Legal actions are adjacent traversable cells. A terminal state occurs if Pac-Man is caught or all objective pellets are collected. At the fixed search depth, apply the evaluation function.

### 12.3 Evaluation function

Use a transparent, documented utility function. Suggested MVP values:

- Pac-Man caught: `-1000`.
- All objective pellets collected: `+1000`.
- Non-terminal state: `12 * pelletsCollected - 2 * distanceToNearestPellet + 3 * distanceToGhost`.

Use maze shortest-path distances (BFS on the static maze) for the distance terms, not straight-line distance through walls. Keep the weights in a named configuration object and explain that they are design parameters, not values specified by the lecture.

### 12.4 Minimax

- At MAX nodes, return the maximum child value.
- At MIN nodes, return the minimum child value.
- Terminal leaves receive terminal utility; depth-cutoff leaves receive the evaluation function value.
- Select the move that maximizes the backed-up utility for Pac-Man.

### 12.5 Alpha-Beta pruning

- Track alpha as MAX's best guaranteed value on the current path; alpha never decreases.
- Track beta as MIN's best guaranteed value on the current path; beta never increases.
- Prune remaining children when `alpha >= beta`.
- For the same state, depth, evaluation function, legal-move order and tie-breaking, Alpha-Beta must return the same Minimax value and move. It may evaluate fewer nodes; do not promise it always will on every tiny tree or move ordering.

Show the game tree, MAX/MIN labels, leaf evaluations, backed-up values, alpha/beta values and pruned branches. Report nodes visited and leaves evaluated for both algorithms.

## 13. Architecture

### 13.1 Recommended stack

| Layer | Technology | Responsibility |
|---|---|---|
| App shell and HUD | React + TypeScript | Menus, panels, settings, score, algorithm controls and accessibility. |
| Game rendering | Phaser 3 | Canvas rendering, sprites, animations, input and scene lifecycle. |
| Build tooling | Vite | Local development and static production build. |
| AI core | Pure TypeScript modules | Search algorithms, heuristics, ghost agents, Minimax and Alpha-Beta. |
| Tests | Vitest | Unit and integration tests for algorithms and game rules. |
| Browser tests | Playwright (recommended) | Critical end-to-end flows in a real browser. |
| Persistence | localStorage | Preferences and best score only; no account or server required. |

No backend, database or paid API is required for the academic edition.

### 13.2 High-level component flow

![PAC-MIND high-level architecture](assets/architecture.png)

### 13.3 Runtime data flow

1. React creates the Phaser game instance and subscribes to typed game events.
2. Phaser owns the board rendering, animation and keyboard input lifecycle.
3. The game simulation updates on a fixed tick, independent of rendering FPS.
4. When a ghost needs a route, the Ghost Agent Manager creates a SearchProblem and calls the pure TypeScript search engine.
5. The search engine returns a path, metrics and ordered trace events.
6. The ghost follows the path in the game simulation. The overlay consumes the trace events for visualization.
7. In AI Duel, the Minimax/Alpha-Beta engine receives an immutable game state and returns the selected action, value and tree trace.
8. React renders statistics and controls; Phaser renders the board and game entities.

### 13.4 Suggested source tree

```text
pacmind-ai/
  AGENTS.md
  PROJECT_SPEC.md
  CODEX_PHASE_PROMPTS.md
  START_HERE.md
  package.json
  tsconfig.json
  vite.config.ts
  index.html
  public/
    assets/                 # Original or properly licensed assets only
  src/
    app/
      App.tsx
      routes.tsx
      theme.css
    components/
      MainMenu.tsx
      GameHUD.tsx
      SearchLabPanel.tsx
      AlgorithmMetrics.tsx
      MinimaxTreePanel.tsx
      SettingsPanel.tsx
    game/
      scenes/
        MainScene.ts
      entities/
        Pacman.ts
        Ghost.ts
      engine/
        GameState.ts
        GameLoop.ts
        CollisionSystem.ts
        PelletSystem.ts
      maze/
        MazeMap.ts
        MazeParser.ts
        levels.ts
    ai/
      search/
        types.ts
        priorityQueue.ts
        bfs.ts
        dfs.ts
        ucs.ts
        greedy.ts
        astar.ts
        heuristics.ts
        graphSearch.ts
        reconstructPath.ts
      agents/
        GhostAgent.ts
        GhostManager.ts
        targetPolicies.ts
      adversarial/
        duelState.ts
        evaluation.ts
        minimax.ts
        alphaBeta.ts
        treeTrace.ts
    visualization/
      SearchTracePlayer.ts
      traceTypes.ts
    state/
      settingsStore.ts
      highScoreStore.ts
    styles/
      neon-theme.css
  tests/
    unit/
      search/
      adversarial/
      maze/
      game/
    integration/
    e2e/
  docs/
    COURSE_ALIGNMENT.md
    DEMO_SCRIPT.md
```

Codex may adjust filenames if the architecture remains equivalent. Keep AI algorithms in pure modules, separate from Phaser rendering.

## 14. Core TypeScript contracts

The following are design contracts, not a requirement to copy every type name exactly.

```ts
export type Cell = { x: number; y: number };
export type SearchAlgorithm = 'bfs' | 'dfs' | 'ucs' | 'greedy' | 'astar';

export type Neighbor = {
  state: Cell;
  action: 'UP' | 'RIGHT' | 'DOWN' | 'LEFT';
  cost: number;
};

export interface SearchProblem {
  start: Cell;
  goal: Cell;
  getNeighbors(cell: Cell): Neighbor[];
  heuristic(cell: Cell, goal: Cell): number;
}

export type SearchTraceEvent =
  | { type: 'discover'; cell: Cell }
  | { type: 'expand'; cell: Cell; g: number; h: number; f: number }
  | { type: 'frontier-update'; cell: Cell; priority: number }
  | { type: 'closed'; cell: Cell }
  | { type: 'path-found'; path: Cell[]; cost: number }
  | { type: 'failure' };

export interface SearchResult {
  found: boolean;
  path: Cell[];
  pathCost: number;
  expandedCount: number;
  generatedCount: number;
  maxFrontierSize: number;
  elapsedMs: number;
  trace: SearchTraceEvent[];
}
```

Use stable cell keys such as `"x,y"`. Return a clear failure result if the goal is unreachable. Never return a fabricated path.

## 15. Visualization and neon design

### 15.1 Visual direction

- Background: deep navy/near-black.
- Primary accent: electric purple.
- Secondary accent: cyan.
- Success/path accent: neon green.
- Pac-Man/pellet accent: warm yellow.
- Danger/ghost route accent: coral or red.
- Use restrained glow, clear contrast, legible text and consistent spacing.

### 15.2 Search-state colors

| State | Visual treatment |
|---|---|
| Wall | Deep navy solid tile |
| Unvisited corridor | Dark slate tile |
| Frontier | Cyan outline or fill |
| Expanded/closed | Purple fill |
| Current expanded node | Bright yellow ring |
| Final path | Neon green line/cell |
| Start | Green marker |
| Goal | Magenta marker |
| Ghost planned route | Red/coral dashed line |

The legend must always be visible while the search overlay is open. Do not rely on color alone; add labels, outlines or symbols.

### 15.3 Motion requirements

- Pac-Man movement interpolates smoothly between tile centers.
- Pac-Man mouth animation cycles while moving and closes while idle.
- Ghosts float/bob subtly and animate direction changes.
- Pellets pulse gently; power pellets have a restrained glow.
- Search visualization animates one trace event at a time with play/pause/step/reset/speed controls.
- The final path draws in sequence after the goal is found.
- Minimax tree nodes reveal as the search explores; pruned branches fade and receive a visible PRUNED label.
- Use `prefers-reduced-motion` and a user setting to reduce/disable decorative motion. Never use rapid flashing.

## 16. Game-loop and performance rules

- Separate render frame updates from simulation ticks.
- Use a fixed simulation timestep for movement and collisions.
- Never run search once per animation frame.
- Re-plan only when the target changes, the map changes or the re-plan interval expires.
- Keep the first maze small enough for instant search. Record `performance.now()` around the algorithm call, not around the visualization playback.
- Display node counts as the primary comparison metric; small wall-clock measurements are noisy.
- Avoid blocking React renders with large trace arrays; keep trace playback state isolated and memoized.

## 17. Functional requirements

| ID | Requirement | Priority |
|---|---|---|
| FR-01 | Show a main menu with Main Game, Search Lab, AI Duel and Settings. | Must |
| FR-02 | Start, pause, resume and restart a game. | Must |
| FR-03 | Move Pac-Man with Arrow keys and WASD; prevent movement through walls. | Must |
| FR-04 | Collect pellets and update score. | Must |
| FR-05 | Implement lives, collision, respawn and Game Over. | Must |
| FR-06 | Implement power pellets and frightened ghost behavior. | Should |
| FR-07 | Implement BFS, DFS, UCS, Greedy and A* as real search algorithms. | Must |
| FR-08 | Show the frontier, expanded/closed states and final path in AI Overlay/Search Lab. | Must |
| FR-09 | Let the user choose start, goal and algorithm in Search Lab. | Must |
| FR-10 | Compare algorithms on the same problem and display measured metrics. | Must |
| FR-11 | Configure each ghost's search algorithm. | Must |
| FR-12 | Re-plan ghost paths safely as Pac-Man moves. | Must |
| FR-13 | Implement Minimax and Alpha-Beta in the turn-based AI Duel. | Must |
| FR-14 | Show MAX/MIN levels, backed-up values, alpha/beta and pruned branches. | Must |
| FR-15 | Persist settings and best score locally. | Should |
| FR-16 | Add DLS, IDS and bidirectional search as optional extensions. | Could |

## 18. Non-functional requirements

- **Correctness:** algorithm outputs must be validated by automated tests.
- **Determinism:** fixed neighbor order and tie-breaking must make traces reproducible.
- **Performance:** target smooth 60 FPS rendering on a typical student laptop; search runs must not freeze the game for the supplied maps.
- **Maintainability:** strict TypeScript, pure AI modules, clear types and small components.
- **Usability:** clear legends, controls, algorithm descriptions and reset actions.
- **Accessibility:** keyboard operation, visible focus, sufficient contrast, reduced-motion option and no color-only meaning.
- **Reliability:** pause/restart must reset timers, listeners and Phaser scene state without duplicated events.
- **Privacy:** no personal data, accounts, telemetry or network calls in the MVP.

## 19. Testing and acceptance criteria

### 19.1 Search unit tests

1. BFS returns a valid shortest path on a known unit-cost maze.
2. DFS returns a valid path when one exists; do not assert it is shortest.
3. UCS returns the minimum-cost path on a small weighted graph with positive costs.
4. On a unit-cost maze, BFS and UCS return the same optimal path cost.
5. Greedy returns a valid path when found; tests must not assume optimality.
6. A* with Manhattan distance returns the same optimal path cost as BFS on unit-cost maze maps.
7. For every traversable adjacent pair, Manhattan consistency holds: `h(n) <= 1 + h(n')`.
8. For every reachable cell in test maps, Manhattan distance does not exceed the BFS shortest distance to the goal.
9. Graph search does not expand a state more than once under the configured consistent heuristic.
10. A* and UCS test the goal when it is removed from the frontier, not on generation.
11. Unreachable goals return `found=false` and an empty path.
12. Path reconstruction begins at start, ends at goal and uses only legal neighboring cells.

### 19.2 Adversarial-search tests

1. Minimax returns the expected value/move on a hand-checked small game tree.
2. Alpha-Beta returns the same value and move as Minimax for the same state, depth, evaluation and move order.
3. Alpha-Beta reports pruned nodes when a test tree has a valid pruning opportunity.
4. Alpha is non-decreasing; beta is non-increasing; pruning occurs when `alpha >= beta`.
5. Terminal caught/win states override the non-terminal evaluation function.

### 19.3 Game integration tests

- Pac-Man cannot enter walls.
- Buffered turns work at intersections.
- Pellets are collected once and score increments correctly.
- Collision decrements one life and respawns entities.
- Power pellet activates frightened mode and expires at the expected time.
- Eating a frightened ghost returns it to spawn.
- Clearing all required pellets triggers level completion.
- Restart returns the game to its initial state and does not duplicate event listeners.
- Ghosts follow legal paths and re-plan after Pac-Man changes target cell.

### 19.4 End-to-end tests

- Main menu -> Main Game -> move Pac-Man -> pause -> resume -> restart.
- Search Lab -> choose algorithm -> run -> step/pause/reset -> compare algorithms.
- AI Duel -> run Minimax -> run Alpha-Beta -> verify same selected move and view pruned branches.

### 19.5 Comparison protocol

Use the same map, start cell, goal cell, neighbor order and movement cost for all algorithms. Record actual path cost, expanded nodes, generated nodes, maximum frontier and algorithm execution time. Explain that runtime on small maps is noisy. Never invent benchmark values. Expected theoretical observations: BFS/UCS/A* find optimal paths under the specified conditions; DFS may not; Greedy may select a longer route; A* often expands fewer nodes than UCS when the heuristic is informative, but actual results depend on the map.

## 20. Development phases

Codex must implement one phase at a time and stop for review after each phase.

| Phase | Name | Deliverable |
|---|---|---|
| 0 | Project bootstrap | React/TypeScript/Vite/Phaser setup, lint, tests and app shell. |
| 1 | Playable maze foundation | Maze renderer, Pac-Man controls, pellets, score, lives and game states. |
| 2 | Uninformed search | BFS, DFS, UCS, priority structures and tests. |
| 3 | Informed search | Heuristics, Greedy, A*, graph search, admissibility/consistency tests. |
| 4 | Search Lab and visualization | Animated frontier/closed/path trace and fair algorithm comparison. |
| 5 | Intelligent ghosts | Configurable ghost agents, chase/flee/respawn modes and AI Overlay. |
| 6 | Adversarial AI Duel | Minimax, Alpha-Beta, fixed ply depth and game-tree visualization. |
| 7 | Final QA and submission | Polish, accessibility, performance, docs, demo and actual evaluation report. |

## 21. Local development commands

The final package should provide equivalent scripts in `package.json`:

```bash
npm install
npm run dev
npm run test
npm run test:watch
npm run typecheck
npm run lint
npm run build
npm run preview
```

If Playwright is included:

```bash
npx playwright install
npm run test:e2e
```

Codex must document actual prerequisites and commands after checking the generated project. Do not claim a command passed unless it was run.

## 22. Academic evaluation and final demonstration

Suggested 5-7 minute demonstration:

1. Explain the maze as a state-space graph: cells are states, moves are actions, walls constrain successors, and the target is the goal.
2. Start the game and show ghosts using different search algorithms.
3. Open Search Lab and run BFS, DFS, Greedy and A* on the same map.
4. Show the frontier and closed set; explain why Greedy may follow a visually promising but longer route.
5. Show A*'s `g(n)`, `h(n)` and `f(n)=g(n)+h(n)` values and explain the Manhattan heuristic.
6. Open AI Duel and explain MAX, MIN, ply depth and the evaluation function.
7. Run Minimax and Alpha-Beta from the same state; show that the selected move is the same and identify pruned branches.
8. Present actual test and comparison results, then state limitations honestly.

## 23. Limitations and honest claims

- The ghost's A* path is optimal only for the current frozen planning snapshot and the specified graph/heuristic assumptions. Because Pac-Man moves, the ghost must re-plan; this is not a guarantee of globally optimal pursuit over future time.
- Greedy Search uses h(n) only and can choose a longer route.
- DFS can find a route without finding the shortest route.
- UCS and BFS behave similarly in the MVP because each move has equal cost; UCS becomes more distinct if positive non-uniform movement costs are added later.
- Minimax is used in the alternating-turn AI Duel, not in the simultaneous real-time chase.
- The project demonstrates classical AI algorithms; it does not train a learning agent.
- Performance claims must be based on measurements from the finished implementation.

## 24. Source material

The primary course basis is the six user-provided CF321 files:

1. `Lec 1 CF321.pdf`
2. `Lec 2 CF321.pdf`
3. `Lecture_3 FAI.pdf`
4. `Lecture_4 FAI CF321.pdf`
5. `Lecture_5_CF321.pdf`
6. `Lecture 6.pptx`

The course-alignment notes in `COURSE_ALIGNMENT.md` identify the concepts used from each lecture. Lecture 6's small-maze/Pac-Man Greedy example is especially relevant to this project.
