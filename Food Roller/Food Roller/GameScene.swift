//
//  GameScene.swift
//  Food Roller
//
//  Created by Benjamin Laddin on 8/21/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//
import SpriteKit
import Foundation
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
  var highscore = 0
  var currentHighScore = 0
  
  var hotdog = SKSpriteNode()
  var bob = SKSpriteNode()
  var lastBob = SKSpriteNode()
  
  var startLocation = CGPoint()
  var endLocation = CGPoint()
  var spikeNode = SKSpriteNode()
  var gameVC : GameViewController!
  
  let hotdogCategory : UInt32 = 0x1 << 0;
  let killCategory : UInt32 = 0x1 << 1;
  let bobCategory  : UInt32 = 0x1 << 2;
  let sideboundsCategory : UInt32 = 0x1 << 3;
  
  var arrayOfPathsInGame = [SKSpriteNode()]
  var timerLabelNode = SKLabelNode(text: "0")
  var timer = NSTimer()
  var timerCount = 0
  var lastFrameTime : Int!
  var changeInTime : Int!
  var timeSinceLastNode : Int!
  var nextPipeTime = 3
  var difficultyTimer = NSTimer()
  var nodeTimer = NSTimer()
  var gravityMagnitude : CGFloat = -9.8
  var moveBobs: SKAction?
  
  //Mark: DidMoveToView initial screen
  override func didMoveToView(view: SKView) {
    //Mark: Loading high score
    if let loadHighScore = userDefaults.valueForKey("highscore") as? Int {
      currentHighScore = loadHighScore
    } else {
      currentHighScore = 0
    }
    
    gameStop = false
    self.speed = 0
    BackgroundMusic.playBackgroundMusic("bensoundFunnysong.mp3")
    
    //Mark: World set up physics body
    physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: -300, y: 0, width: self.size.width + 310, height: self.size.height + 500))
    physicsBody?.categoryBitMask = sideboundsCategory
    self.physicsWorld.contactDelegate = self //Setting up physics world for contact with boundaries
    physicsWorld.gravity = CGVectorMake(0.0, gravityMagnitude)
    
    //Mark: Creating and looping through background and cactus images.
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
      hotdog.physicsBody?.dynamic = true
      spikeNode.name = "spikeBottom"
      addChild(spikeNode)
    }
    
    //Mark: Killzone Boundary
    let killZone = SKSpriteNode(color: UIColor.redColor(), size: CGSize(width:size.width, height: spikeNode.size.height - 30))
    
    killZone.anchorPoint = CGPointZero
    killZone.position = CGPointZero
    killZone.physicsBody = SKPhysicsBody(rectangleOfSize: killZone.size, center: CGPoint(x: size.width / 2,y: killZone.size.height / 2 - 30))
    killZone.physicsBody?.categoryBitMask = killCategory
    killZone.physicsBody?.contactTestBitMask = hotdogCategory
    killZone.physicsBody?.collisionBitMask = 0
    killZone.physicsBody?.dynamic = false
    killZone.physicsBody?.affectedByGravity = false
    addChild(killZone)
    
    
    // HOTDOG NODE
    var hotdogTexture1 = SKTexture(imageNamed: "1")
    var hotdogTexture2 = SKTexture(imageNamed: "2")
    var hotdogTexture3 = SKTexture(imageNamed: "3")
    var hotdogTexture4 = SKTexture(imageNamed: "4")
    var hotdogTexture5 = SKTexture(imageNamed: "5")
    var hotdogTexture6 = SKTexture(imageNamed: "6")
    
    
    self.hotdog = SKSpriteNode(texture: hotdogTexture1)
    self.hotdog.name = "hotdog"
    self.hotdog.size = CGSizeMake(self.frame.size.width / 8, self.frame.size.height / 8)
    self.hotdog.zPosition = 100
    self.hotdog.position = CGPoint(x: self.frame.size.width / 2 , y: self.frame.size.height / 2)
