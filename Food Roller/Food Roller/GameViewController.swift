//
//  GameViewController.swift
//  Food Roller
//
//  Created by Benjamin Laddin on 8/21/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit
import SpriteKit
import Social

extension SKNode {
  class func unarchiveFromFile(file : String) -> SKNode? {
    if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
      var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
      var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
      
      archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
      let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
      archiver.finishDecoding()
      return scene
    } else {
      return nil
    }
  }
}


class GameViewController: UIViewController {
  var gameoverView = UIView()
  let pauseImage = UIImage(named: "pause")
  @IBOutlet weak var highestScore: UILabel!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var pauseButton: UIButton!
  @IBOutlet weak var retryButton: UIButton!
  @IBOutlet weak var bunImageView: UIImageView!
  var sc : GameScene!

  override func viewDidLoad() {
    super.viewDidLoad()
    presentScene()
  }

  @IBAction func pauseButtonAction(sender: UIButton) {
    sc.gamePause()
  }
  
  @IBAction func backButtonAction(sender: UIButton) {
    sc.resetGame()
    sc.removeAllChildren()
    sc.removeAllActions()
    sc.removeFromParent()
  }
  
  @IBAction func menuButtonAction(sender: UIButton) {
    // segue to menu
    sc.resetGame()
    sc.removeAllChildren()
    sc.removeAllActions()
    sc.removeFromParent()
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func retryButtonAction(sender: UIButton) {
    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
    sc.resetGame()
    sc.removeAllChildren()
    sc.removeAllActions()
    sc.removeFromParent()
    
    presentScene()
  }
  
  @IBAction func shareButtonAction(sender: UIButton) {
    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
    var score : String = sc.timerLabelNode.text
//    let activityViewController = UIActivityViewController(activityItems: ["WOW! My Score on Hotdog Slinger is: " + score + "\nThis is AWESOME!\nTry Hotdog Slinger now and beat my score!"], applicationActivities: nil)
//    
    //Generate the screenshot
    UIGraphicsBeginImageContext(view.frame.size)
    let context: CGContextRef = UIGraphicsGetCurrentContext()
    view.layer.renderInContext(context)
    let screenShot: UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    var postImage = UIImage(named: "\(screenShot)")
    
    
    socialShare(sharingText: "I just hit \(score) on Hotdog Slinger! Beat it!", sharingImage: postImage)

//    self.presentViewController(activityViewController, animated: true, completion: nil)
  }
  
  func socialShare(#sharingText: String?, sharingImage: UIImage?) {
    var sharingItems = [AnyObject]()
    
    if let text = sharingText {
      sharingItems.append(text)
    }
    if let image = sharingImage {
      sharingItems.append(image)
    }
//    if let url = sharingURL {
//      sharingItems.append(url)
//    }
    
    let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
    activityViewController.excludedActivityTypes = [UIActivityTypeCopyToPasteboard,UIActivityTypeAirDrop,UIActivityTypeAddToReadingList,UIActivityTypeAssignToContact,UIActivityTypePostToTencentWeibo,UIActivityTypePostToVimeo,UIActivityTypePrint,UIActivityTypeSaveToCameraRoll,UIActivityTypePostToWeibo]
    self.presentViewController(activityViewController, animated: true, completion: nil)
  }
  
  func presentScene() {
      let scene = GameScene()
      // Configure the view.
      sc = scene
      let skView = self.view as! SKView
//      skView.showsFPS = true
//      skView.showsNodeCount = true
      gameoverView.hidden = true
      scene.size = self.view.frame.size
      
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true
      /* Set the scale mode to scale to fit the window */
      scene.scaleMode = .AspectFill
      scene.gameVC = self
      skView.presentScene(scene)
    var previousHighScore = sc.currentHighScore
    highestScore.text = "\(previousHighScore)"
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func supportedInterfaceOrientations() -> Int {
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
    } else {
      return Int(UIInterfaceOrientationMask.All.rawValue)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
