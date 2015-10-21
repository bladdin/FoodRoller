//
//  GlobalVariables.swift
//  Food Roller
//
//  Created by Sau Chung Loh on 8/26/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import AVFoundation
import SpriteKit

// hot dog textures

var hotdogBun = SKTexture(imageNamed: "bun")
var deadHotdogTexture = SKTexture(imageNamed: "deadHotDog")

var backgroundSpeed : CGFloat = 1
var spikeSpeed : CGFloat = 1
var gameStop = false
var gameStarted = false
var gameOver = false
var hitCactus = true
var bobWidth : Int!
var lastBob :SKSpriteNode!
var bobMinStart : Int!
var bobMaxStart : Int!
var moveAndRemove : SKAction!
var musicPlayer : AVAudioPlayer!
//var timeForDifficultyIncrease : NSTimeInterval = 10


var timeForDifficultyIncrease : NSTimeInterval = 3

var nodeSpeed:CGFloat = 0.01
var musicVolume:Float = 0.3
var sfxVolume: Float = 0.05
 