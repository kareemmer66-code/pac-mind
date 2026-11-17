# PAC-MIND — AI PAC-MAN: CF321 SEARCH LAB

A playable React/TypeScript/Phaser maze-chase and classical AI laboratory, implemented through Phase 7 with AI Pac-Man and a version 1.2 readable-source edition. No API key, paid AI model, backend or database. Original maze geometry, characters and synthesized sound; no proprietary game assets.

## Version 1.2: readable source edition

**Start with START_READING.md.** Study the commented TypeScript under `src/`, not the generated/minified JavaScript in `dist/assets/`.

This edition keeps the version 1.1 features while separating the large game screen, canvas drawing and AI calculations into named components/functions. Main-game Pac-Man artwork is now `src/game/entities/Pacman.ts`; its color is `gameColors.pacman` in `src/game/config/gameColors.ts`.

- `docs/CODE_READING_GUIDE.md`: eight lessons that follow the real code.
- `docs/FILE_BY_FILE_GUIDE.md`: every source module and its responsibility.
- `docs/TYPESCRIPT_REACT_BASICS.md`: syntax and React hooks used in this app.
- Numbered code comments: state, actions, simulation, drawing, playback and cleanup.

Two full-level state traces recorded before the refactor are compared tick-for-tick after it. This verifies the rules and AI decisions, not just the final score. Timing and rendering internals are intentionally excluded from those deterministic hashes.

## New: AI-controlled Pac-Man

In **Main Game**, set **Pac-Man control → AI Autoplay — clear the maze**, then click **Start AI run**. Pac-Man now plays automatically against the same four active ghosts. Pause/resume and restart work as before. Switch back to **Human** at any time to take over without losing progress. On a lost life, autoplay continues with the remaining lives; Game Over still applies.

The yellow overlay shows the controller's last planned moves and pickup. The panel displays actual simulated-state counts and planning time. It uses bounded **beam search**, eight ticks ahead with a beam width of ten, evaluating the real game transitions. It favors pellet collection and survival, uses BFS maze distances, and discourages loops. This is classical planning, not a learned model, pre-scripted solution or Minimax for the real-time game.

See **docs/CODE_READING_GUIDE.md** for a beginner-friendly reading order and decision walkthrough. Core source files now include explanatory comments about algorithms, game rules, lifecycle and UI boundaries. The previous Phase 7 application remains included; this is a targeted autoplay extension.

Completion is tested on both supplied maps with the default four ghost algorithms. Custom ghost assignments or taking control mid-run can change the outcome; bounded search is not guaranteed to win every setup. Planning runs on simulation ticks and can cause frame-time spikes on slower computers.

## Run on Windows

1. Install **Node.js LTS** from https://nodejs.org. Node 22.12+ is required; Node 24 was used for validation.
2. Right-click the downloaded ZIP, choose **Extract All**, and open the extracted `pacmind-ai` folder.
3. Double-click **START_WINDOWS.bat**. It installs the locked dependencies if needed, starts Vite and opens your browser. Keep the terminal open. Initial installation needs internet access; no AI service is used.

Alternatively, open the folder in VS Code, choose **Terminal → New Terminal → Command Prompt** and run:

```bat
npm install
npm run dev
```

Open the local address Vite prints, normally http://localhost:5173. If that port is busy, Vite prints another available port. Stop with Ctrl+C. Do not open `dist/index.html` directly from File Explorer: JavaScript modules must be served over HTTP.

## Use the application

**Main Game:** Start the game, then use Arrow keys or WASD. Turns are buffered until legal. Space pauses/resumes; Restart resets the maze and score. Clicking the board focuses keyboard input after using a form control. Touch direction buttons are available on smaller screens. Collect all pellets, avoid ghosts and use power pellets to frighten them for about six seconds of simulation time. Three lives. Losing a life resets positions and waits for Start. Ghosts move every two player ticks, with equal speed among ghosts; their algorithm assignments can be changed independently. Click an agent to inspect it and enable AI Overlay to see actual explored/frontier cells, the frozen target and the remaining plan. The overlay is a planning snapshot, not a Search Lab replay and does not alter simulation state.

**Search Lab:** Choose one of two maps, start, goal and BFS/DFS/UCS/Greedy/A*. Run, play/pause, step, reset, change speed or show the result immediately. Final route segments reveal after exploration. Click cells or use the coordinate controls. Compare all five algorithms on identical inputs. Search runtimes exclude animation. Counts are more informative than noisy sub-millisecond times.

