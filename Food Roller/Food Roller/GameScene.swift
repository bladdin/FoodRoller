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
  var startLocation = CGPoint()
  var endLocation = CGPoint()


  var arrayOfPathsInGame = [SKSpriteNode()]

  
  override func didMoveToView(view: SKView) {

    
    physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 250, y: 0, width: self.size.width - 500, height: self.size.height))
    
    // loop through the background image
    for (var i : CGFloat = 0; i < 2; i++ ) {

      let bg = SKSpriteNode(imageNamed: "backgroundai")
      let groundTexture = SKTexture(imageNamed: "spike")

      bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
      bg.anchorPoint = CGPointZero
      bg.position = CGPoint(x: i * bg.size.width, y: 0)
      bg.name = "backgroundai"
      addChild(bg)
      let spikeNode2 = SKSpriteNode(texture: groundTexture)
      let spikeNode = SKSpriteNode(texture: groundTexture)
      spikeNode.anchorPoint = CGPointZero
      spikeNode.position = CGPoint(x: i * spikeNode.size.width, y: -30 )
      let bottomBoundSize = CGSize(width: bg.size.width, height: spikeNode.size.height + 100)
      spikeNode.physicsBody = SKPhysicsBody(rectangleOfSize: bottomBoundSize)
      spikeNode.physicsBody?.affectedByGravity = false
      spikeNode.physicsBody?.dynamic = false

//      spikeNode.size = CGSize(width: spikeNode.size.width, height: spikeNode.size.height)

//      spikeNode.physicsBody = SKPhysicsBody(rectangleOfSize: groundTexture.size())

//      spikeNode.physicsBody = SKPhysicsBody(texture: groundTexture, size: spikeNode.size)
//      spikeNode.physicsBody?.affectedByGravity = false
//      spikeNode.physicsBody?.dynamic = false
      
    //  spikeNode2.size = CGSize(width: spikeNode.size.width, height: spikeNode.size.height)
 //     spikeNode2.anchorPoint = CGPointZero
//      spikeNode2.anchorPoint = CGPointZero
//      spikeNode2.position = CGPoint(x: i * spikeNode2.size.width, y: -200)
//      spikeNode2.physicsBody = SKPhysicsBody(texture: groundTexture, size: spikeNode.size)
//      spikeNode2.physicsBody?.affectedByGravity = false
//      spikeNode2.physicsBody?.dynamic = false
//      spikeNode2.zRotation = CGFloat(M_PI)
      hotdog.physicsBody?.dynamic = true
 //     addChild(spikeNode2)
      spikeNode.name = "spikeBottom"
      addChild(spikeNode)
//      spikeNode2.name = "spikeTop"
    }
    

    
    let hotdogTexture = SKTexture(imageNamed: "hotdog")
    self.hotdog = SKSpriteNode(texture: hotdogTexture)
    self.hotdog.size = CGSizeMake(self.frame.size.width / 14, self.frame.size.height / 6)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
    
    self.hotdog.physicsBody = SKPhysicsBody(rectangleOfSize: self.hotdog.size)
  //  self.hotdog.physicsBody = SKPhysicsBody(circleOfRadius: self.hotdog.size.height / 2)
    
    self.addChild(self.hotdog)
    


    for index in 1...3{
      bob = CreatePath.CreatePath(Int(RandomElements.randomPathVarYPosition(800, max: 1000))+index*50, yInitialPosition: (RandomElements.randomPathVarYPosition(180, max: Int(self.frame.height)-68)), width: (RandomElements.randomPathLength()!))
      //println(self.frame.height)
      self.arrayOfPathsInGame.append(bob)
      self.addChild(bob)
    }


 
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    for touch in touches {
      if let touch = touch as? UITouch {
        startLocation = touch.locationInNode(self)
      }
    }
  }
  

  
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    for touch in touches {
      if let touch = touch as? UITouch {
        endLocation = touch.locationInNode(self)
        let difference = CGVectorMake(CGFloat((endLocation.x - startLocation.x) * -1), abs(endLocation.y - startLocation.y) * 1.6)
        
        
     //   let difference = CGVectorMake(0, abs(endLocation.y - startLocation.y) * 1.6)
        self.hotdog.physicsBody?.applyImpulse(difference)
      }
    }
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
      
    enumerateChildNodesWithName("spikeBottom", usingBlock: { (node, stop) -> Void in
      if let spike = node as? SKSpriteNode {
        spike.position = CGPoint(x: spike.position.x - self.spikeSpeed , y: spike.position.y)
        if spike.position.x <= spike.size.width * -1 {
          spike.position = CGPoint(x: spike.position.x + spike.size.width * 2, y: spike.position.y)
        }
      }
    })
    for bob in self.arrayOfPathsInGame{
      CreatePath.MovePathObject(bob)
    }
  }
}