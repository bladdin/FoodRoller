//
//  RandomCaller.swift
//  Food Roller
//
//  Created by Benjamin Laddin on 8/24/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import Foundation

class RandomCaller{
  class func createsRandomNumber(maxNumber: Int) -> Int{
    let numberMax = maxNumber
    let randomNumber = Int(arc4random_uniform(UInt32(numberMax))+1)
    return randomNumber
  }
  
  class func cratesRandomXandY(maxNumer: Int, minNumber: Int) ->Int{
    let newMinNumber = minNumber / kRandomXandYDivisorAndMultiplier
    let multiplier = (maxNumer - minNumber) / kRandomXandYDivisorAndMultiplier
    var randomNumber = Int(arc4random_uniform(UInt32(multiplier))+UInt32(newMinNumber))
    randomNumber = randomNumber * kRandomXandYDivisorAndMultiplier
    return randomNumber
  }
  
}