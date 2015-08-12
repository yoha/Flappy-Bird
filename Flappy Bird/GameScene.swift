//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Yohannes Wijaya on 8/11/15.
//  Copyright (c) 2015 Yohannes Wijaya. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // MARK: - Local Properties
    
    var background: SKSpriteNode!
    var bird: SKSpriteNode!
    var ground: SKNode!
    var pipe: SKSpriteNode!
    
    // MARK: - Methods Override
    
    override func didMoveToView(view: SKView) {
        
        // **********************
        // ***** Background *****
        // **********************
        
        let backgroundTexture = SKTexture(imageNamed: "background")
        let animateBackground = SKAction.moveByX(-backgroundTexture.size().width, y: 0, duration: 9)
        let animateBackgroundReplacement = SKAction.moveByX(backgroundTexture.size().width, y: 0, duration: 0)
        let repeatAnimateBackgroundForever = SKAction.repeatActionForever(SKAction.sequence([animateBackground, animateBackgroundReplacement]))
        
        for var i: CGFloat = 0; i < 3; ++i {
            self.background = SKSpriteNode(texture: backgroundTexture)
            self.background.position = CGPoint(x: backgroundTexture.size().width / 2 + backgroundTexture.size().width * i, y: CGRectGetMidY(self.frame))
            self.background.size.height = self.frame.height
            self.background.runAction(repeatAnimateBackgroundForever)
            self.addChild(background)
        }
        
        // **********************
        // ******** Bird ********
        // **********************
        
        let birdTexture1 = SKTexture(imageNamed: "flappy1")
        let birdTexture2 = SKTexture(imageNamed: "flappy2")
        let animateBirdTextures = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.1)
        let repeatAnimateBirdTexturesForever = SKAction.repeatActionForever(animateBirdTextures)
        
        self.bird = SKSpriteNode(texture: birdTexture1)
        self.bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.bird.runAction(repeatAnimateBirdTexturesForever)
        
        // applying physics (i.e., physics, inertia) to birdie
        self.bird.physicsBody = SKPhysicsBody(circleOfRadius: self.bird.size.height / 2)
        self.bird.physicsBody!.dynamic = true
        self.bird.physicsBody!.allowsRotation = false // <-- disallow the bird to spin
        self.bird.zPosition = 1 // <-- making it the foremost sprite in the view
        self.addChild(bird)
        
        // **********************
        // ******* Ground *******
        // **********************
        
        self.ground = SKNode()
        self.ground.position = CGPoint(x: 0, y: 0)
        self.ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width, height: 1))
        self.ground.physicsBody!.dynamic = false // <-- making it immune against gravity
        self.addChild(ground)
        
        // **********************
        // ******** Pipes *******
        // **********************
        
        let gapSizeBetweenPipes = self.bird.size.height * 4
        // each pipe can move (max) up / down 1/4 of the screen's height, which leaves 1/2 of screen's height remaining for movement (1/4 + 1/4 + 1/2 = 1)
        let rangeOfPipesMovement = arc4random() % UInt32(self.frame.size.height / 2) // <-- between 0 and 1/2 of the screen's height
        let pipesMovementOffset = CGFloat(rangeOfPipesMovement) - self.frame.size.height / 4 // shifting it down by another 1/4 of the screen's height if needed. meaning it can have a max value of a 1/4 screen's height up & a min value of a 1/4 screen's height down.
        
        
        let pipeTexture1 = SKTexture(imageNamed: "pipe1")
        self.pipe = SKSpriteNode(texture: pipeTexture1)
        self.pipe.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) + self.pipe.size.height / 2 + gapSizeBetweenPipes / 2 + pipesMovementOffset)
        self.addChild(pipe)
        
        let pipeTexture2 = SKTexture(imageNamed: "pipe2")
        self.pipe = SKSpriteNode(texture: pipeTexture2)
        self.pipe.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - self.pipe.size.height / 2 - gapSizeBetweenPipes / 2 + pipesMovementOffset)
        self.addChild(pipe)
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.bird.physicsBody!.velocity = CGVectorMake(0, 0) // <-- set the bird's velocity to 0 so it doesn't fly off the screen when tapped
        self.bird.physicsBody!.applyImpulse(CGVectorMake(0, 50)) // <-- apply momentum vertically to make the bird "jump"
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
