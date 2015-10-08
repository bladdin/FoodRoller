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
    return RandomCaller.createsRandomNumber(5)
//    switch random {
//    case 1:
//      return 1
//    case 2:
//      return 2
//    case 3:
//      return kPath3Length
//    case 4:
//      return kPath4Length
//    case 5:
//      return kPath5Length
//    default:
//      return nil
//    }
  }
  //MARK: Random Path Y Variable Position
  class func randomPathVarYPosition(min : Int, max : Int ) -> Int!{
    return RandomCaller.cratesRandomXandY(max, minNumber: min)
  }
}