**AI Duel:** A separate alternating-turn maze. Yellow is MAX and pink is MIN. Each legal move is one ply. Set depth (1–6; default 4), compare both searches, inspect backed-up values and alpha/beta histories, then apply the chosen move. The next turn belongs to the opponent. Step/play/reveal the visited tree and expand its branches. PRUNED counts skipped immediate child branches, not all descendant nodes. Minimax and Alpha-Beta use identical inputs and stable tie breaks. They do not control the real-time game.

**Settings:** Reduced motion and optional original synthesized pellet sounds. System reduced-motion preference is also respected. Audio needs a Start gesture and browser Web Audio support. Only preferences and best score persist in localStorage. Blocked storage is handled gracefully.

## Commands

| Command | Purpose |
|---|---|
| `npm install` or `npm ci` | Install dependencies (ci uses the lockfile exactly) |
| `npm run dev` | Vite development server |
| `npm run build` | Strict type checking and static production build in dist/ |
| `npm run preview` | Serve the built application locally |
| `npm run lint` | ESLint with React hook checks |
| `npm run typecheck` | Strict TypeScript for application, configuration and tests |
| `npm run test` | Vitest unit and integration tests |
| `npm run test:watch` | Vitest watch mode |
| `npm run format` / `npm run format:check` | Prettier (supplied Markdown is preserved) |
| `npx playwright install chromium` | Install the browser for tests on your computer |
| `npm run test:e2e` | Playwright critical flows, screenshots and evaluation samples |

Playwright uses port 5174 to avoid a normal Vite server on 5173. `PLAYWRIGHT_BASE_URL` targets an existing server; `PLAYWRIGHT_CHROMIUM_PATH` can point to a compatible installed Chromium. The cloud checks used `/usr/bin/chromium`; do not set that Linux path on Windows. On Windows, the normal `npx playwright install chromium` command is sufficient. Evaluation tests regenerate docs/EVALUATION.json and docs/screenshots/ with actual observations.

## Architecture and correctness

- `src/app`, `src/components`: React navigation, HUD, lab, duel and controls.
- `src/game/maze`: original maps, coordinate types, deterministic UP/RIGHT/DOWN/LEFT neighbors and reachability validation.
- `src/game/engine/GameState.ts`: pure fixed-tick rules, buffered movement, scoring, edge-swap collisions, lives and explicit states. Phaser interpolates these states for rendering.
- `src/game/scenes/ArcadeScene.ts`: original Canvas artwork, animation and scene-owned input lifecycle.
- `src/ai/search`: independent typed graph search, parent reconstruction and stable binary min-heap. BFS uses a queue, DFS a stack, UCS g, Greedy h, and A* g+h. No hard-coded routes or random decisions. All five emit actual search events and metrics. UCS/A* use best-g updates and reopening; goal tests occur on frontier removal.
- `src/ai/agents`: deterministic chase/flee/respawn planning. Chase avoids immediate reversal when a constrained legal route exists, falling back when needed. Flee uses real BFS maze distances and is labelled a heuristic. Paths are computed on movement ticks, never render frames.
- `src/ai/adversarial`: immutable alternating-turn duel, transparent BFS-distance evaluation, generic Minimax and optional Alpha-Beta pruning with alpha/beta update histories.
- `src/visualization`: trace projection independent of simulation.
- `src/state`: guarded local preferences/best score.

Manhattan distance is admissible and consistent because movements are cardinal, unit cost, without portals or diagonals. A* tree search needs admissibility; the documented graph-search guarantee uses consistency. DFS and Greedy are not shortest-path optimal. A ghost's route only describes a frozen target snapshot, not optimal pursuit of a moving player. This project demonstrates classical symbolic AI, not machine learning.

## Verification and presentation

See **docs/FINAL_REPORT.md** and **docs/CODE_READING_GUIDE.md**, **docs/PHASE_ACCEPTANCE.md**, **docs/EVALUATION.json**, **docs/PRESENTATION_GUIDE.md** and **docs/screenshots/**. The original five required documents are retained unchanged at the root. Additional supplied documents remain under docs/. Historical Phase 0 documentation describes that earlier delivery; the final report describes this version. The local Phase 1 created on your computer was not accessible to this cloud session; this complete version extends the preserved cloud Phase 0 source.

Known limits: two maps (the specification's additional-map stretch goal is not fully implemented); optional DLS/IDS/bidirectional extensions omitted; browser QA performed on Chromium, not every browser; generated Web Audio has not been assessed by listening; Windows launcher has been reviewed but was not executed on Windows. Vite warns about Phaser's engine chunk size. Search measurements and frame samples in evaluation files are observations from headless Linux, not guarantees for a student laptop.
