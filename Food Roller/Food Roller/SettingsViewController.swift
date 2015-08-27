//
//  SettingsViewController.swift
//  Food Roller
//
//  Created by Cathy Oun on 8/25/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import UIKit

//keep for sound adjustment
//protocol SoundVolumeDelegate {
//}

class SettingsViewController: UIViewController {

//keep for sound adjustment
//  var musicVolume:Float = 0.0
//  var sfxVolume:Float = 0.0
//  var delegate: MenuViewController?
  
  @IBAction func MusicSlider(sender: UISlider) {
     musicVolume = sender.value
    BackgroundMusic.adjustVolume(musicVolume)
  }
  @IBOutlet weak var MusicSliderOutlet: UISlider!
  
  @IBAction func SFXSlider(sender: UISlider) {
     sfxVolume = sender.value
  }
  
  @IBOutlet weak var SFXSliderOutlet: UISlider!
  @IBOutlet weak var backgroundMusicLabel: UILabel!
  @IBOutlet weak var soundEffectLabel: UILabel!

  override func viewDidLoad() {
        super.viewDidLoad()
      self.MusicSliderOutlet.value = musicVolume
    self.SFXSliderOutlet.value = sfxVolume
      navigationController?.navigationBarHidden = false
      backgroundMusicLabel.text = "Background Music"
      soundEffectLabel.text = "Sound Effect"
      backgroundMusicLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 24)
      soundEffectLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 24)
    }

  override func viewWillDisappear(animated: Bool) {
//keep for sound adjustment
//    delegate?.musicVolume = musicVolume
//    delegate?.sfxVolume = sfxVolume
//    delegate = nil
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


