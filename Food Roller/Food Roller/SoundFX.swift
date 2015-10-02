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
  
  static var players: [AVAudioPlayer] = []
  static var backgroundSFXPlayer: AVAudioPlayer!
  
//  
  class func playBackgroundSFX(filename: String)  {
    if !AVAudioSession.sharedInstance().otherAudioPlaying {
    let url = NSBundle.mainBundle().URLForResource(
      filename, withExtension: nil)
    let availablePlayers = players.filter{(player) -> Bool in
      return player.playing == false && player.url == url}
    
    if let playerToUse = availablePlayers.first{
      playerToUse.numberOfLoops = 0
      playerToUse.volume = sfxVolume
      playerToUse.play()
      
      }
      do {
        if let url = url {
    let newPlayer = try AVAudioPlayer(contentsOfURL: url)
      players.append(newPlayer)
      newPlayer.numberOfLoops = 0
      newPlayer.volume = sfxVolume
      newPlayer.play()
        }
      } catch {
        
      }
    }
  }
  

  class func adjustVolume(sfxVolume: Float){
  //  println("sfxvol: \(sfxVolume)")
    players.map { (player) in
      player.volume = sfxVolume
    }
  }
  
}