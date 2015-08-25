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
  var backgroundSpeed : CGFloat = 1
  var spikeSpeed : CGFloat = 1
  var bob = SKSpriteNode()
  var arrayOfPathsInGame = [SKSpriteNode()]
  
  override func didMoveToView(view: SKView) {
//    self.physicsWorld.gravity = CGVectorMake(0, -3)
//    self.physicsWorld.contactDelegate = self
    
    // loop through the background image
    for (var i : CGFloat = 0; i < 2; i++ ) {
      let bg = SKSpriteNode(imageNamed: "backgroundai")
      let groundTexture = SKTexture(imageNamed: "spike")
      bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
      bg.anchorPoint = CGPointZero
      bg.position = CGPoint(x: i * bg.size.width, y: 0)
      bg.name = "backgroundai"
      addChild(bg)
      
      let spikeNode = SKSpriteNode(texture: groundTexture)
      spikeNode.anchorPoint = CGPointZero
      spikeNode.size = CGSize(width: spikeNode.size.width, height: spikeNode.size.height)
      spikeNode.position = CGPoint(x: i * spikeNode.size.width, y: -50 )
//      spikeNode.physicsBody = SKPhysicsBody(rectangleOfSize: spikeNode.size)
      spikeNode.physicsBody = SKPhysicsBody(texture: groundTexture, size: spikeNode.size)
      spikeNode.physicsBody?.affectedByGravity = false
      spikeNode.physicsBody?.dynamic = false
      hotdog.physicsBody?.dynamic = true
      addChild(spikeNode)
      spikeNode.name = "spike"
    }
    
    let hotdogTexture = SKTexture(imageNamed: "hotdog")
    self.hotdog = SKSpriteNode(texture: hotdogTexture)
    self.hotdog.size = CGSizeMake(self.frame.size.width / 14, self.frame.size.height / 6)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
    
    self.hotdog.physicsBody = SKPhysicsBody(rectangleOfSize: self.hotdog.size )
    
    self.addChild(self.hotdog)

    for index in 1...3{
      bob = CreatePath.CreatePath(Int(RandomElements.randomPathVarYPosition(300, max: 750)), yInitialPosition: (RandomElements.randomPathVarYPosition(180, max: Int(self.frame.height)-68)), width: (RandomElements.randomPathLength()!))
      //println(self.frame.height)

      self.addChild(bob)
    }

 
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    self.hotdog.physicsBody?.velocity = CGVectorMake(0, 10)
    self.hotdog.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
  }
  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    
  }
  

  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
    enumerateChildNodesWithName("backgroundai", usingBlock: { (node, stop) -> Void in
      if let bg = node as? SKSpriteNode {
        bg.position = CGPoint(x: bg.position.x - self.backgroundSpeed , y: bg.position.y)
        if bg.position.x <= bg.size.width * -1 {
          bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
        }
      }
      })
      
      enumerateChildNodesWithName("spike", usingBlock: { (node, stop) -> Void in
        if let spike = node as? SKSpriteNode {
          spike.position = CGPoint(x: spike.position.x - self.spikeSpeed , y: spike.position.y)
          if spike.position.x <= spike.size.width * -1 {
            spike.position = CGPoint(x: spike.position.x + spike.size.width * 2, y: spike.position.y)
          }
        }
      })
    CreatePath.MovePathObject(bob)
    }
  }
   