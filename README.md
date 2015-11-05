#Cal Bear Shooter

## Author


* Yang Li (Git: friendkerli)
* Xinran Guo (Git: garyguo2011)

## Purpose


Create an 2D space shooting game that use SpriteKit

## Features

* Pickup different shooting role to start a game
* Player will destroy any enemies as they move forward.
* The shooting difficulty will increase as time goes
* Game Board that you can see the highest score

## Control Flow

* Player start a game by picking up their shooting role. 
* Player will go to game scene with less enemies in the beginning. Player can 
moving forward and destroy enemies and earn some credit.
* Player will dead after he was attacked 3 times by enemies (Game Over). The 
player will restart game after they fail.
* The number of enemies will become more and more as time goes.
* We will have game board to record the player highest score.

## Implementation

### Model

* GameScene.swift : Assemble player data, enemy data and bullets data, records 
score.
* EndScene.swift: Displays user’s score,records highest score, as well as 
restart game.

### View

* GameScene.sks: General game scene with background. and random generate enemies 
object.

### Controller

* GameViewController.swift: controls the game by interact player with enemy and 
bullets. If the player is dead, game will jump to end scene.
