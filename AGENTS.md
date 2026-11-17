# AGENTS.md - PAC-MIND Codex Engineering Rules

You are implementing **AI Pac-Man: CF321 Search Lab**, an academic browser game that demonstrates classical AI search algorithms. `PROJECT_SPEC.md` is the binding product and technical contract. `COURSE_ALIGNMENT.md` records the course basis. `CODEX_PHASE_PROMPTS.md` contains the phase prompts.

## Mandatory workflow

1. Read `PROJECT_SPEC.md`, `COURSE_ALIGNMENT.md` and the requested phase prompt before editing.
2. Inspect the existing repository and preserve working code.
3. Implement only the phase explicitly requested by the user. Do not silently advance to later phases.
4. Write real functionality. Do not substitute mock search traces, random ghost moves, hard-coded paths or fake benchmark numbers for the specified algorithms.
5. Add or update tests with every behavior change.
6. Run the relevant checks and report exact commands and actual outcomes. If a command cannot run, say why.
7. Stop at the end of the requested phase and provide the handoff report.

## Architecture rules

- Use React + TypeScript + Vite for the app shell and Phaser 3 for game rendering.
- Keep search algorithms, heuristics and adversarial search in pure TypeScript modules, independent of Phaser and React.
- No backend, database, LLM API, paid AI service or machine-learning model is required for the MVP.
- Use strict TypeScript. Avoid `any` unless there is a documented reason.
- Keep simulation ticks separate from render frames. Never run search every animation frame.
- Use deterministic neighbor order and tie-breaking so traces and tests are reproducible.
- Keep game rules, AI decision logic and visualization rendering separate.

## Academic correctness rules

- BFS uses a FIFO queue; DFS uses a LIFO stack; UCS orders by g(n); Greedy orders by h(n); A* orders by g(n)+h(n).
- Use the course distinction: A* tree-search optimality requires an admissible heuristic; A* graph-search optimality requires a consistent heuristic. Consistency implies admissibility.
- Use Manhattan distance only while the MVP has four-direction unit-cost moves and no shortcut portals/diagonal moves.
- Use a closed set for graph search and avoid repeated expansions. Test the goal when a node is removed from the frontier, not merely when generated.
- Greedy is not guaranteed to return an optimal path. DFS is not guaranteed to return a shortest path. Do not label them optimal.
- Minimax/Alpha-Beta belong in the separate alternating-turn AI Duel. Do not claim that they control the normal real-time ghost chase.
- Alpha-Beta must return the same Minimax decision for the same state, depth, evaluation and move order; pruning count depends on the tree and move ordering.
- Do not claim that this project uses machine learning. It demonstrates classical symbolic/search AI.

## Game and asset rules

- Use an original maze and original/simple vector or properly licensed assets. Do not download or embed official proprietary Pac-Man sprites, logos, maps or music.
- Use accessible controls, a visible search legend, reduced-motion support and no rapid flashing.
- Handle unreachable paths, invalid maps, restarts and scene cleanup without crashing or leaking event listeners.

## Security and privacy

- The MVP should not collect personal data or make network calls. Persist only preferences and best score locally.
- Do not add telemetry, analytics SDKs or external dependencies without a clear need and user approval.
- Never add secrets or API keys to the repository.

## Definition of done for every phase

- The phase acceptance criteria in `CODEX_PHASE_PROMPTS.md` are satisfied.
- Tests for the changed behavior are added and pass, or failures are clearly reported.
- Lint, type-check and build checks relevant to the phase are run.
- The application remains runnable from the documented commands.
- No later-phase feature is represented as complete when it is not.

## Required final report format

```text
PHASE:
GOAL:
IMPLEMENTED:
FILES CREATED/CHANGED:
TESTS ADDED:
COMMANDS ACTUALLY RUN:
RESULTS:
MANUAL VERIFICATION:
KNOWN LIMITATIONS:
BLOCKERS:
NEXT PHASE (NOT STARTED):
```
