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


  
class func playBackgroundMusic(filename: String) {
  if !AVAudioSession.sharedInstance().otherAudioPlaying {
    let url = NSBundle.mainBundle().URLForResource(
      filename, withExtension: nil)
    if (url == nil) {
      print("Could not find file: \(filename)")
      return
    }
    do {
    backgroundMusicPlayer = try
      AVAudioPlayer(contentsOfURL: url!)
    backgroundMusicPlayer.numberOfLoops = kBackgroundMusicLoop
    backgroundMusicPlayer.prepareToPlay()
    backgroundMusicPlayer.volume = musicVolume
    backgroundMusicPlayer.play()
    } catch {
      
    }
  }
}
  
  class func adjustVolume(musicVolume: Float){
    if let bmPlayer = backgroundMusicPlayer {
      bmPlayer.volume = musicVolume
    }
  }
}