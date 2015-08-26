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
  
  var bob = SKSpriteNode()
  
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
  
  override func didMoveToView(view: SKView) {
    gameOver = false
    BackgroundMusic.playBackgroundMusic("bensoundFunnysong.mp3")
    
    
    physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 250, y: 0, width: self.size.width - 500, height: self.size.height))

    
    self.physicsWorld.contactDelegate = self //Setting up physics world for contact with boundaries
      physicsWorld.gravity = CGVectorMake(0.0, -5.8)
    
    // loop through the background image
    for (var i : CGFloat = 0; i < 2; i++ ) {
      let bg = SKSpriteNode(imageNamed: "gameBackground")
      let groundTexture = SKTexture(imageNamed: "cactus")
      
      bg.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
      bg.anchorPoint = CGPointZero
      bg.position = CGPoint(x: i * bg.size.width, y: 0)
      bg.name = "gameBackground"
      addChild(bg)
      self.spikeNode = SKSpriteNode(texture: groundTexture)
      spikeNode.anchorPoint = CGPointZero
      spikeNode.position = CGPoint(x: i * spikeNode.size.width, y: -30 )
      let bottomBoundSize = CGSize(width: spikeNode.size.width + 200, height: spikeNode.size.height + 120)
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
    self.hotdog.size = CGSizeMake(self.frame.size.width / 16, self.frame.size.height / 8)
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
  
  //Mark: Game over function called when gameOver is true
  func gameIsOver () {
    spikeSpeed = 0
    backgroundSpeed = 0
    hotdog.paused = true
   
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
    
    if (bodyA == spikeNode.physicsBody && bodyB == hotdog.physicsBody) {
      println("collision2")
      gameOver = true
      gameIsOver()
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
    for bob in self.arrayOfPathsInGame{
      CreatePath.MovePathObject(bob)
    }
  }

  func updateTimer() {
    if !gameOver {
      timerCount++
      timerLabelNode.text = String(timerCount)
    }
  }
  
  func resetGame() {
    timerLabelNode.text = "0" // reset the timer
  }
  
}