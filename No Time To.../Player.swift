//
//  Player.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/23/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//


import Foundation
import SpriteKit
class Player: SKSpriteNode{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let weaponSlime: Int = 2
    let weaponDagger: Int = 1
    
    var Health: Float = 100
    var maxHealth: Float = 100
    var currentX: Int = 0
    var currentY: Int = 0
    var Strength: Float = 100
    
    var isFacing: UInt8 = RIGHT
    var currentWeapon: Int = 2
    var speedCount: Int = 1
    
    var type: UInt8 = SWORDSMAN
    
    var walkLeft:SKAction = SKAction()
    var walkRight:SKAction = SKAction()
    var walkUp:SKAction = SKAction()
    var walkDown:SKAction = SKAction()
    var swing: SKAction = SKAction()
    
    var isDefending: Bool = false
    var isGreatlyDefending: Bool = false
    
    var isCharging: Bool = false
    
    var canStrike: Bool = true
    
    let HP_bar: ProgressBar = ProgressBar(imageNamed: "black.png")
    
    var startPosition: CGPoint = CGPointZero

    init(imageNamed: String) {
        let imageText =  SKTexture(imageNamed: imageNamed)
        super.init(texture: imageText, color:UIColor.redColor(), size: imageText.size())
 
        if(Health == 0){
            Health = 100
        }
        if(currentWeapon == 0){
            currentWeapon = 2
        }
        speedCount = 2

  
        
        self.setUpAnimation()
        self.setUpHealth()
        
        self.texture!.filteringMode = SKTextureFilteringMode.Nearest
    }
    func finish(){
        let def=NSUserDefaults()
        def.setInteger(currentWeapon, forKey: "currentWeapon")
        def.setFloat(Health, forKey: "Health")
    }
    
    func setUpHealth(){
        Health = 100.0
        Strength = 35
        self.createSprite(HP_bar, andWithPosition: CGPointMake(0, (self.frame.size.height)+20), andWithZPosition: 10, andWithString: "HP", andWithSize: 4, andWithParent: self)
        HP_bar.createBar(75, andHeight: 15.0, andType: playerHealth)
    }
    func doDamage( damage:Float, isEnemyDeadly: Bool)->Bool{
        var damage2: Float = damage/2
        if(isDefending == true){
            if(isGreatlyDefending == true){
                print("GREatly defended")
            }else{
                print("poorly defended")
                //damage2 = damage2
                self.color = UIColor.redColor()
                self.runAction(
                    SKAction.repeatAction(
                    SKAction.sequence([
                        SKAction.colorizeWithColorBlendFactor(0.75, duration: 0.1), SKAction.colorizeWithColorBlendFactor(0.0, duration: 0.1)
                    
                    ]), count: 2))
                Health = Health - damage2
            }
        }else if(isEnemyDeadly == true){
            Health = 0
        }else{
            Health = Health - damage
        }
        HP_bar.updateBar(Float(Health)/100.0)
        if(Health <= 0){
            return true
        }
        return false
    }
    func moveToPosition(locationAt:CGPoint){
        
        self.runAction(SKAction.moveTo(locationAt, duration: 0.25))
    }

    func changeDirection() {
        self.removeAllActions()
        if(isFacing == RIGHT){
            self.runAction(walkRight)
        }else if(isFacing == LEFT){
            self.runAction(walkLeft)
        }else if(isFacing == UP){
            self.runAction(walkUp)
        }else if(isFacing == DOWN){
            self.runAction(walkDown)
        }
        self.texture!.filteringMode = SKTextureFilteringMode.Nearest
    }
    
