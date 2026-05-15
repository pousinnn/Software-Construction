/*
Practica Conceptos Básicos de Videojuegos (Breakout)
Pau Cortez Balvanera | A01782041
May 13, 2026
*/
"use strict";
//For canvas
let ctx;
let game;
const CanvasWidth = 850;
const CanvasHeight = 600;

//for time 
let PreviousTime = 0;
let BarSpeed = 0.80;
let BallSpeed = 0.6;

//Blocks
class Blocks extends GameObject {
    constructor(position, width, height, color, sheetCols) {
        super(position, width, height, color, "block", sheetCols);
        this.velocity = new Vector(0, 0);
    }   
}

//Ball
class Ball extends GameObject {
    constructor(position, width, height, color, sheetCols) {
        super(position, width, height, color, "ball", sheetCols);
        this.velocity = new Vector(0, 0);
    }
    update (deltaTime){
        this.speed=this.speed.normalize().times(BallSpeed);
        this.position=this.position.plus(this.speed.times(deltaTime))
    }
    reset(){
        this.speed=new Vector(0,0)
        this.position=new Vector(CanvasWidth/2, CanvasHeight/2)
    }
    serve(){ //angles
        let.angle=Math.random()*(Math.PI/2 - 0.5)+ 0.15;
        this.speed.x= Math.cos(angle);
        this.speed.y= Math.sin(angle);
        if (Math.random() > 0.7){
            this.speed.x=-1;
        }
    }
}
//Paddle
class Paddle extends GameObject{
    constructor(position, width, height, color, sheetCols){
        super(position, width, height, color, "Paddle", sheetCols);
        this.speed=new Vector(0, 0);
        this.motion={
            left: {
            axis: "x",
            sign: -1,
        },
        right:{
            axis: "x",
            sign: "1",
        },
    }
    this.keys=[];
}
update(deltaTime){
    this.speed.x=0;
    this.speed.y=0;
    for (const direction of this.keys){
        const axis=this.motion[direction].axis;
        const sign=this.motion[direction].sign;
        this.speed[axis]+=sign;
    }
    this.position=this.position.plus(this.speed.times(deltaTime));
    this.clampCanvas();
}
//For canvas
clampCanvas(){
    if(this.position.y-this.halfSize.y<0){
        this.position.y=this.halfSize.y;
    }
    if(this.position.x - this.halfSize.x<0){
        this.position.x = this.halfSize;
    }
    if (this.position.y + this.halfSize.y > canvasHeight) {
        this.position.y = canvasHeight - this.halfSize.y;
    }
    if (this.position.x + this.halfSize.x > canvasWidth) {
        this.position.x = canvasWidth - this.halfSize.x;
    }
}
}
class Game {
    constructor() {
        this.createEventListeners();
        this.initObjects()
        this.ping = document.createElement("audio");
        this.ping.src = "../assets/audio/4387__noisecollector__pongblipe4.wav";

        this.music = document.createElement("audio");
        this.music.src = "../assets/audio/679054_migfus20_relaxing-chiptune-music.mp3";
        this.music.loop = true;

        this.over = document.createElement("audio");
        this.over.src = "../assets/audio/GameOver.wav";

        this.win = document.createElement("audio");
        this.win.src = "../assets/audio/round_end.wav";

        // Variables to keep score of the game
        this.pointsBlocks = 0;
        this.lives = 3;
        this.isGameOver = false;
        this.isGameWon = false;
    }

    // Creates blocks of different colors
    randomColor() {
    const colors = ["#ffcce6", "#ccd9ff", "#ccfff2", "#ffffcc", "#ccffcc", "#d11e7b", "#5472cb"];
    return colors[Math.floor(Math.random() * colors.length)];
    }

    initObjects() {
        // Add another object to draw a background
        this.background = new GameObject(new Vector(canvasWidth / 2, canvasHeight / 2), canvasWidth, canvasHeight, "black");
        // this.background.setSprite("../assets/sprites/trak2_plate2b.png");

        this.paddleDown = new Paddle(new Vector(canvasWidth / 2, canvasHeight - 50),
                                 125, 15, "pink");
        //this.paddleLeft.setSprite("../assets/sprites/blordrough_quartermaster-NESW.png",
                                //        x   y    w   h
                                //new Rect(48, 128, 48, 64));

        this.ball = new Ball(new Vector(canvasWidth / 2, canvasHeight / 2),
                                20, 20, "white");

        this.barrierTop = new GameObject(new Vector(canvasWidth / 2, 0), canvasWidth, 0);
        this.barrierTop.setSprite("../assets/sprites/RTS_Crate.png")
        this.barrierLeft = new GameObject(new Vector(0, canvasHeight / 2), 0, canvasWidth);
        this.barrierLeft.setSprite("../assets/sprites/RTS_Crate.png")
        this.barrierRight = new GameObject(new Vector(canvasWidth, canvasHeight / 2), 0, canvasWidth);
        this.barrierRight.setSprite("../assets/sprites/RTS_Crate.png")

        this.goalDown = new GameObject(new Vector(canvasWidth / 2, canvasHeight), canvasWidth, 0);

        // Labels to show the score of each player
        this.pointsText = new TextLabel(20, 35, "25px Ubuntu Mono", "white");
        this.pointsTextBlocks = new TextLabel(275, 35, "25px Ubuntu Mono", "white");

        this.livesText = new TextLabel(650, 35, "25px Ubuntu Mono", "white");
        this.livesTextBlocks = new TextLabel(750, 35, "25px Ubuntu Mono", "white");

        this.gameOver = new TextLabel(100, canvasHeight / 2, "60px Ubuntu Mono", "white");

        this.gameWon = new TextLabel(90, canvasHeight / 2, "60px Ubuntu Mono", "white");

        
        this.blocks = [];

        // Number of columns and rows of blocks
        let rows = 7;
        let cols = 9;
        let block_w = 78;
        let block_h = 20;
        let blockPadding = 10;
        let blockOffsetTop = 60;
        let blockOffsetLeft = 49;

        for (let i = 0; i < cols; i++) {
            for (let j = 0; j < rows; j++) {

            let block_x = i * (block_w + blockPadding) + blockOffsetLeft;
            let block_y = j * (block_h + blockPadding) + blockOffsetTop;

            let block = new Block(new Vector(block_x, block_y), block_w, block_h, this.randomColor());

            this.blocks.push(block);
            }

        }

    }

