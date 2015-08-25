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
      let spikeNode2 = SKSpriteNode(texture: groundTexture)
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
      
      spikeNode2.size = CGSize(width: bg.size.width, height: spikeNode.size.height)
      spikeNode2.position = CGPoint(x: 0, y: self.frame.size.height * (10/12))
      spikeNode2.physicsBody = SKPhysicsBody(texture: groundTexture, size: spikeNode.size)
      spikeNode2.physicsBody?.affectedByGravity = false
      spikeNode2.physicsBody?.dynamic = false
      spikeNode2.zRotation = CGFloat(M_PI)
      hotdog.physicsBody?.dynamic = true
      bg.addChild(spikeNode2)
      addChild(spikeNode)
      spikeNode.name = "spike"
    }
    
    let pan = UIPanGestureRecognizer(target: self, action: "scenePanned:") //Create instance of gesture, and target method to be called
    self.view?.addGestureRecognizer(pan) //Adding gesture to the view (gesture must be added to view)
    
    let hotdogTexture = SKTexture(imageNamed: "hotdog")
    self.hotdog = SKSpriteNode(texture: hotdogTexture)
    self.hotdog.size = CGSizeMake(self.frame.size.width / 14, self.frame.size.height / 6)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
    
    self.hotdog.physicsBody = SKPhysicsBody(rectangleOfSize: self.hotdog.size )
    
    self.addChild(self.hotdog)
    


    for index in 1...3{
      bob = CreatePath.CreatePath(Int(RandomElements.randomPathVarYPosition(800, max: 1000))+index*50, yInitialPosition: (RandomElements.randomPathVarYPosition(180, max: Int(self.frame.height)-68)), width: (RandomElements.randomPathLength()!))
      //println(self.frame.height)
      self.arrayOfPathsInGame.append(bob)
      self.addChild(bob)
    }


 
  }
  
  func scenePanned(pan : UIPanGestureRecognizer) {
    //println(pan.velocityInView(self.view!))

    if pan.state == UIGestureRecognizerState.Began {
      let initialPosition = hotdog.position
      println(initialPosition)
    }

    
    if pan.state == UIGestureRecognizerState.Changed {
      hotdog.position.x = hotdog.position.x + pan.translationInView(self.view!).x
      hotdog.position.y = hotdog.position.y + (pan.translationInView(self.view!).y * -1)
    }

//  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//    self.hotdog.physicsBody?.velocity = CGVectorMake(0, 10)
//    self.hotdog.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 300))
//  }
//  
//  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
//    
//    if pan.state == UIGestureRecognizerState.Ended {
//      println(pan.translationInView(self.view!))
//
//    }
//  }
//  

//  override func update(currentTime: CFTimeInterval) {
//    /* Called before each frame is rendered */
//    enumerateChildNodesWithName("background", usingBlock: { (node, stop) -> Void in
//      if let bg = node as? SKSpriteNode {
//        bg.position = CGPoint(x: bg.position.x - self.backgroundSpeed , y: bg.position.y)
//        if bg.position.x <= bg.size.width * -1 {
//          bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
//        }
//      }
//    })
//    CreatePath.MovePathObject(bob)
//  }
  
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
    for bob in self.arrayOfPathsInGame{
    CreatePath.MovePathObject(bob)
    }
    }
  }

