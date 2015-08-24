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
    var random = Int(arc4random_uniform(5)+1)
    if random == 1{
      return kPath1Length
    }else if random == 2{
      return kPath2Length
    }else if random == 3{
      return kPath3Length
    }else if random == 4{
      return kPath4Length
    }else if random == 5{
      return kPath5Length
    }
    else{
      return nil
    }
    }
  //MARK: Random Path Y Variable Position
  class func randomPathVarYPosition(screenHeight : Int ) -> Int!{
    var random = Int(arc4random_uniform(5)+1)
    if random == 1{
      return screenHeight / kPathPosition1Divider
    }else if random == 2{
      return screenHeight / kPathPosition2Divider
    }else if random == 3{
      return screenHeight / kPathPosition3Divider
    }else if random == 4{
      return screenHeight / kPathPosition4Divider
    }else if random == 5{
      return screenHeight / kPathPosition5Divider
    }
    else{
      return nil
    }
  }
  
  //MARK: Random Path X Variable Position
  class func randomPathVarxPosition(widthVar : Int ) -> Int!{
    var random = Int(arc4random_uniform(5)+1)
    if random == 1{
      return widthVar / kPathPosition1Divider
    }else if random == 2{
      return widthVar / kPathPosition2Divider
    }else if random == 3{
      return widthVar / kPathPosition3Divider
    }else if random == 4{
      return widthVar / kPathPosition4Divider
    }else if random == 5{
      return widthVar / kPathPosition5Divider
    }
    else{
      return nil
    }
  }
}