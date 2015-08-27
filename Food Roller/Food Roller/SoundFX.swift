//
//  SoundFX.swift
//  Food Roller
//
//  Created by Mark Lin on 8/27/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import AVFoundation

//Mark: BackgroundSFX
class BackgroundSFX{
  
  static var backgroundSFXPlayer: AVAudioPlayer!
  
  class func playBackgroundSFX(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(
      filename, withExtension: nil)
    if (url == nil) {
      println("Could not find file: \(filename)")
      return
    }
    var error: NSError? = nil
    backgroundSFXPlayer =
      AVAudioPlayer(contentsOfURL: url, error: &error)
    if backgroundSFXPlayer == nil {
      println("Could not create audio player: \(error!)")
      return
    }
    backgroundSFXPlayer.numberOfLoops = -1
    backgroundSFXPlayer.prepareToPlay()
    backgroundSFXPlayer.volume = sfxVolume
    backgroundSFXPlayer.play()
  }
  
  class func adjustVolume(sfxVolume: Float){
    backgroundSFXPlayer.volume = sfxVolume
  }
}