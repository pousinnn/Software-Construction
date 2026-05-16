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
let BarSpeed = 500;
let BallSpeed = 350;

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
        if (this.velocity.magnitude() > 0) {
        this.velocity = this.velocity.normalize().times(BallSpeed);
    }
    this.position = this.position.plus(
        this.velocity.times(deltaTime)
    );
}
    reset(){
        this.velocity=new Vector(0,0)
        this.position=new Vector(CanvasWidth/2, CanvasHeight/2 + 30)
    }
    serve(){
        let angle = Math.random() * (Math.PI / 2 - 0.5) + 0.15;
        this.velocity.x= Math.cos(angle)*BallSpeed;
        this.velocity.y= Math.sin(angle)*BallSpeed;
        if (Math.random() > 0.5){
            this.velocity.x*=-1;
        }
    }
}
//Paddle
class Paddle extends GameObject{
    constructor(position, width, height, color, sheetCols){
        super(position, width, height, color, "Paddle", sheetCols);
        this.velocity=new Vector(0, 0);
        this.motion = {
    left: {
        axis: "x",
        sign: -1,
    },
    right: {
        axis: "x",
        sign: 1,
    },
};

this.keys = [];
}
update(deltaTime){
    this.velocity.x=0;
    this.velocity.y=0;
    for (const direction of this.keys){
        const axis=this.motion[direction].axis;
        const sign=this.motion[direction].sign;
        this.velocity[axis] += sign * BarSpeed;
    }
    this.position=this.position.plus(this.velocity.times(deltaTime));
    this.clampCanvas();
}
//For canvas
clampCanvas(){
    if(this.position.y-this.halfSize.y<0){
        this.position.y=this.halfSize.y;
    }
    if(this.position.x - this.halfSize.x<0){
        this.position.x = this.halfSize.x;
    }
    if (this.position.y + this.halfSize.y > CanvasHeight) {
        this.position.y = CanvasHeight - this.halfSize.y;
    }
    if (this.position.x + this.halfSize.x > CanvasWidth) {
        this.position.x = CanvasWidth - this.halfSize.x;
    }
}
}
class Game {
    constructor() {
        this.createEventListeners();
        this.initObjects()
        this.ping = document.createElement("audio");
        this.ping.src = "../extras/BubblePop.m4a";

        this.music = document.createElement("audio");
        this.music.src = "../extras/HoldOnTight.mp3";
        this.music.loop = true;
        this.over = document.createElement("audio");
        this.over.src = "../extras/GameOver.mp3";
        this.win = document.createElement("audio");
        this.win.src = "../extras/Victory.mp3";

        this.pointsBlocks = 0;
        this.lives = 3;
        this.level = 1;
        this.maxLevels = 3;
        this.isGameOver = false;
        this.isGameWon = false;
        this.elapsedTime = 0;
        this.finalTime = 0;
        this.gameStarted=false
    }

    randomColor() {
    const colors = ["#849dbb", "#50698d", "#4e7ab1", "#7d9fc0", "#a7c7e7", "#ceb5d4", "#e8ecef", "#e8ecef"];
    return colors[Math.floor(Math.random()*colors.length)];
    }

    createBlocks(){
        this.blocks = [];
        let rows = 7;
        let cols = 9;
        let block_w = 78;
        let block_h = 20;
        let blockPadding = 10;
        let blockOffsetTop = 100;
        let blockOffsetLeft = 70;
        for (let i = 0; i < cols; i++) {
            for (let j = 0; j < rows; j++) {
                let block_x = i * (block_w + blockPadding) + blockOffsetLeft;
                let block_y = j * (block_h + blockPadding) + blockOffsetTop;
                let block = new Blocks(
                    new Vector(block_x, block_y),
                    block_w,
                    block_h,
                    this.randomColor());
                    this.blocks.push(block);
                }
            }
        }

    initObjects() {
        this.background = new GameObject(new Vector(CanvasWidth / 2, CanvasHeight / 2), CanvasWidth, CanvasHeight, "black");
        this.paddleDown = new Paddle(new Vector(CanvasWidth/2, CanvasHeight - 50),
                                 125, 15, "#F2e199");
        this.ball = new Ball(new Vector(CanvasWidth/2, CanvasHeight/2 +30),
                                60, 60, 
                                "white"
                            );
                            this.ball.setSprite("../extras/alien.png")
        this.barrierTop = new GameObject(new Vector(CanvasWidth / 2, 0), CanvasWidth, 0);
        this.barrierLeft = new GameObject(
            new Vector(0, CanvasHeight/2), 
            10, 
            CanvasWidth
        );
        this.barrierRight = new GameObject(
            new Vector(CanvasWidth, CanvasHeight/2), 
            10, 
            CanvasWidth
        );

        this.goalDown = new GameObject(new Vector(CanvasWidth / 2, CanvasHeight), CanvasWidth, 0);

        this.pointsText = new TextLabel(20, 35, "15px 'Press Start 2P'", "white");
        this.pointsTextBlocks = new TextLabel(295, 35, "15px 'Press Start 2P'", "white");
        
        this.timerText = new TextLabel(20, 70, "15 px 'Press Start 2P'", "white");
        this.levelText = new TextLabel(700, 70, "15px 'Press Start 2P'", "white");

        this.livesText = new TextLabel(700, 35, "15px 'Press Start 2P'", "white");
        this.livesTextBlocks = new TextLabel(800, 35, "15px 'Press Start 2P'", "white");

        this.gameOver = new TextLabel(260, CanvasHeight/2, "35px 'Press Start 2P'", "white");

        this.gameWon = new TextLabel(260, CanvasHeight/2, "35px 'Press Start 2P'", "white");

        this.createBlocks();
    }

