//
//  RandomElements.swift
//  Food Roller
//
//  Created by Benjamin Laddin on 8/24/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import Foundation
import SpriteKit


class RandomElements{
  
  //MARK: Random Path Length
  class func randomPathLength() -> Int?{
    var random = RandomCaller.createsRandomNumber(kNumberOfRandoms)
    switch random {
    case krandomNumber1:
      return kPath1Length
    case krandomNumber2:
      return kPath2Length
    case krandomNumber3:
      return kPath3Length
    case krandomNumber4:
      return kPath4Length
    case krandomNumber5:
      return kPath5Length
    default:
      return nil
    }
  }
  //MARK: Random Path Y Variable Position
  class func randomPathVarYPosition(min : Int, max : Int ) -> Int!{
    var random = RandomCaller.cratesRandomXandY(max, minNumber: min)
    return random
  }
}