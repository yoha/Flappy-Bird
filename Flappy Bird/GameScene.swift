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
    
    var bird: SKSpriteNode!
    var background: SKSpriteNode!
    
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
            background = SKSpriteNode(texture: backgroundTexture)
            background.position = CGPoint(x: backgroundTexture.size().width / 2 + backgroundTexture.size().width * i, y: CGRectGetMidY(self.frame))
            background.size.height = self.frame.height
            background.runAction(repeatAnimateBackgroundForever)
            self.addChild(background)
        }
        
        // **********************
        // ******** Bird ********
        // **********************
        
        let birdTexture1 = SKTexture(imageNamed: "flappy1")
        let birdTexture2 = SKTexture(imageNamed: "flappy2")
        let animateBirdTextures = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.1)
        let repeatAnimateBirdTexturesForever = SKAction.repeatActionForever(animateBirdTextures)
        
        bird = SKSpriteNode(texture: birdTexture1)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(repeatAnimateBirdTexturesForever)
        
        // applying physics (i.e., physics, inertia) to birdie
        bird.physicsBody = SKPhysicsBody(circleOfRadius: self.bird.size.height / 2)
        bird.physicsBody!.dynamic = true
        bird.physicsBody!.allowsRotation = false // <-- disallow the bird to spin
        self.addChild(bird)
        
        // **********************
        // ******* Ground *******
        // **********************
        
        let ground = SKNode()
        ground.position = CGPoint(x: 0, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width, height: 1))
        ground.physicsBody!.dynamic = false // <-- making it immune against gravity
        self.addChild(ground)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
