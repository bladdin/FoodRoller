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
  
  var bob = SKSpriteNode()
  var lastBob = SKSpriteNode()
  
  var startLocation = CGPoint()
  var endLocation = CGPoint()
  
  var spikeNode = SKSpriteNode()
  
  
  enum ColliderType : UInt32 {
    case Hotdog = 1
    case Cactus = 2
    case Sidebounds = 3
  }

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
  var diffiultyTimer = NSTimer()
  var nodeTimer = NSTimer()
  var gravityMagnitude : CGFloat = -9.8
  var moveBobs: SKAction?
  
  override func didMoveToView(view: SKView) {
    gameOver = false
    BackgroundMusic.playBackgroundMusic("bensoundFunnysong.mp3")
    
    // bounds
    physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: -5
      , y: 0, width: self.size.width + 10, height: self.size.height))

    
//    let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "doSomething", userInfo: nil, repeats: true)
    
    self.physicsWorld.contactDelegate = self //Setting up physics world for contact with boundaries
      physicsWorld.gravity = CGVectorMake(0.0, gravityMagnitude)
    

    
    // loop through the background image
    for (var i : CGFloat = 0; i < 2; i++ ) {
      let bg = SKSpriteNode(imageNamed: "gameBackground")
      let groundTexture = SKTexture(imageNamed: "cactus")
      
      bg.size = CGSize(width: 1024, height: 768)
      bg.anchorPoint = CGPointZero
      bg.position = CGPoint(x: i * bg.size.width, y: 0)
      bg.name = "gameBackground"
      addChild(bg)
      self.spikeNode = SKSpriteNode(texture: groundTexture)
      spikeNode.anchorPoint = CGPointZero
      spikeNode.position = CGPoint(x: i * spikeNode.size.width, y: -30 )
      let bottomBoundSize = CGSize(width: spikeNode.size.width, height: spikeNode.size.height + 130)
      spikeNode.physicsBody = SKPhysicsBody(rectangleOfSize: bottomBoundSize)
      
      spikeNode.physicsBody!.affectedByGravity = false
      spikeNode.physicsBody!.dynamic = false
      spikeNode.physicsBody!.categoryBitMask = ColliderType.Cactus.rawValue
      spikeNode.physicsBody!.contactTestBitMask = ColliderType.Hotdog.rawValue
      spikeNode.physicsBody!.collisionBitMask = ColliderType.Hotdog.rawValue
      
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
    self.hotdog.name = "hotdog"
    self.hotdog.size = CGSizeMake(self.frame.size.width / 7, self.frame.size.height / 7)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
    self.hotdog.physicsBody = SKPhysicsBody(circleOfRadius: self.hotdog.size.height / 2)
    hotdog.physicsBody!.affectedByGravity = false
  //  self.hotdog.physicsBody = SKPhysicsBody(rectangleOfSize: self.hotdog.size)
    self.hotdog.physicsBody?.categoryBitMask = ColliderType.Hotdog.rawValue //Sets collider type to raw value 1
    self.hotdog.physicsBody?.contactTestBitMask = ColliderType.Cactus.rawValue
    self.hotdog.physicsBody?.collisionBitMask = ColliderType.Cactus.rawValue

    
    
    
    var run = SKAction.animateWithTextures([hotdogTexture1, hotdogTexture2, hotdogTexture3, hotdogTexture4, hotdogTexture5, hotdogTexture6], timePerFrame: 0.12)
    var runForever = SKAction.repeatActionForever(run)
    self.hotdog.runAction(runForever)
//      self.hotdog.physicsBody = SKPhysicsBody(circleOfRadius: self.hotdog.size.height / 2)
    self.addChild(self.hotdog)
    
    
    // TIMER:
    timerLabelNode.position = CGPoint(x: self.frame.size.width/2 + 135  , y: self.frame.size.height/2 + 270)
    timerLabelNode.zPosition = 100
    timerLabelNode.fontSize = 65
    timerLabelNode.fontName = "MarkerFelt-Wide"
    self.addChild(timerLabelNode)
    timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
    
    
    
    nodeTimer = NSTimer.scheduledTimerWithTimeInterval(timeForDifficultyIncrease, target: self, selector: "nodeSpeedTimer", userInfo: nil, repeats: true)
    //MARK: Moves the Path Nodes Aka Bobs
    let distanceBobsMove = CGFloat(self.frame.width * 2 + (bob.frame.width * 2))
    //If 30 second interval is reached timer % 30 == 0
    //update speed 0.
    //
   
    moveBobs = SKAction.moveByX(-distanceBobsMove, y: 0.0, duration: NSTimeInterval(nodeSpeed * distanceBobsMove))
    //println("node speed: \(nodeSpeed)")
    let removeBobs = SKAction.removeFromParent()
    moveAndRemove = SKAction.sequence([moveBobs!, removeBobs])
    
    
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
    lastBob = bob

  }
  
  func spawnBobs() {
    let bob = CreatePath.CreatePath(Int(RandomElements.randomPathVarYPosition(Int(self.frame.width * 1.5 ), max: Int(self.frame.width * 1.5) + 50 )), yInitialPosition: (RandomElements.randomPathVarYPosition(180, max: Int(self.frame.height)-68)), width: (RandomElements.randomPathLength()!))
    CreatePath.MovePathObject(bob)
    self.addChild(bob)
    bob.runAction(moveAndRemove)
    lastBob = bob
  }

  
  //Mark: Game over function called when gameOver is true
  func gameIsOver () {
    spikeSpeed = 0
    backgroundSpeed = 0
    hotdog.paused = true
   
    
    self.speed = 0.0
    let gameOverScreen = SKView()
    gameOverScreen.frame = CGRect(x: self.view!.frame.width / 2, y: self.view!.frame.size.height / 2, width: 100, height: 100)
    gameOverScreen.backgroundColor = UIColor.blackColor()
    gameOverScreen.alpha = 0
    self.view?.addSubview(gameOverScreen)
    SKView.animateWithDuration(1.0, animations: { () -> Void in
      gameOverScreen.alpha = 1
    })
    
    
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    let bodyA = contact.bodyA
    let bodyB = contact.bodyB
    
    if (bodyA == spikeNode.physicsBody && bodyB == hotdog.physicsBody) || (bodyB == spikeNode.physicsBody && bodyA == hotdog.physicsBody) {
      //println("collision2")
//      println("bodyA: \(bodyA.description), bodyB: \(bodyB.description)")
      gameOver = true
      gameIsOver()
    } else {
//      println("bodyA: \(bodyA.description), bodyB: \(bodyB.description)")
    }
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
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
    if !gameOver {
      timerCount++
      timerLabelNode.text = String(timerCount)
    }
  }
  
  func resetGame() {
    timerLabelNode.text = "0" // reset the timer
    timeForDifficultyIncrease = 10
  }

  func nodeSpeedTimer() {
//    println("currentSpeed: \(nodeSpeed)")
//    nodeSpeed = nodeSpeed - 0.01
//    let distanceBobsMove = CGFloat(self.frame.width * 2 + (bob.frame.width * 2))
//    moveBobs = SKAction.moveByX(-distanceBobsMove, y: 0.0, duration: NSTimeInterval(nodeSpeed * distanceBobsMove))
//    let removeBobs = SKAction.removeFromParent()
//    moveAndRemove = SKAction.sequence([moveBobs!, removeBobs])
//    println("updatedNodeSpeed: \(nodeSpeed) \n")
    self.speed = self.speed + 1.75
    gravityMagnitude -= CGFloat(5.0)
    physicsWorld.gravity = CGVectorMake(0.0, gravityMagnitude)
    timeForDifficultyIncrease = timeForDifficultyIncrease + 1
    diffiultyTimer = NSTimer.scheduledTimerWithTimeInterval(timeForDifficultyIncrease, target: self, selector: "nodeSpeed2Timer", userInfo: nil, repeats: true)
    nodeTimer.invalidate()
  }
  
  func nodeSpeed2Timer() {
    self.speed = self.speed + 1.75
    gravityMagnitude -= CGFloat(5.0)
    physicsWorld.gravity = CGVectorMake(0.0, gravityMagnitude)
    timeForDifficultyIncrease = timeForDifficultyIncrease + 1
    nodeTimer = NSTimer.scheduledTimerWithTimeInterval(timeForDifficultyIncrease, target: self, selector: "nodeSpeedTimer", userInfo: nil, repeats: true)
    diffiultyTimer.invalidate()
  }

  
}