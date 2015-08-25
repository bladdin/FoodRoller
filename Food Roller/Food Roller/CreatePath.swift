//
//  CreatePath.swift
//  Food Roller
//
//  Created by Mark Lin on 8/24/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

import Foundation
import SpriteKit

class CreatePath {
  
  class func CreatePath(xInitialPosition: Int, yInitialPosition: Int, width: Int) ->SKSpriteNode {
    
    let xPosition = CGFloat(xInitialPosition)
    let yPosition = CGFloat(yInitialPosition)
    let objectWidth = CGFloat(width)

    let objectPath = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(objectWidth, 20.0))
    objectPath.position.x = xPosition
    objectPath.position.y = yPosition
    objectPath.zPosition = CGFloat(kForeground)
    
    return objectPath
    
  }
  
  class func MovePathObject(object: SKSpriteNode){
    object.position.x = object.position.x - (kSpeedOfWorld) * (kParalaxMultiplyer)
  }
}
