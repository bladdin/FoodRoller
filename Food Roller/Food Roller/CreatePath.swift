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

    let objectPath = SKSpriteNode(imageNamed: "Block\(width).png")
    objectPath.position.x = xPosition
    //println("objectPath xposition: \(xPosition)")
    objectPath.position.y = yPosition
    objectPath.zPosition = CGFloat(kForeground)
    objectPath.physicsBody = SKPhysicsBody(rectangleOfSize: objectPath.size)
    objectPath.physicsBody?.affectedByGravity = false
    objectPath.physicsBody?.dynamic = false
    return objectPath
  }
  
  class func MovePathObject(object: SKSpriteNode){
    object.position.x = object.position.x - (backgroundSpeed) * (kParalaxMultiplyer)
  }
}
