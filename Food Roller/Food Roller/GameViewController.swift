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
    sc = GameScene()
    sc.size = self.view.frame.size
    sc.scaleMode = .AspectFill
    sc.gameVC = self

    
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
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
    self.dismissViewControllerAnimated(true, completion: nil)

  }
  
  @IBAction func menuButtonAction(sender: UIButton) {
    // segue to menu
//    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
    sc.resetGame()
    sc.removeAllChildren()
    sc.removeAllActions()
    sc.removeFromParent()
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func retryButtonAction(sender: UIButton) {
//    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
    gameoverView.hidden = true;
    sc.resetGame()
    sc.retryGame()
  }
  
  @IBAction func shareButtonAction(sender: UIButton) {
//    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
    let score : String = sc.timerLabelNode.text!

//
    //Generate the screenshot
    UIGraphicsBeginImageContext(view.frame.size)
    let context: CGContextRef = UIGraphicsGetCurrentContext()!
    view.layer.renderInContext(context)
    
    let screenShot = self.view?.pb_takeSnapshot()

    
    socialShare(sharingText: "I just hit \(score) on Hotdog Slinger! Beat it!", sharingImage: screenShot)
  }
  
  func socialShare(sharingText sharingText: String?, sharingImage: UIImage?) {
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
    
      // Configure the view
      let skView = self.view as! SKView
//      skView.showsFPS = true
//      skView.showsNodeCount = true
      gameoverView.hidden = true
    
      
      /* Sprite Kit applies additional optimizations to improve rendering performance */
      skView.ignoresSiblingOrder = true
      /* Set the scale mode to scale to fit the window */
      skView.presentScene(sc)
    let previousHighScore = sc.currentHighScore
    highestScore.text = "\(previousHighScore)"
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
//  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//      return UIInterfaceOrientationMask.AllButUpsideDown.rawValue
//    } else {
//      return UIInterfaceOrientationMask.All.rawValue
//    }
//  }
//  override func supportedInterfaceOrientations() -> Int {
//    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//      return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
//    } else {
//      return Int(UIInterfaceOrientationMask.All.rawValue)
//    }
//  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      return UIInterfaceOrientationMask.AllButUpsideDown
    } else {
      return UIInterfaceOrientationMask.All
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

extension UIView {
  
  func pb_takeSnapshot() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)
    
    drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
    
    // old style: layer.renderInContext(UIGraphicsGetCurrentContext())
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
