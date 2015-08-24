//
//  GameScene.swift
//  Food Roller
//
//  Created by Benjamin Laddin on 8/21/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  var background = SKSpriteNode(imageNamed: "background")
  var hotdog = SKSpriteNode()
  var backgroundSpeed : CGFloat = 3
  override func didMoveToView(view: SKView) {
    
    self.physicsWorld.gravity = CGVectorMake(0, -3)
    self.physicsWorld.contactDelegate = self
    
//    self.background.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
//    self.background.size = CGSizeMake(self.frame.size.width, self.frame.size.height)
//    self.addChild(self.background)
    
    for (var i : CGFloat = 0; i < 2; i++ ) {
      let bg = SKSpriteNode(imageNamed: "background")
      bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
      bg.anchorPoint = CGPointZero
      bg.position = CGPoint(x: i * bg.size.width, y: 0)
      
      bg.name = "background"
      addChild(bg)
    }
    
//    var backgroundMoveLeft = SKAction.moveByX(-self.frame.size.width, y: 0, duration: NSTimeInterval(background.size.width*0.015))
//    var backgroundReset = SKAction.moveByX(background.size.width, y: 0, duration: 0)
//    var backgroundMovingLeftForever = SKAction.repeatActionForever(SKAction.sequence([backgroundMoveLeft, backgroundReset]))
    
    var hotdogTexture = SKTexture(imageNamed: "hotdog")
    self.hotdog = SKSpriteNode(texture: hotdogTexture)
    self.hotdog.size = CGSizeMake(self.frame.size.width / 10, self.frame.size.height / 6)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
    self.addChild(self.hotdog)
    
    
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
    enumerateChildNodesWithName("background", usingBlock: { (node, stop) -> Void in
      if let bg = node as? SKSpriteNode {
        bg.position = CGPoint(x: bg.position.x - self.backgroundSpeed , y: bg.position.y)
        if bg.position.x <= bg.size.width * -1 {
          bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
        }
      }
    })
  }
}
