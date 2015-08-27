//
//  MenuViewController.swift
//  Food Roller
//
//  Created by Cathy Oun on 8/24/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

//keep for sound adjustment
//  var musicVolume: Float?
//  var sfxVolume: Float?
  
  let clickedStartButton = UIImage(named: "startClicked")
  let clickedSettingsButton = UIImage(named: "settingsClicked")
  let clickedHelpButton = UIImage(named: "helpClicked")
  
  @IBOutlet weak var startButtonOutlet: UIButton!
  @IBOutlet weak var settingsButtonOutlet: UIButton!
  @IBOutlet weak var helpButtonOutlet: UIButton!
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    BackgroundMusic.playBackgroundMusic("bensoundCute.mp3")

    startButtonOutlet.setImage(clickedStartButton, forState: UIControlState.Highlighted)
    settingsButtonOutlet.setImage(clickedSettingsButton, forState: UIControlState.Highlighted)
    helpButtonOutlet.setImage(clickedHelpButton, forState: UIControlState.Highlighted)


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
    //
    println(musicVolume)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  }

//keep for sound adjustment
//extension SettingsViewController: SoundVolumeDelegate {
//}

