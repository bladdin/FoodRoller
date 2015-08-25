//
//  GameScene.swift
//  Food Roller
//
//  Created by Benjamin Laddin on 8/21/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  var hotdog = SKSpriteNode()
  var backgroundSpeed : CGFloat = 3
  var bob = SKSpriteNode()
  
  override func didMoveToView(view: SKView) {
    self.physicsWorld.gravity = CGVectorMake(0, -3)
    self.physicsWorld.contactDelegate = self
    for (var i : CGFloat = 0; i < 2; i++ ) {
      let bg = SKSpriteNode(imageNamed: "background")
      let groundTexture = SKTexture(imageNamed: "spikes")
      let spikeNode = SKSpriteNode(texture: groundTexture)
      bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
      bg.anchorPoint = CGPointZero
      bg.position = CGPoint(x: i * bg.size.width, y: 0)
      
      bg.name = "background"
      spikeNode.size = CGSize(width: bg.size.width, height: spikeNode.size.height)
      spikeNode.position = CGPoint(x: 0, y: self.frame.size.height / 6 )
      spikeNode.physicsBody = SKPhysicsBody(texture: groundTexture, size: spikeNode.size)
      spikeNode.physicsBody?.affectedByGravity = false
      spikeNode.physicsBody?.dynamic = false
      hotdog.physicsBody?.dynamic = true
      bg.addChild(spikeNode)

      addChild(bg)
    }
    
    let hotdogTexture = SKTexture(imageNamed: "hotdog")
    self.hotdog = SKSpriteNode(texture: hotdogTexture)
    self.hotdog.size = CGSizeMake(self.frame.size.width / 10, self.frame.size.height / 6)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2 - 100, y: self.frame.size.height / 2)
    
    self.hotdog.physicsBody = SKPhysicsBody(rectangleOfSize: self.hotdog.size)
    
    self.addChild(self.hotdog)
    
    
//    
//    To create path use:
//    var bob = CreatePath.CreatePath(<#xInitialPosition: Int#>, yInitialPosition: <#Int#>, width: <#Int#>)
//    self.addChild(bob)
    bob = CreatePath.CreatePath(Int(self.frame.size.width-300), yInitialPosition: Int((self.frame.height/2)-200), width: 500)
    self.addChild(bob)
    bob.physicsBody = SKPhysicsBody(rectangleOfSize: bob.size)
    bob.physicsBody?.affectedByGravity = false
    bob.physicsBody?.dynamic = false
    
 
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
    CreatePath.MovePathObject(bob)
  }
  
}
