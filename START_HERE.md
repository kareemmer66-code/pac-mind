# Start Here - Build AI Pac-Man with Codex

This folder contains the complete Codex-ready specification for **AI Pac-Man: CF321 Search Lab**. It is a neon-style, academic maze game demonstrating the classical AI algorithms from your six CF321 lectures.

## Files

- `PROJECT_SPEC.md` - the complete product requirements, game mechanics, PEAS, architecture, algorithm definitions, data contracts, tests and acceptance criteria.
- `AGENTS.md` - persistent engineering rules for Codex.
- `CODEX_PHASE_PROMPTS.md` - one global starter prompt and eight copy-ready implementation prompts.
- `COURSE_ALIGNMENT.md` - map from each uploaded lecture to the project features and concepts.
- `DEMO_SCRIPT.md` - a short presentation script for your professor.

## Step 1 - Create the project folder

1. Create a folder named `pacmind-ai`.
2. Copy all Markdown files from this pack into the root of that folder.
3. Open the `pacmind-ai` folder in Codex as the workspace.
4. If using Git, initialize a repository before the first implementation phase.

## Step 2 - Paste the global starter prompt

Open `CODEX_PHASE_PROMPTS.md` and copy the **Global Starter Prompt** into Codex. Codex must read the documentation and implement **Phase 0 only**.

## Step 3 - Review Phase 0 yourself

Do not approve it just because files were generated. Check that:

- `npm install` completes.
- `npm run dev` starts the local app.
- The browser shows the application shell.
- `npm run typecheck`, `npm run lint`, `npm run test` and `npm run build` run.
- Codex reports actual results and known limitations.

## Step 4 - Implement one phase at a time

After a phase passes its acceptance criteria, paste the next phase prompt. The order is:

`Phase 0 -> Phase 1 -> Phase 2 -> Phase 3 -> Phase 4 -> Phase 5 -> Phase 6 -> Phase 7`

Do not ask Codex to build everything in one huge request. This makes debugging and academic verification much easier.

## Step 5 - Understand the AI before presenting

You should be able to explain:

- Why the maze is a state-space graph.
- What the frontier and closed set contain.
- Why BFS is shortest-path optimal when all moves have equal cost.
- Why DFS may return a longer route.
- Why UCS orders by g(n), Greedy by h(n), and A* by g(n)+h(n).
- What admissible and consistent heuristics mean.
- Why Minimax uses MAX and MIN levels and how Alpha-Beta prunes when alpha >= beta.

## Step 6 - Use real results

Run the finished algorithms on the same test maze, start and goal. Record the actual expanded-node counts, path costs, frontier sizes and execution times. Never invent results for the report or presentation.

## Important setup note

The project uses React, TypeScript, Vite and Phaser 3. It does not require a paid API, model download, backend or database. The actual implementation is built by Codex after you run the phase prompts; this documentation pack is not a prebuilt game.
