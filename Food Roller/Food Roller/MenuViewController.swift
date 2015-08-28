//
//  MenuViewController.swift
//  Food Roller
//
//  Created by Cathy Oun on 8/24/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit
import AVFoundation

class MenuViewController: UIViewController {
  
  let clickedStartButton = UIImage(named: "startClicked")
  let clickedSettingsButton = UIImage(named: "settingsClicked")
  let clickedHelpButton = UIImage(named: "helpClicked")
  
  @IBOutlet weak var titleImageView: UIImageView!
  @IBOutlet weak var startButtonOutlet: UIButton!
  @IBOutlet weak var settingsButtonOutlet: UIButton!
  @IBOutlet weak var helpButtonOutlet: UIButton!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    if !AVAudioSession.sharedInstance().otherAudioPlaying {
      BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
      BackgroundMusic.playBackgroundMusic("bensoundCute.mp3")
    }
    

    startButtonOutlet.setImage(clickedStartButton, forState: UIControlState.Highlighted)
    settingsButtonOutlet.setImage(clickedSettingsButton, forState: UIControlState.Highlighted)
    helpButtonOutlet.setImage(clickedHelpButton, forState: UIControlState.Highlighted)
    
    
  }
  
//  func animation() {
//    var destLocation = CGPoint(x: 130, y: 28)
//    titleImageView.
//  }
  
  @IBAction func startButtonAction(sender: UIButton) {
    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
  }
  @IBAction func helpButtonAction(sender: UIButton) {
    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
  }
  
  @IBAction func settingsButton(sender: UIButton) {
    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
  }
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBarHidden = true
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SettingsViewController"{
      let controller = segue.destinationViewController as! SettingsViewController
      //keep for sound adjustment
      //      controller.delegate = self
    }
  }
  
  override func viewDidAppear(animated: Bool) {
   // println(musicVolume)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

//keep for sound adjustment
//extension SettingsViewController: SoundVolumeDelegate {
//}

