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
  class func randomPathVarYPosition(screenHeight : Int ) -> Int!{
    var random = RandomCaller.createsRandomNumber(kNumberOfRandoms)
    switch random {
    case krandomNumber1:
      return screenHeight / kPathPosition1Divider
    case krandomNumber2:
      return screenHeight / kPathPosition2Divider
    case krandomNumber3:
      return screenHeight / kPathPosition3Divider
    case krandomNumber4:
      return screenHeight / kPathPosition4Divider
    case krandomNumber5:
      return screenHeight / kPathPosition5Divider
    default:
      return nil
    }
  }
  
  //MARK: Random Path X Variable Position
  class func randomPathVarxPosition(widthVar : Int ) -> Int!{
    var random = RandomCaller.createsRandomNumber(kNumberOfRandoms)
    switch random {
    case krandomNumber1:
      return widthVar / kPathPosition1Divider
    case krandomNumber2:
      return widthVar / kPathPosition2Divider
    case krandomNumber3:
      return widthVar / kPathPosition3Divider
    case krandomNumber4:
      return widthVar / kPathPosition4Divider
    case krandomNumber5:
      return widthVar / kPathPosition5Divider
    default:
      return nil
    }
  }
}