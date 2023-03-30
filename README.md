# Exercise-04c-Enemies

Exercise for MSCH-C220

A demonstration of this exercise is available at [https://youtu.be/0ovTabp_jEs](https://youtu.be/0ovTabp_jEs).

This exercise is designed to continue our creation of a 2D Platformer, by demonstrating some different types of enemies.

The expectations for this exercise are that you will

 - [ ] Fork and clone this repository
 - [ ] Import the project into Godot
 - [ ] Create the animations for the Golem's AnimatedSprite and connect them to the behaviors in the state machine
 - [ ] Using the TileMap in /Game/Navigation2d/Background, create a navigable area for the bat to travers
 - [ ] Create a state machine (with behaviors) for the bat
 - [ ] Test the game, attacking the enemies using the space bar
 - [ ] Edit the LICENSE and README.md
 - [ ] Commit and push your changes back to GitHub. Turn in the URL of your repository on Canvas.

## Instructions

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Optional-Exercise-04d-Enemies. Edit the LICENSE and replace BL-MSCH-C220 with your full name. Commit your changes.

Clone the repository to a Local Path on your computer.

Open Godot. Navigate to this folder. Import the project.godot file and open the "Enemies" project.

Open `res://Game.tscn`. You will see a tilemap node laying out the level, and a second "Background" tilemap inside a Navigation2D node (setting out the navigable areas for the bat). Inside the Enemy_Container node, there are three different enemy types and we will be implementing distinct behaviors for each.

Select the Navigation2D/Background node. Using the brown tile, select the areas where the bat should be able to navigate. Avoid the edges and the platforms, and try to create enough margin that the bat won't get stuck. It might be easier to hide the other background node while you are working, so you can see your work.

Open `res://Enemies/Golem.tscn`. The Golem scene has been created, with a state machine describing its behavior, but we need to add animations to correspond with its possible states. Select the AnimatedSprite node and create a new SpriteFrames. Using the corresponding sprite sheets in res://Assets, create animations for "Move", "Attack", and "Die". Move and Die should be set at 5 FPS and Move should be looping. Attack should be set at 15 FPS. Move can be set as the AnimationSprite's default animation. In the Golem's scripts, play those animations at the appropriate times. A few lines have been commented out in res://Enemies/Golem.gd. They account for the additional width of the animation when the Golem is attacking.

Open `res://Enemies/Bat.tscn`. Attach a script to the Bat node: `res://Enemies/Bat.gd`. The beginning of that script should be as follows:
```
extends KinematicBody2D

var player = null
onready var ray = $See
export var speed = 1500
export var looking_speed = 400
var line_of_sight = false

var mode = ""


var points = []
const margin = 1.5
```

It is possible to implement a simple state machine in a single file using flags (or a variable) to maintain the current state. That is the purpose of the mode variable. The modes should correspond with the three animations: attack, move, die. The bat should use the Navigation2D node to find a path to the player. If the bat can currently see the player (using the $See RayCast2D), its velocity should be "speed". Otherwise, it should use "looking_speed". Once you have found the player node, you can use the Navigation2D node as follows:
```
		points = get_node("/root/Game/Navigation2D").get_simple_path(global_position, player.global_position, true)
		if points.size() > 1:
			var distance = points[1] - global_position
			var direction = distance.normalized()
			if distance.length() > margin or points.size() > 2:
				velocity = direction*speed
			else:
				velocity = Vector2.ZERO
			velocity = move_and_slide(velocity, Vector2.ZERO)
```

I will leave the rest of the implementation to you (or to you following my demonstration).

Once you have completed the bat script, test the game. See if you can avoid and attack each of the enemies (the player attacks with the space bar).

Quit Godot. In GitHub desktop, add a summary message, commit your changes and push them back to GitHub. If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Optional-Exercise-04d-Enemies) on Canvas.

The final state of the file should be as follows (replacing the "Created by" information with your name):

```
# Exercise-04c-Enemies

Exercise for MSCH-C220

An exercise for the 2D Platformer project, exploring attacking and three different enemy types.

## Implementation

Built using Godot 3.5

The player sprite is an adaptation of [MV Platformer Male](https://opengameart.org/content/mv-platformer-male-32x64) by MoikMellah. CC0 Licensed.

The [tilemap](https://kenney.nl/assets/abstract-platformer) and the [coin sprite](https://kenney.nl/assets/puzzle-pack-2](https://kenney.nl/assets/puzzle-pack-2) are provided by Kenney.nl.

The enemies are from the [Medieval Fantasy Character Pack by OcO](https://oco.itch.io/medieval-fantasy-character-pack). CC0 Licensed

## References

None

## Future Development

None

## Created by 

Jason Francis
```