//    self.hotdog.physicsBody = SKPhysicsBody(texture: hotdogTexture1, size: self.hotdog.size)
    self.hotdog.physicsBody = SKPhysicsBody(circleOfRadius: self.hotdog.size.width / 2 )
    self.hotdog.physicsBody?.affectedByGravity = false
    hotdog.physicsBody?.categoryBitMask = hotdogCategory //Sets collider type to raw value 1
    hotdog.physicsBody?.contactTestBitMask = killCategory
    hotdog.physicsBody?.collisionBitMask = sideboundsCategory | bobCategory
    
    var run = SKAction.animateWithTextures([hotdogTexture1, hotdogTexture2, hotdogTexture3, hotdogTexture4, hotdogTexture5, hotdogTexture6], timePerFrame: 0.12)
    var runForever = SKAction.repeatActionForever(run)
    hotdog.runAction(runForever)
    self.addChild(self.hotdog)
    
    //Mark: Time Label Node
    timerLabelNode.position = CGPoint(x: self.frame.size.width/2 , y: 7*self.frame.size.height/8)
    timerLabelNode.zPosition = 100
    timerLabelNode.fontSize = 65
    timerLabelNode.fontName = "MarkerFelt-Wide"
    self.addChild(timerLabelNode)
    
    //MARK: Moves the Path Nodes AKA Bobs
    let distanceBobsMove = CGFloat(self.frame.width * 2 + (bob.frame.width * 2))
    moveBobs = SKAction.moveByX(-distanceBobsMove, y: 0.0, duration: NSTimeInterval(nodeSpeed * distanceBobsMove))
    let removeBobs = SKAction.removeFromParent()
    moveAndRemove = SKAction.sequence([moveBobs!, removeBobs])
    
    
    //MARK: Spawns Path Nodes AKA Bobs
    let spawn = SKAction.runBlock({() in self.spawnBobs()})
    let delay = SKAction.waitForDuration(NSTimeInterval(3))
    
    //let delay = SKAction.waitForDuration(NSTimeInterval(2))
    
    
    let initialSpawn = SKAction.sequence([spawn, delay])
    let respawn = SKAction.repeatActionForever(initialSpawn)
    self.runAction(respawn)
  }
  
  //Mark: Pathway spawning AKA Bobs
  func spawnBobs() {
    let bob = CreatePath.CreatePath(Int(RandomElements.randomPathVarYPosition(Int(self.frame.width * 1.5 ), max: Int(self.frame.width * 1.5) + 50 )), yInitialPosition: (RandomElements.randomPathVarYPosition(180, max: Int(self.frame.height)-68)), width: (RandomElements.randomPathLength()!))
    CreatePath.MovePathObject(bob)
    self.addChild(bob)
    bob.runAction(moveAndRemove)
    bob.physicsBody?.categoryBitMask = bobCategory
    bob.physicsBody?.collisionBitMask = hotdogCategory
    lastBob = bob
  }
  
  //Mark: Game Pause Function
  func gamePause() {
    if gameStop == false {
      gameStop = true
      gameOver = false
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
  
  
  //Mark: Game Over Function
  func gameIsOver() {
    
    BackgroundMusic.playBackgroundMusic("bensoundcreepy.mp3")
    highscore = timerCount
    if highscore > currentHighScore {
      currentHighScore = highscore
      userDefaults.setValue(highscore, forKey: "highscore")
      userDefaults.synchronize()
      println(currentHighScore)
    }
    spikeSpeed = 0
    backgroundSpeed = 0
    gameStop = true // pause the timer
    gameOver = true // allow user to keep playing with the dead hotdog
    self.speed = 0 // stop the path
    
    // show dead hotdog
    var dead = SKAction.animateWithTextures([deadHotdogTexture], timePerFrame: 1)
    self.hotdog.size = CGSize(width: 100, height: 85)
    self.hotdog.runAction(SKAction.repeatAction(dead, count: 1))
    gameVC.pauseButton.enabled = false
    gameVC.backButton.enabled = false
    gameVC.gameoverView.hidden = false
    difficultyTimer.invalidate()
    nodeTimer.invalidate()
  }
  
  //Mark: Collision Detection didBeginContact
  func didBeginContact(contact: SKPhysicsContact) {
    let bodyA = contact.bodyA
    let bodyB = contact.bodyB
    
    if bodyA.categoryBitMask == hotdogCategory || bodyB.categoryBitMask == hotdogCategory {
      
      if flag == true{
        BackgroundSFX.playBackgroundSFX("pain.mp3")
        flag = false}
      gameIsOver()
    }
  }
  
  //Mark: Game Resume function
  func resumeSpeed() {
    spikeSpeed = 1
    backgroundSpeed = 1
    hotdog.paused = false
    hotdog.physicsBody?.resting = false
    hotdog.physicsBody?.affectedByGravity = true
    self.speed = 1
  }
  
  //Mark: TouchesBegan
  //Touch drag start detection for slingshot action
  //Starts the game when user interacts with game screen
  //Initializes timers for the games when it starts.
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if (gameStop == true) && (gameOver == false) {
      // pausing the game and get back to the game
      gameStop = false
      resumeSpeed()
    } else if (gameOver == true) && (gameStop == true){
      // this allows user to play with dead hotdog
      hotdog.physicsBody?.resting = false
    }
    gameVC.backButton.enabled = false
    if gameStarted == false {
      self.speed = 1
      gameStarted = true
      nodeTimer = NSTimer.scheduledTimerWithTimeInterval(timeForDifficultyIncrease, target: self, selector: "nodeSpeedTimer", userInfo: nil, repeats: true)
      
      timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
    }
    hotdog.physicsBody?.affectedByGravity = true
    for touch in touches {
      if let touch = touch as? UITouch {
        startLocation = touch.locationInNode(self)
      }
    }
    
  }
  
  //Mark: Touch end detection, Force Vector created
  override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    for touch in touches {
      if let touch = touch as? UITouch {
        endLocation = touch.locationInNode(self)
        BackgroundSFX.playBackgroundSFX("jump.mp3")
        
        let difference = CGVectorMake(CGFloat((endLocation.x - startLocation.x) * -1), abs(endLocation.y - startLocation.y) * 0.5)
        self.hotdog.physicsBody?.applyImpulse(difference)
      }
    }
  }
  
  //Mark: Update screen function
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
    // if the hotdog goes off screen too far away, end the game
    if ((hotdog.position.x) < -100) || ((hotdog.position.y) > self.frame.height + 250 ) {
      gameIsOver()
    }
  }
  
  //Mark: Timer counter
  func updateTimer() {
    if !gameStop {
      timerCount++
      timerLabelNode.text = String(timerCount)
    }
  }
  
  //Mark: Reset game function
  func resetGame() {
    backgroundSpeed = 1
    spikeSpeed = 1
    timerLabelNode.text = "0" // reset the timer
    gameStarted = false
    gameVC.pauseButton.enabled = true
    gameVC.backButton.enabled = true
    flag = true
    gameVC.highestScore.text = "\(currentHighScore)"
    nodeTimer.invalidate()
    difficultyTimer.invalidate()
    timer.invalidate()
    timeForDifficultyIncrease = 3;
  }
  
  func nodeSpeedTimer() {

    self.speed = self.speed + 0.5
   // gravityMagnitude -= CGFloat(3.0)
    physicsWorld.gravity = CGVectorMake(0.0, gravityMagnitude)
    timeForDifficultyIncrease = timeForDifficultyIncrease + 0.5
    difficultyTimer = NSTimer.scheduledTimerWithTimeInterval(timeForDifficultyIncrease, target: self, selector: "nodeSpeed2Timer", userInfo: nil, repeats: true)
    nodeTimer.invalidate()
  }
  
  func nodeSpeed2Timer() {
    self.speed = self.speed + 0.5
    gravityMagnitude -= CGFloat(3.0)
    physicsWorld.gravity = CGVectorMake(0.0, gravityMagnitude)
    timeForDifficultyIncrease = timeForDifficultyIncrease + 0.5
    nodeTimer = NSTimer.scheduledTimerWithTimeInterval(timeForDifficultyIncrease, target: self, selector: "nodeSpeedTimer", userInfo: nil, repeats: true)
    difficultyTimer.invalidate()
  }
}