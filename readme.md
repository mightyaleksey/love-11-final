# Taxi Driver

Final project for the "CS50's: Introduction to Game Development" course. The game that I made from scratch. The game is powered by Love2D engine.

Specification: https://cs50.harvard.edu/games/2018/final/#specification.


## Game Design

You play as a taxi driver and your goal is to pick up passengers and take them to the destination. And as a professional, you take passengers quickly and comfortably to the place, which becomes more challenging while moving in a heavy traffic.

Thus, you need to be careful and to avoid any car accidents to not to hurt your reputation! New trips result in a longer distance.


## Technical Complexity

The game has three main states:
- `GameStartState` — implements the starting screen with the game title and background.
- `GamePlayState` — main state of the game, that handles game play logic (vehicle driving).
- `GameEndState` — based on the player's progress (success of failure), this one will be shown to display the of the trip.

The diversify the game experience, I decided to demonstrate step by step passenger pick up process. I also wanted to have a control over "starting" and "departing" phase to show the parking process. For that, I decided to re-use stack of states (`StackStates`) implementation from the Pokemon project, which helps to shift control over the game to subsequent states and allows to bring step-by-step experience like in jRPG games.

As a result, I also implemented four supporting states:
- `PickUpState` — initiates communication with a passenger and the game start.
- `DepartState` — initiates a completion of the game and vehicle parking, when player passed necessary distance for the level.
- `DialogueState` — helps to display text based dialogs and emulate communication with characters, while game is on pause.
- `TransitionState` — adds a fade-in fade-out color transition between main states.

Thus, the game has 3 main and 4 supporting states.


## Challenges

While I was working on a game, I faced few challenges that were putting me into a trouble and took sometime to debug. Since, those helped me to learn more about used patterns, I'd like to capture those here. Here they are:

1. **Infinite scrolling** for the driving phase. Took me few attemps to implement. After trying to build it in a straightforward way, I realised that the solution becomes very complex and requires a lot of math to map tiles to the current viewport. So eventually, I decided to pivot towards `love.graphics.translate` solution (which was used for the Mario game), that helps to emulate the camera effect. It takes away the rendering complexity, however, took me a while to figure out why entities were not moving when I pushed supportive state (was not calling update method for other vehicles).
2. Had a very confusing experience with the `TransitionState` usage to handle switch between main states, which resulted in a game being unresponsive. Turned out, that new pushed states that had a timer based logic, were messing out with the states order in the stack, resulting in having unwanted states on the top of the stack (that have no I/O control). Based on that I figured out the rule: **any state entry logic that relies on timer, should have timer longer then the transition state**, so the new states will be pushed to the stack after transition state will handle clean up.