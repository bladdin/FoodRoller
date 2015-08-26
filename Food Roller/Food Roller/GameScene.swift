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
  var timerLabelNode = SKLabelNode(text: "0")
  var timer = NSTimer()
  var timerCount = 0
  
  override func didMoveToView(view: SKView) {

    BackgroundMusic.playBackgroundMusic("bensoundFunnysong.mp3")
    
    physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 250, y: 0, width: self.size.width - 500, height: self.size.height))
    
    // BACKGROUND AND SPIKE NODES
    for (var i : CGFloat = 0; i < 2; i++ ) {
      let bg = SKSpriteNode(imageNamed: "gameBackground")
      let groundTexture = SKTexture(imageNamed: "cactus")
      
      bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
      bg.anchorPoint = CGPointZero
      bg.position = CGPoint(x: i * bg.size.width, y: 0)
      bg.name = "gameBackground"
      addChild(bg)
      let spikeNode2 = SKSpriteNode(texture: groundTexture)
      let spikeNode = SKSpriteNode(texture: groundTexture)
      spikeNode.anchorPoint = CGPointZero
      spikeNode.position = CGPoint(x: i * spikeNode.size.width, y: -30 )
      let bottomBoundSize = CGSize(width: spikeNode.size.width + 200, height: spikeNode.size.height + 120)
      spikeNode.physicsBody = SKPhysicsBody(rectangleOfSize: bottomBoundSize)
      spikeNode.physicsBody?.affectedByGravity = false
      spikeNode.physicsBody?.dynamic = false
      
      
      hotdog.physicsBody?.dynamic = true
      spikeNode.name = "spikeBottom"
      addChild(spikeNode)
    }
    
    
    // HOTDOG NODE
//    let hotdogTexture = SKTexture(imageNamed: "hotdog")
    var hotdogTexture1 = SKTexture(imageNamed: "1")
    var hotdogTexture2 = SKTexture(imageNamed: "2")
    var hotdogTexture3 = SKTexture(imageNamed: "3")
    var hotdogTexture4 = SKTexture(imageNamed: "4")
    var hotdogTexture5 = SKTexture(imageNamed: "5")
    var hotdogTexture6 = SKTexture(imageNamed: "6")

    self.hotdog = SKSpriteNode(texture: hotdogTexture1)
    self.hotdog.size = CGSizeMake(self.frame.size.width / 16, self.frame.size.height / 8)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
    self.hotdog.physicsBody = SKPhysicsBody(rectangleOfSize: self.hotdog.size)
    var run = SKAction.animateWithTextures([hotdogTexture1, hotdogTexture2, hotdogTexture3, hotdogTexture4, hotdogTexture5, hotdogTexture6], timePerFrame: 0.12)
    var runForever = SKAction.repeatActionForever(run)
    self.hotdog.runAction(runForever)
//      self.hotdog.physicsBody = SKPhysicsBody(circleOfRadius: self.hotdog.size.height / 2)
    self.addChild(self.hotdog)
    
    
    // TIMER:
    timerLabelNode.position = CGPoint(x: self.frame.size.width/2 + 150  , y: self.frame.size.height/2 + 310)
    timerLabelNode.zPosition = 100
    timerLabelNode.fontSize = 65
    timerLabelNode.fontName = "MarkerFelt-Wide"
    self.addChild(timerLabelNode)
    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
 
    
    // PATH NODE
    for index in 1...3{
      bob = CreatePath.CreatePath(Int(RandomElements.randomPathVarYPosition(800, max: 1000))+index*50, yInitialPosition: (RandomElements.randomPathVarYPosition(180, max: Int(self.frame.height)-68)), width: (RandomElements.randomPathLength()!))
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
        
        runAction(SKAction.playSoundFileNamed("SquishFart.mp3", waitForCompletion: false))

        let difference = CGVectorMake(CGFloat((endLocation.x - startLocation.x) * -1), abs(endLocation.y - startLocation.y) * 1.6)
        //   let difference = CGVectorMake(0, abs(endLocation.y - startLocation.y) * 1.6)
        self.hotdog.physicsBody?.applyImpulse(difference)
      }
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    enumerateChildNodesWithName("gameBackground", usingBlock: { (node, stop) -> Void in
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