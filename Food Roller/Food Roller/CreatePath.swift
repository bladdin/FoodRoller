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
    
//    var BlocksInBigBlock = [SKSpriteNode]()
//    var i = CGFloat(0)
    
//    for number in 1...numberOfBlocksNeeded {
//     let oneBlock = SKSpriteNode(imageNamed: "indivudualBlock")
//     oneBlock.position.x = xPosition + (i * oneBlock.frame.size.width)
//     oneBlock.position.y = yPosition
//     BlocksInBigBlock.append(oneBlock)
//      i++
//    }
//
  }
}