    draw(ctx) {
        this.paddleDown.draw(ctx);
        this.barrierTop.draw(ctx);
        this.barrierLeft.draw(ctx);
        this.barrierRight.draw(ctx);

        this.goalDown.draw(ctx);

        this.pointsText.draw(ctx, "Eliminated blocks:  ");
        this.pointsTextBlocks.draw(ctx, this.pointsBlocks);

        let currentTime;
        if (this.isGameWon) {
            currentTime = this.finalTime.toFixed(1);
        } else {
            currentTime = this.elapsedTime.toFixed(1);
        }
        this.timerText.draw(ctx, "Time: " + currentTime + "s");
        this.levelText.draw(ctx, "Level: " + this.level);
        
        this.livesText.draw(ctx, "Lives: ");
        this.livesTextBlocks.draw(ctx, this.lives);

        for (let block of this.blocks){
            block.draw(ctx);
        }
        if (this.isGameOver){
            this.gameOver.draw(ctx, "Game Over");
        }

        if (!this.isGameOver) {
            this.ball.draw(ctx);
        }

        if (this.isGameWon) {
            this.gameWon.draw(ctx, "You Win!");
        }
    }

    update(deltaTime) {
        this.paddleDown.update(deltaTime);
        this.ball.update(deltaTime);
        if (this.gameStarted && !this.isGameOver && !this.isGameWon) {
            this.elapsedTime += deltaTime;
        }
        
        if (this.isGameOver || this.isGameWon) {
        return;
        }

        if (boxOverlap(this.ball, this.barrierTop)) {
            this.ball.velocity.y *= -1;
            this.ping.play();
        }

        if (boxOverlap(this.ball, this.barrierLeft) || boxOverlap(this.ball, this.barrierRight)) {
            this.ball.velocity.x *= -1;
            this.ball.position.x += this.ball.velocity.x * 0.04;
            this.ping.play();
        }

        if (boxOverlap(this.ball, this.paddleDown)) {
            this.ball.position.y = (this.paddleDown.position.y - this.paddleDown.halfSize.y - this.ball.halfSize.y - 1);
            this.ball.velocity.y = -Math.abs(this.ball.velocity.y);
            this.ping.play();
        }

        if (boxOverlap(this.ball, this.goalDown)) {
            this.lives -= 1;
            if (this.lives > 0){
            this.ball.reset();
            this.gameStarted = false;
            } else{
                this.isGameOver = true;
                this.lives = 0;
                this.over.play();
            }
        }

        for (let i = 0; i < this.blocks.length; i++) {
            if (boxOverlap(this.ball, this.blocks[i])) {
                this.ball.velocity.y *= -1;

                if (this.blocks[i].color === "#ceb5d4") {
                    BallSpeed *= 0.9;
                } 
                else if (this.blocks[i].color === "#e8ecef") {
                    BallSpeed *= 1.3;
                } 
                this.blocks[i].destroy = true;
                this.pointsBlocks += 1;
                this.ping.play();
                break;
            }
        }

        this.blocks = this.blocks.filter(block => !block.destroy);
        
        if (this.blocks.length == 0) {
            if (this.level < this.maxLevels) {
                this.level++;
                this.createBlocks();
                this.ball.reset();} 
                else{
                    this.isGameWon = true;
                    this.finalTime = this.elapsedTime;
                    this.win.play();
                }
            }
        }

    
    createEventListeners() {
        window.addEventListener('keydown', (event) => {
            if (event.key == 'ArrowLeft') {
                this.addKey('left', this.paddleDown);
            } else if (event.key == 'ArrowRight') {
                this.addKey('right', this.paddleDown);
            }

            if (event.code == 'Space') {
                if(!this.gameStarted){
                    this.gameStarted = true;
                }
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


function main() {
    const canvas = document.getElementById('canvas');
    canvas.width = CanvasWidth;
    canvas.height = CanvasHeight;
    ctx = canvas.getContext('2d');
    game = new Game();
    drawScene(0);
}


function drawScene(newTime) {
    let deltaTime = (newTime - PreviousTime)/1000;
    ctx.clearRect(0, 0, CanvasWidth, CanvasHeight);
    game.update(deltaTime);
    game.draw(ctx);
    PreviousTime = newTime;
    requestAnimationFrame(drawScene);
}
