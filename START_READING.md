# Start here: readable PAC-MIND source

**Open `src/` when studying or editing the code. Do not study `dist/assets/`: those files are generated, minified production bundles.** Minification deliberately removes comments and shortens names for download speed. The commented TypeScript is in `src/`.

You do not have to read the entire project in one sitting. Begin with these files:

| What you want to understand or change | Open this file |
|---|---|
| Pac-Man's yellow color and other arcade colors | `src/game/config/gameColors.ts` |
| Pac-Man's body and mouth animation | `src/game/entities/Pacman.ts` |
| A ghost's body, eyes and floating animation | `src/game/entities/Ghost.ts` |
| The main game screen, as a short layout outline | `src/components/GameView.tsx` |
| The HUD, buttons, AI selector and ghost panels | `src/components/game/` |
| Movement, pellets, scoring, lives, collisions and restart | `src/game/engine/GameState.ts` |
| How AI Pac-Man chooses a direction | `src/ai/agents/PacmanAgent.ts` |
| How an imagined future is scored | `src/ai/agents/pacmanEvaluation.ts` |
| BFS, DFS, UCS, Greedy and A* | `src/ai/search/search.ts` |
| Minimax and Alpha-Beta | `src/ai/adversarial/minimax.ts` |
| Neon interface styling | `src/app/theme.css` (numbered sections) |

For example, change the main-game color here:

```ts
// src/game/config/gameColors.ts
pacman: 0xffdc55, // Yellow. Try 0x00ff88 for green.
```

That color controls the main-game character, its glow and its AI plan. Search Lab / AI Duel use their separate SVG markers in `GridBoard.tsx`; the logo is styled in CSS.

Read **docs/CODE_READING_GUIDE.md** for a step-by-step walkthrough, **docs/FILE_BY_FILE_GUIDE.md** for the whole source map, and **docs/TYPESCRIPT_REACT_BASICS.md** for syntax you may not know yet.

To run on Windows, install Node.js LTS and double-click `START_WINDOWS.bat`. It opens the application; it does not display source code. Open this folder in VS Code to read the TypeScript.