    draw(ctx) {
        // Draw the background first, so everything else is drawn on top
        this.background.draw(ctx);

        this.paddleDown.draw(ctx);

        this.barrierTop.draw(ctx);
        this.barrierLeft.draw(ctx);
        this.barrierRight.draw(ctx);

        this.goalDown.draw(ctx);

        this.pointsText.draw(ctx, "Destroyed blocks: ");
        this.pointsTextBlocks.draw(ctx, this.pointsBlocks);

        this.livesText.draw(ctx, "Lives: ");
        this.livesTextBlocks.draw(ctx, this.lives);

        if (this.isGameOver){
            this.gameOver.draw(ctx, "G A M E   O V E R");
        }

        for (let block of this.blocks){
            block.draw(ctx);
        }

        if (!this.isGameOver) {
            this.ball.draw(ctx);
        }

        if (this.pointsBlocks == 63){
            this.isGameWon = true;
            this.gameWon.draw(ctx, "Y O U   W O N ! ! !");
        }
    }

    update(deltaTime) {
        // Move the paddleLeft
        this.paddleDown.update(deltaTime);
        this.ball.update(deltaTime);

        
        // Make the ball disappear and stop the game
        if (this.isGameOver || this.isGameWon) {
        return;
        }

        if (boxOverlap(this.ball, this.barrierTop)) {
            this.ball.velocity.y *= -1;
            // Make the ball faster with every contact
            this.ball.velocity = this.ball.velocity.times(1.1);
            // Play the sound
            this.ping.play();
        }

        if (boxOverlap(this.ball, this.barrierLeft) || boxOverlap(this.ball, this.barrierRight)) {
            this.ball.velocity.x *= -1;
            // Make the ball faster with every contact
            this.ball.velocity = this.ball.velocity.times(1.1);
            // Play the sound
            this.ping.play();
        }

        if (boxOverlap(this.ball, this.paddleDown)) {
            this.ball.velocity.y *= -1;
            // Make the ball faster with every contact
            this.ball.velocity = this.ball.velocity.times(1.1);
            // Play the sound
            this.ping.play();
        }

        // Detect when a player scores a point
        if (boxOverlap(this.ball, this.goalDown)) {
            this.lives -= 1;
            if (this.lives > 0){
            this.ball.reset();
            } else{
                this.isGameOver = true;
                this.lives = 0;
                this.over.play();
            }
        }

        // Extra: change of velocity
        for (let i = 0; i < this.blocks.length; i++) {
            if (boxOverlap(this.ball, this.blocks[i])) {
                this.ball.velocity.y *= -1;

                if (this.blocks[i].color === "#5472cb") {
                    ballSpeed *= 0.8;
                } 
                else if (this.blocks[i].color === "#d11e7b") {
                    ballSpeed *= 1.1;
                } 

                this.blocks[i].destroy = true;
                this.pointsBlocks += 1;
                // Make the ball faster with every contact
                this.ball.velocity = this.ball.velocity.times(1.1);
                // Play the sound
                this.ping.play();
                break;
            }
        }

        // Destroy block
        this.blocks = this.blocks.filter(block => !block.destroy);

    }

    
    createEventListeners() {
        window.addEventListener('keydown', (event) => {
            if (event.key == 'ArrowLeft') {
                this.addKey('left', this.paddleDown);
            } else if (event.key == 'ArrowRight') {
                this.addKey('right', this.paddleDown);
            }

            // Add a key for the initial serve of the ball
            if (event.code == 'Space') {
                this.ball.serve();
                this.music.play();
            }
        });

        window.addEventListener('keyup', (event) => {
            if (event.key == 'ArrowLeft') {
                this.delKey('left', this.paddleDown);
            } else if (event.key == 'ArrowRight') {
                this.delKey('right', this.paddleDown);
            }
            
        });
    }

    addKey(direction, paddle) {
        if (!paddle.keys.includes(direction)) {
            paddle.keys.push(direction);
        }
    }

    delKey(direction, paddle) {
        if (paddle.keys.includes(direction)) {
            paddle.keys.splice(paddle.keys.indexOf(direction), 1);
        }
    }
}


// Starting function that will be called from the HTML page
function main() {
    // Get a reference to the object with id 'canvas' in the page
    const canvas = document.getElementById('canvas');
    // Resize the element
    canvas.width = canvasWidth;
    canvas.height = canvasHeight;
    // Get the context for drawing in 2D
    ctx = canvas.getContext('2d');

    // Create the game object
    game = new Game();

    drawScene(0);
}


// Main loop function to be called once per frame
function drawScene(newTime) {
    // Compute the time elapsed since the last frame, in milliseconds
    let deltaTime = newTime - oldTime;

    // Clean the canvas so we can draw everything again
    ctx.clearRect(0, 0, canvasWidth, canvasHeight);

    game.update(deltaTime);

    game.draw(ctx);

    oldTime = newTime;
    requestAnimationFrame(drawScene);
}