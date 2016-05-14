//
//  Swipe.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/23/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import Foundation
import SpriteKit
class primeSwipe: SKSpriteNode{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //base
    var attackSwipe: SKSpriteNode = SKSpriteNode(imageNamed: "attack3.png")
    var dodgeSwipe: SKSpriteNode = SKSpriteNode(imageNamed: "dodge3.png")
    
    var leftArrow: SKSpriteNode = SKSpriteNode(imageNamed: "baseChoicesL.png")
    var rightArrow: SKSpriteNode = SKSpriteNode(imageNamed: "baseChoicesR.png")
    
    
    var highEnemyKilled: Bool = false
    var midEnemyKilled: Bool = false
    var lowEnemyKilled: Bool = false
    
    var special1Unlocked: Bool = false
    var special2Unlocked: Bool = false
    var special3Unlocked: Bool = false
    
    
    init(imageNamed: String) {
        let imageText =  SKTexture(imageNamed: imageNamed)
        super.init(texture: imageText, color:UIColor.redColor(), size: imageText.size())
        self.alpha = 0.9
    }
    func setUpChoices() {
        
        createSprite(attackSwipe, andWithPosition: CGPointMake(80, 0.0), andWithZPosition: 5.0, andWithString: "aSwipe", andWithSize: 4.0, andWithParent: self)
        createSprite(dodgeSwipe, andWithPosition: CGPointMake(-95, 0.0), andWithZPosition: 5.0, andWithString: "eSwipe", andWithSize: 4.0, andWithParent: self)

        createSprite(leftArrow, andWithPosition: CGPointMake(0.0, 0.0), andWithZPosition: 5.0, andWithString: "LSwipe", andWithSize: 4.0, andWithParent: self)
        createSprite(rightArrow, andWithPosition: CGPointMake(0.0, 0.0), andWithZPosition: 5.0, andWithString: "RSwipe", andWithSize: 4.0, andWithParent: self)
        
         
        
    }
    
    func swipeStateC(currentSwipeState: swipeState) {

    }
    func createSprite(withSprite:SKSpriteNode, andWithPosition aPosition:CGPoint, andWithZPosition zPos: CGFloat, andWithString theString: String, andWithSize aSize: CGFloat, andWithParent parent: AnyObject) {
        withSprite.position = aPosition
        withSprite.zPosition = zPos
        withSprite.name = theString
        
        withSprite.size = CGSizeMake(withSprite.size.width * aSize, withSprite.size.height * aSize)
        withSprite.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        
        parent.addChild(withSprite)
    }

}