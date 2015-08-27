//
//  GameScene.swift
//  Food Roller
//
//  Created by Benjamin Laddin on 8/21/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import SpriteKit
import Foundation


class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var hotdog = SKSpriteNode()
  var bun = SKSpriteNode()
  var bob = SKSpriteNode()
  var lastBob = SKSpriteNode()
  
  var startLocation = CGPoint()
  var endLocation = CGPoint()
  var spikeNode = SKSpriteNode()
  var gameVC : GameViewController!
  
  
  let hotdogCategory : UInt32    =  0x1 << 0;
  let killCategory : UInt32       =  0x1 << 1;
  let bobCategory  : UInt32  =  0x1 << 2;
  let sideboundsCategory : UInt32     =  0x1 << 3;
  
//  enum ColliderType : UInt32 {
//    case Hotdog = 1
//    case Cactus = 2
//    case Sidebounds = 3
//  }
  
  var arrayOfPathsInGame = [SKSpriteNode()]
  var timerLabelNode = SKLabelNode(text: "0")
  var timer = NSTimer()
  var timerCount = 0
  var lastFrameTime : Int!
  var changeInTime : Int!
  var timeSinceLastNode : Int!
  var nextPipeTime = 3
  var timerForPaths = NSTimer()
  var timerForPathsCount = 0
  
  
  override func didMoveToView(view: SKView) {
    gameStop = false
    self.speed = 0
    BackgroundMusic.playBackgroundMusic("bensoundFunnysong.mp3")
    
    // bounds
    physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: -5
      , y: 0, width: self.size.width + 10, height: self.size.height))
    
    physicsBody?.categoryBitMask = sideboundsCategory
    
    
    
    
    self.physicsWorld.contactDelegate = self //Setting up physics world for contact with boundaries
    physicsWorld.gravity = CGVectorMake(0.0, -5.8)
    
    // loop through the background image
    for (var i : CGFloat = 0; i < 2; i++ ) {
      let bg = SKSpriteNode(imageNamed: "gameBackground")
      let groundTexture = SKTexture(imageNamed: "cactus")
      
      bg.size = CGSize(width: 1024, height: 768)
      bg.anchorPoint = CGPointZero
      bg.position = CGPoint(x: i * bg.size.width, y: 0)
      bg.name = "gameBackground"
      addChild(bg)
      spikeNode = SKSpriteNode(texture: groundTexture)
      spikeNode.anchorPoint = CGPointZero
      spikeNode.position = CGPoint(x: i * spikeNode.size.width, y: -30 )
      let bottomBoundSize = CGSize(width: spikeNode.size.width, height: spikeNode.size.height + 130)
      spikeNode.physicsBody = nil
      println(frame.width)
      println(frame.height)
      hotdog.physicsBody?.dynamic = true
      spikeNode.name = "spikeBottom"
      addChild(spikeNode)
      println(spikeNode.position)
      //spikeNode.position = CGPoint(x: 0, y: 0)
      
    }
    
    let killZone = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width:size.width, height: spikeNode.size.height - 30))
    
    killZone.anchorPoint = CGPointZero
    killZone.position = CGPointZero
    
    killZone.physicsBody = SKPhysicsBody(rectangleOfSize: killZone.size, center: CGPoint(x: size.width / 2,y: killZone.size.height / 2 - 30))
    killZone.physicsBody?.categoryBitMask = killCategory
    killZone.physicsBody?.contactTestBitMask = hotdogCategory
    killZone.physicsBody?.collisionBitMask = 0
    //killZone.zPosition = 100
    killZone.physicsBody?.dynamic = false
    killZone.physicsBody?.affectedByGravity = false
    addChild(killZone)
  
    
    // HOTDOG NODE
    
    //    let hotdogTexture = SKTexture(imageNamed: "hotdog")
    var hotdogTexture1 = SKTexture(imageNamed: "1")
    var hotdogTexture2 = SKTexture(imageNamed: "2")
    var hotdogTexture3 = SKTexture(imageNamed: "3")
    var hotdogTexture4 = SKTexture(imageNamed: "4")
    var hotdogTexture5 = SKTexture(imageNamed: "5")
    var hotdogTexture6 = SKTexture(imageNamed: "6")
    
    
    self.hotdog = SKSpriteNode(texture: hotdogTexture1)
    self.hotdog.name = "hotdog"
    self.hotdog.size = CGSizeMake(self.frame.size.width / 7, self.frame.size.height / 7)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
    self.hotdog.physicsBody = SKPhysicsBody(circleOfRadius: self.hotdog.size.height / 2)
    self.hotdog.physicsBody?.affectedByGravity = false
    hotdog.physicsBody?.categoryBitMask = hotdogCategory //Sets collider type to raw value 1
    hotdog.physicsBody?.contactTestBitMask = killCategory
    hotdog.physicsBody?.collisionBitMask = sideboundsCategory | bobCategory
    
    var run = SKAction.animateWithTextures([hotdogTexture1, hotdogTexture2, hotdogTexture3, hotdogTexture4, hotdogTexture5, hotdogTexture6], timePerFrame: 0.12)
    var runForever = SKAction.repeatActionForever(run)
    hotdog.runAction(runForever)
    //      self.hotdog.physicsBody = SKPhysicsBody(circleOfRadius: self.hotdog.size.height / 2)
    self.addChild(self.hotdog)
    
    
    // TIMER:
    timerLabelNode.position = CGPoint(x: self.frame.size.width/2 + 135  , y: self.frame.size.height/2 + 270)
    timerLabelNode.zPosition = 100
    timerLabelNode.fontSize = 65
    timerLabelNode.fontName = "MarkerFelt-Wide"
    self.addChild(timerLabelNode)
    //    timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
    
    
    //MARK: Moves the Path Nodes Aka Bobs
    let distanceBobsMove = CGFloat(self.frame.width * 2 + (bob.frame.width * 2))
    let moveBobs = SKAction.moveByX(-distanceBobsMove, y: 0.0, duration: NSTimeInterval(0.01 * distanceBobsMove))
    let removeBobs = SKAction.removeFromParent()
    moveAndRemove = SKAction.sequence([moveBobs, removeBobs])
    
    
    //MARK: Spawns First Bob
    let firstBobspawn = SKAction.runBlock({() in self.spawnFirstBob()})
    let firstBobinitialSpawn = SKAction.sequence([firstBobspawn])
    self.runAction(firstBobinitialSpawn)
    
    
    //MARK: Spawns Path Nodes AKA Bobs
    let spawn = SKAction.runBlock({() in self.spawnBobs()})
    let delay = SKAction.waitForDuration(NSTimeInterval(2.0))
    let initialSpawn = SKAction.sequence([spawn, delay])
    let respawn = SKAction.repeatActionForever(initialSpawn)
    self.runAction(respawn)
    
    
  }
  func spawnFirstBob(){
    let bob = CreatePath.CreatePath(50, yInitialPosition: Int(spikeNode.frame.height) + 20, width: 5)
    CreatePath.MovePathObject(bob)
    self.addChild(bob)
    bob.runAction(moveAndRemove)
    bob.physicsBody?.categoryBitMask = bobCategory
    bob.physicsBody?.collisionBitMask = hotdogCategory
    lastBob = bob
    
  }
  
  func spawnBobs() {
    let bob = CreatePath.CreatePath(Int(RandomElements.randomPathVarYPosition(Int(self.frame.width * 1.5 ), max: Int(self.frame.width * 1.5) + 50 )), yInitialPosition: (RandomElements.randomPathVarYPosition(180, max: Int(self.frame.height)-68)), width: (RandomElements.randomPathLength()!))
    CreatePath.MovePathObject(bob)
    self.addChild(bob)
    bob.runAction(moveAndRemove)
    bob.physicsBody?.categoryBitMask = bobCategory
    bob.physicsBody?.collisionBitMask = hotdogCategory
    lastBob = bob
  }
  
  func gamePause() {
    
    if gameStop == false {
      gameStop = true
      spikeSpeed = 0
      backgroundSpeed = 0
      hotdog.paused = true
      hotdog.physicsBody?.resting = true
      hotdog.physicsBody?.affectedByGravity = false
      self.speed = 0
    } else {
      gameStop = false
      resumeSpeed()
    }
  }
  
  
  //Mark: Game over function called when gameOver is true
  func gameIsOver() {
    spikeSpeed = 0
    backgroundSpeed = 0
    gameStop = true
    self.speed = 0
    
    var dead = SKAction.animateWithTextures([deadHotdogTexture], timePerFrame: 1)
    self.hotdog.size = CGSize(width: 100, height: 85)
    self.hotdog.runAction(SKAction.repeatAction(dead, count: 1))
    gameVC.gameoverView.hidden = false
  }
  
  // Collision
  func didBeginContact(contact: SKPhysicsContact) {
    let bodyA = contact.bodyA
    let bodyB = contact.bodyB
    
    println(bodyA.categoryBitMask)
    println(bodyB.categoryBitMask)
    
    if bodyA.categoryBitMask == hotdogCategory || bodyB.categoryBitMask == hotdogCategory {
             BackgroundSFX.playBackgroundSFX("pain.mp3")
            println("collision2")
            gameIsOver()
    }
    
    
    
//    if (bodyA == spikeNode.physicsBody && bodyB == hotdog.physicsBody) || (bodyB == spikeNode.physicsBody && bodyA == hotdog.physicsBody) {
//       BackgroundSFX.playBackgroundSFX("pain.mp3")
//      println("collision2")
//      gameIsOver()
//      
//    } else {
////      println("bodyA: \(bodyA.description), bodyB: \(bodyB.description)")
    //}
  }
  
  func resumeSpeed() {
    spikeSpeed = 1
    backgroundSpeed = 1
    hotdog.paused = false
    hotdog.physicsBody?.resting = false
    hotdog.physicsBody?.affectedByGravity = true
    self.speed = 1
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if gameStop == true {
      gameStop = false
      resumeSpeed()
    }
    if gameStarted == false {
      self.speed = 1
      gameStarted = true
      timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
      }
    hotdog.physicsBody?.affectedByGravity = true
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
        
        BackgroundSFX.playBackgroundSFX("jump.mp3")

        let difference = CGVectorMake(CGFloat((endLocation.x - startLocation.x) * -1), abs(endLocation.y - startLocation.y) * 1.6)
        //   let difference = CGVectorMake(0, abs(endLocation.y - startLocation.y) * 1.6)
        self.hotdog.physicsBody?.applyImpulse(difference)
      }
    }
  }
  
  
  override func update(currentTime: CFTimeInterval) {
    enumerateChildNodesWithName("gameBackground", usingBlock: { (node, stop) -> Void in
      if let bg = node as? SKSpriteNode {
        bg.position = CGPoint(x: bg.position.x - backgroundSpeed , y: bg.position.y)
        if bg.position.x <= bg.size.width * -1 {
          bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
        }
      }
    })
    
    enumerateChildNodesWithName("spikeBottom", usingBlock: { (node, stop) -> Void in
      if let spike = node as? SKSpriteNode {
        spike.position = CGPoint(x: spike.position.x - spikeSpeed , y: spike.position.y)
        if spike.position.x <= spike.size.width * -1 {
          spike.position = CGPoint(x: spike.position.x + spike.size.width * 2, y: spike.position.y)
        }
      }
    })
    
    
  }
  
  func updateTimer() {
    if !gameStop {
      timerCount++
      timerLabelNode.text = String(timerCount)
    }
  }
  
  func resetGame() {
    backgroundSpeed = 1
    spikeSpeed = 1
    timerLabelNode.text = "0" // reset the timer
    gameStarted = false 
  }
  
  
  
}