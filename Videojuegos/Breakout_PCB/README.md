# Instructions for “*Práctica Conceptos Básicos de Videojuegos (Breakout)*”

Paulina Cortez Balvanera | A01782041

May 15, 2026

## Starting the game:   
Download the folder ‘[Breakout_PCB](https://github.com/pousinnn/Software-Construction/tree/main/Videojuegos/Breakout_PCB)’, when downloaded, search for the folder *'html'* and inside there should be a file named *'html_breakout.html'*. When found, select it and open it in a browser of your preference. The screen should look like this:

![alt text](<Captura de pantalla 2026-05-15 232459.png>)

## Game explanation
The game 'Breakout' will consist in a bar (paddle) that is being controlled by the user. In this case, the paddle will help to avoid dropping the alien, who plays the role of a ball that has to destroy all the blocks at the top of the screen by hitting them individually. For this game, the player has three lives that will help them to survive for three levels, and gain their points by the amount of blocks eliminated. The final goal is to surpass the three levels in the smallest time possible.

## Controls for the user:
The game works through three keys from their computer's keyboard:
- Left & right key: Will be able to move the paddle in their respective directions. 
- Space bar: Will help to launch the alien to move throughout the screen and hit the blocks.

## Rules for the gameplay:
- The gameplay will start after selecting the *space key*, meaning that alien will start moving in a random direction when selected.
- When the alien hits a block, it will be destroyed and will make the points counter increase.
- The alien is also capable of hitting the paddle, the vertical borders and the top border. This will make him bounce but no point will be gained from that.
- The **only** way of **losing a life** in the game is by allowing the alien to fall and touch the bottom border. 
- The **only** way of **losing the game** is by losing the three lives.
- The **only** way of **winning the game** is by eliminating all the blocks throughout the three levels.
- There are two possible outputs for the ending screen:
    - "You Win!" for the winning screen
    - "Game Over" for the losing screen

## Important notes:
- For this game, the special additions that were added include:
    - Gained points counter: This counter considers your points by the amount of blocks you have been able to destroy throughout the gameplay. No matter the color or time they were destroyed, they will be counted for the counter.
    - A timer: The timer will count the amount of seconds that it took the player to complete the gameplay. The timer will start everytime the key *'space'* is clicked to start the game and will be paused when the player is able to switch into the next level.
    - Blocks that change velocity: Every gameplay, different blocks will appear on the main screen. All of them being in different shades of blue, yet, there are two very important blocks that will affect the gameplay experience:
        - Light purple blocks: Will make the alien lower his speed and help the player to reach him faster and avoid him falling.
        - White blocks: Will make the alien increase his speed and make it more difficult for the player to reach him on time.

- The inmersive experience relies in both the visuals and the musical environment. The instrumental of *'Hold on Tight'* by **aespa (2023)** was used as part of the background music, since it's a game-like sound, cyberpunk vibe and electronic vibes. Helping the space-like surrounding to feel magestic yet futuristic to keep the gameplay active. 
- The game also counts with sound effect for the moment there is a collision between the alien and the different objects *(paddle, blocks and borders)* 