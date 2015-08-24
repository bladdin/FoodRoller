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
    var randomNumber = Int(arc4random_uniform(UInt32(numberMax))+1)
    return randomNumber
  }
}