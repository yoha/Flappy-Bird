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
    
    // MARK: - Methods Override
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let birdTexture1 = SKTexture(imageNamed: "bird1")
        let birdTexture2 = SKTexture(imageNamed: "bird2")
        
        let birdTexturesToBeAnimated = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.3)
        let animateBirdTextures = SKAction.repeatActionForever(birdTexturesToBeAnimated)
        
        bird = SKSpriteNode(texture: birdTexture1)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(animateBirdTextures)
        
        self.addChild(bird)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
