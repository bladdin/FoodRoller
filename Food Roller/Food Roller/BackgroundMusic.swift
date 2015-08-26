//
//  BackgroundMusic.swift
//  Food Roller
//
//  Created by Mark Lin on 8/26/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import AVFoundation

//Mark: BackgroundMusic
class BackgroundMusic{
  
  static var backgroundMusicPlayer: AVAudioPlayer!
  static var musicVolume: Float!
  static var sfxVolume: Float!

  
class func playBackgroundMusic(filename: String) {
  let url = NSBundle.mainBundle().URLForResource(
    filename, withExtension: nil)
  if (url == nil) {
    println("Could not find file: \(filename)")
    return
  }
  var error: NSError? = nil
  backgroundMusicPlayer =
    AVAudioPlayer(contentsOfURL: url, error: &error)
  if backgroundMusicPlayer == nil {
    println("Could not create audio player: \(error!)")
    return
  }
  backgroundMusicPlayer.numberOfLoops = -1
  backgroundMusicPlayer.prepareToPlay()
  backgroundMusicPlayer.play()
}
  
  class func adjustVolume(musicVolume: Float){
  backgroundMusicPlayer.volume = musicVolume
  }
}