    func dodge(){
        self.removeAllActions()
        isGreatlyDefending = true
        
        self.position = startPosition
        self.texture = SKTexture(imageNamed: "playerRight1")
        //let startLocation = self.position
        
        self.runAction(walkRight)
        var newPosition: CGPoint = startPosition
        
        newPosition = CGPointMake(newPosition.x - 75, newPosition.y)

        self.runAction(SKAction.sequence([
            SKAction.moveTo(newPosition, duration: 0.5),
            SKAction.runBlock({self.isGreatlyDefending = false}),
            SKAction.moveTo(startPosition, duration: 0.75)
        ]))
        
        self.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        self.runAction(SKAction.sequence([
            SKAction.waitForDuration(1.26),
            SKAction.runBlock({self.returnToIdle()}),
            SKAction.runBlock({self.position = self.startPosition}),
            SKAction.runBlock({self.isDefending = false})
        ]))
        
        
    }
    func strikeAt(withEnemyPosition: UInt8, andWithBool isEnemyThere: Bool){
        self.removeAllActions()
        self.isDefending = false
        //if(canStrike == true){
            canStrike = false
            self.position = startPosition
            self.texture = SKTexture(imageNamed: "playerRight1")
            //let startLocation = self.position
            
            //self.runAction(walkRight)
        self.runAction(swing)
        var newPosition: CGPoint = startPosition
        
        if(withEnemyPosition == UP){
            newPosition = CGPointMake(newPosition.x + 75, newPosition.y + 75)
        }else if(withEnemyPosition == RIGHT){
            newPosition = CGPointMake(newPosition.x + 75, newPosition.y)
        }else if(withEnemyPosition == DOWN){
            newPosition = CGPointMake(newPosition.x + 75, newPosition.y - 75)
        }
        if(isEnemyThere == true){
            self.runAction(SKAction.sequence([SKAction.moveTo(newPosition, duration: 0.25), SKAction.playSoundFileNamed("struck3.mp3", waitForCompletion: false), SKAction.moveTo(startPosition, duration: 0.5)]))
        }else{
            self.runAction(SKAction.sequence([SKAction.moveTo(newPosition, duration: 0.25), SKAction.moveTo(startPosition, duration: 0.5)]))
            
        }
        self.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.76), SKAction.runBlock({self.returnToIdle()}), SKAction.runBlock({self.position = self.startPosition})]))
        //}
    }
    func strikeAtClose(withEnemyPosition: CGPoint){
        self.removeAllActions()
        self.texture = SKTexture(imageNamed: "playerRight1")
        self.position = CGPointMake(withEnemyPosition.x - 75, withEnemyPosition.y)
    }
    func returnToIdle(){
        self.removeAllActions()
        self.colorBlendFactor = 0.0
        if(isFacing == RIGHT){
            self.texture = SKTextureAtlas(named: "player").textureNamed("playerRight1.png")
        }else if(isFacing == LEFT){
            self.texture = SKTextureAtlas(named: "player").textureNamed("playerLeft1.png")
        }else if(isFacing == UP){
            self.texture = SKTextureAtlas(named: "player").textureNamed("playerBack1.png")
        }else if(isFacing == DOWN){
            self.texture = SKTextureAtlas(named: "player").textureNamed("playerFront2.png")
        }
        self.texture!.filteringMode = SKTextureFilteringMode.Nearest
        canStrike = true
    }
    
    func createSprite(withSprite:SKSpriteNode, andWithPosition aPosition:CGPoint, andWithZPosition zPos: CGFloat, andWithString theString: String, andWithSize aSize: CGFloat, andWithParent parent: AnyObject) {
        withSprite.position = aPosition
        withSprite.zPosition = zPos
        withSprite.name = theString
        
        withSprite.size = CGSizeMake(withSprite.size.width * aSize, withSprite.size.height * aSize)
        withSprite.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        parent.addChild(withSprite)
    }
    func setUpAnimation(){
        let bearAnimatedAtlas = SKTextureAtlas(named: "player")
        var walkFrames = [SKTexture]()
        for i in 1.stride(to: 5, by: 1){
            //for var i=1; i<=4; i+=1 {
            let bearTextureName = "playerBack\(i)"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
        }
        let bearWalkingFrames = walkFrames
        walkUp = SKAction.repeatActionForever(SKAction.animateWithTextures(bearWalkingFrames, timePerFrame: 0.15))
        
        walkFrames = [SKTexture]()
        for i in 1.stride(to: 5, by: 1){
            //for var i=1; i<=4; i+=1 {
            let bearTextureName = "playerFoward\(i)"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
        }
        let bearWalkingFrames2 = walkFrames
        walkDown = SKAction.repeatActionForever(SKAction.animateWithTextures(bearWalkingFrames2, timePerFrame: 0.15))
        
        
        walkFrames = [SKTexture]()
        for i in 1.stride(to: 5, by: 1){
            //for var i=1; i<=4; i+=1 {
            let bearTextureName = "playerLeft\(i)"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
        }
        let bearWalkingFrames3 = walkFrames
        walkLeft = SKAction.repeatActionForever(SKAction.animateWithTextures(bearWalkingFrames3, timePerFrame: 0.15))
        
        walkFrames = [SKTexture]()
        for i in 1.stride(to: 5, by: 1){
            //for(var i=1; i<=4; i+=1) {
            let bearTextureName = "playerRight\(i)"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
        }
        let bearWalkingFrames4 = walkFrames
        walkRight = SKAction.repeatActionForever(SKAction.animateWithTextures(bearWalkingFrames4, timePerFrame: 0.15))
        
        walkFrames = [SKTexture]()
        for i in 1.stride(to: 4, by: 1){
            //for(var i=1; i<=3; i+=1) {
            
            let bearTextureName = "playerSwing\(i)"
            walkFrames.append(bearAnimatedAtlas.textureNamed(bearTextureName))
        }
        let bearWalkingFrames5 = walkFrames
        swing = SKAction.animateWithTextures(bearWalkingFrames5, timePerFrame: 0.2)
        
        
        
    }
    
}