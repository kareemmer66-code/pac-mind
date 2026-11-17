# COURSE_ALIGNMENT.md - AI Pac-Man and the Six CF321 Lectures

This document makes the academic connection explicit. The project must use the terminology and guarantees below accurately.

## Lecture 1 - An Introduction to Artificial Intelligence

**Course ideas:** definitions of intelligence and AI; four approaches (thinking humanly, acting humanly, thinking rationally, acting rationally); AI as the study/design of intelligent agents; Turing Test, Chinese Room and Strong vs Weak AI.

**Project connection:** the project is framed primarily as **acting rationally**. A ghost agent perceives a maze state and chooses a legal action intended to improve its defined performance measure. It is not claimed to think like a human, pass the Turing Test or possess general intelligence. The project is a narrow, task-specific intelligent system.

**What to explain:** an intelligent game agent can be rational within a limited task without being human-like or generally intelligent.

## Lecture 2 - Intelligent Agents and AI Related Disciplines

**Course ideas:** agent definition (perceives through sensors and acts through actuators); rational agents; percepts; performance measure; PEAS; task-environment properties; goal-based and cost-based agents; learning agents and related disciplines.

**Project connection:** ghosts are software agents. Their percepts include their own position, Pac-Man's position, walls, legal neighboring cells and current mode. Their actuators are movement actions. The PEAS tables are in `PROJECT_SPEC.md`.

**Environment classification:** fully observable to the simulator, deterministic, sequential, dynamic, discrete and multi-agent. Explain that this classification describes the game simulation, not necessarily the human player's limited reaction time.

**What to explain:** the ghost is a planning/goal-directed agent, not just a reflex that randomly picks a direction.

## Lecture 3 - Problem Solving as Search and State Space Search

**Course ideas:** solving problems by searching alternatives; reflex vs planning agents; state-space graph; search problem components; search trees; nodes vs states; repeated states; backtracking and maze examples.

**Project connection:** a traversable cell is a state; moving one cell is an action; legal neighbors form the successor function; a ghost's current cell is the initial state; Pac-Man's selected cell is the goal; movement cost is 1. A search node stores the state plus parent, action, depth and path cost.

**What to explain:** the maze is not only a picture; it is a graph that can be explored by a search algorithm.

## Lecture 4 - Problem Solving as Search: Blind and Heuristic Strategies

**Course ideas:** BFS, DFS, depth-limited search, iterative deepening, bidirectional search, UCS, repeated-state avoidance, heuristic functions and strategy comparison.

**Project connection:** BFS, DFS and UCS are required algorithms. DLS, IDS and bidirectional search are optional extensions after the core game works. The closed/visited structure prevents loops. Search Lab visualizes the frontier strategy.

**What to explain:** BFS uses a queue and finds a minimum-number-of-moves solution when each move has equal cost; DFS uses a stack and may find a longer path; UCS expands the lowest accumulated path cost g(n).

## Lecture 5 - Adversarial Search

**Course ideas:** two-player games; MAX and MIN; Minimax; fixed ply depth; evaluation functions; Alpha-Beta pruning; alpha and beta bounds; pruning when alpha >= beta.

**Project connection:** AI Duel is a turn-based game tree. Pac-Man is MAX and one ghost is MIN. At MAX nodes take the maximum child value; at MIN nodes take the minimum. Alpha-Beta prunes branches that cannot affect the final choice.

**What to explain:** Minimax models an opponent's response. Alpha-Beta returns the same decision as Minimax for the same tree but can avoid evaluating branches.

## Lecture 6 - Informed Search: Heuristics, Greedy and A*

**Course ideas:** heuristic h(n); Greedy Best-First Search; A*; g(n), h(n), f(n); admissible heuristics; consistent heuristics; graph search and closed set; optimality; relaxed problems. The lecture includes a small Pac-Man maze example for Greedy Search.

**Project connection:** Greedy orders the frontier by h(n); A* orders by f(n)=g(n)+h(n). Use Manhattan distance in the four-direction, unit-cost maze. Graph search uses a closed set and avoids expanding the same state repeatedly.

**What to explain:** Greedy only looks at estimated distance to the goal and can choose a longer route. A* combines the cost so far with estimated remaining cost. A* tree search is optimal with an admissible heuristic; A* graph search is optimal with a consistent heuristic. Consistency implies admissibility. UCS is the special case h(n)=0.

## Academic honesty boundaries

- Do not call the search algorithms machine learning.
- Do not claim that Greedy is optimal.
- Do not claim that DFS returns the shortest path.
- Do not claim A* graph-search optimality without stating the consistency condition used.
- Do not call the real-time chase Minimax. Minimax is demonstrated in the separate alternating-turn AI Duel.
- Do not present measured performance values until the finished program has actually produced them.
