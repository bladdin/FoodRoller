//
//  SettingsViewController.swift
//  Food Roller
//
//  Created by Cathy Oun on 8/25/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit


  let userDefaults = NSUserDefaults.standardUserDefaults()
class SettingsViewController: UIViewController {

  
  @IBAction func MusicSlider(sender: UISlider) {
     musicVolume = sender.value
    BackgroundMusic.adjustVolume(musicVolume)
  }
  @IBOutlet weak var MusicSliderOutlet: UISlider!
  
  @IBAction func SFXSlider(sender: UISlider) {
    
    sfxVolume = sender.value
    BackgroundSFX.adjustVolume(sfxVolume)
    BackgroundSFX.playBackgroundSFX("SquishFart.mp3")
  }
  
  @IBOutlet weak var SFXSliderOutlet: UISlider!
  @IBOutlet weak var backgroundMusicLabel: UILabel!
  @IBOutlet weak var soundEffectLabel: UILabel!

  override func viewDidLoad() {
        super.viewDidLoad()
    SFXSliderOutlet.continuous = false
      self.MusicSliderOutlet.value = musicVolume
    self.SFXSliderOutlet.value = sfxVolume
      navigationController?.navigationBarHidden = false
      backgroundMusicLabel.text = "Background Music"
      soundEffectLabel.text = "Sound Effect"
      backgroundMusicLabel.font = UIFont(name: "ChalkboardSE-Regular", size: CGFloat(kBackgroundLabelSize))
      soundEffectLabel.font = UIFont(name: "ChalkboardSE-Regular", size: CGFloat(kSoundEffectsLabelSize))
    }

  override func viewWillDisappear(animated: Bool) {
    userDefaults.setObject(musicVolume, forKey: "initialMusic")
    userDefaults.setObject(sfxVolume, forKey: "initialSFX")
    
  }
}


