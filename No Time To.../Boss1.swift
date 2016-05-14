//
//  Boss1.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/28/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import Foundation
import SpriteKit

class Boss1: SKSpriteNode{
    
    var Health: Float = 150
    var Strength: Float = 5
    var progressFraction: Float = 0.0
    
    var damageAnimation: SKAction = SKAction()
    var canStrike: Bool = true
    
    var currentDamage: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    let HP_bar: ProgressBar = ProgressBar(imageNamed: "black.png")
    let Progress_bar: ProgressBar = ProgressBar(imageNamed: "black.png")
    
    
    var deathScream: SKAction = SKAction.playSoundFileNamed("deathScream.mp3", waitForCompletion: true)
    var hitSound: SKAction = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: true)
    
    var currentOrientation: UInt8 = RIGHT
    let node4: SKSpriteNode = SKSpriteNode(imageNamed: "creatureHead1.png")
    
    var canIPlzHaveAMomentToPutMymakeupOn: Bool = false
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

            let node: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")
        let node2: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")
        let node3: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")

    
    init(imageNamed: String) {
        let imageText =  SKTexture(imageNamed: imageNamed)
        super.init(texture: imageText, color:UIColor.redColor(), size: imageText.size())

        
        self.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        
        self.createSprite(node, andWithPosition: CGPointMake(-25, 0), andWithZPosition: 6, andWithString: "node1", andWithSize: 4, andWithParent: self)
        
        self.createSprite(node2, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node2", andWithSize: 4, andWithParent: node)
        
        self.createSprite(node3, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node3", andWithSize: 4, andWithParent: node2)
        
        
        self.createSprite(node4, andWithPosition: CGPointMake(-80, 0), andWithZPosition: 6, andWithString: "node4", andWithSize: 4, andWithParent: node3)
        
        
        node.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveToY(75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0),
            SKAction.moveToY(-75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0)
        ])))
        
        node2.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
        ])))
        
        node3.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0)
        ])))

        /*node4.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0)
        ])))*/

        self.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.waitForDuration(0.5),
            SKAction.runBlock({self.currentOrientation = UP}),
            SKAction.runBlock({print("UP")}),
            SKAction.waitForDuration(1.0),//half way
            SKAction.runBlock({self.currentOrientation = RIGHT}),
            SKAction.runBlock({print("MID")}),
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({self.currentOrientation = DOWN}),
            SKAction.runBlock({print("down")}),
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({self.currentOrientation == RIGHT}),
            SKAction.runBlock({print("Mid")}),
            SKAction.waitForDuration(0.5),
            
            ])))
    
     
        self.setUpHealth()
        self.setUpProgressBar(0.0)
    }
    
    
    
    func setUpHealth(){
        Health = 150.0
        Strength = 35
        self.createSprite(HP_bar, andWithPosition: CGPointMake(0, (self.frame.size.height)+35), andWithZPosition: 10, andWithString: "HP", andWithSize: 4, andWithParent: node4)
        HP_bar.createBar(75, andHeight: 15.0, andType: enemyHealth)
    }
    func setUpProgressBar(withStartValue: Float){
        progressFraction = withStartValue
        self.createSprite(Progress_bar, andWithPosition: CGPointMake(0, -50), andWithZPosition: 10, andWithString: "Progress", andWithSize: 4, andWithParent: node4)
        Progress_bar.createBar(90, andHeight: 15.0, andType: enemyProgress)
        Progress_bar.updateBar(progressFraction)
        Progress_bar.hidden = true
        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.runBlock({self.updateProgressBar()})]))
        //self.updateProgressBar()
        
    }
    
    
    func updateProgressBar() {
        if(self.name != "dud"){
            //print("unhide")
            Progress_bar.hidden = false
            progressFraction+=0.02
            Progress_bar.updateBar(progressFraction)
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.runBlock({self.updateProgressBar()})]))
        }
    }
    
    func doDamage(damage:Float)->Bool{
        currentDamage.hidden = false
        currentDamage.text = String(damage)
        
        self.runAction(damageAnimation)
        Health = Health - damage
        HP_bar.updateBar(Float(Health)/150.0)
        if(Health <= 0){
            self.Progress_bar.hidden = true
            self.Progress_bar.alpha = 0.0
            
            self.HP_bar.hidden = true
            self.HP_bar.alpha = 1.0
            
            self.name = "dud"
            
            
            var nodeC: transformTextureLimb = transformTextureLimb(imageNamed: "creatureCircle2.png")
            self.texture = nodeC.texture
            //node.texture = nodeC.texture
            //node2.texture = nodeC.texture
            //node3.texture = nodeC.texture
            self.removeAllActions()
            node.removeAllActions()
            node2.removeAllActions()
            node3.removeAllActions()
            node4.removeAllActions()
            
            self.runAction(
                SKAction.sequence([
                    SKAction.waitForDuration(0.5),
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        SKAction.runBlock({self.texture = nodeC.texture}),
                        SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")}),
                    
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        //SKAction.runBlock({self.texture = nodeC.texture}),
                        SKAction.runBlock({self.node.texture = nodeC.texture}),
                        SKAction.runBlock({self.node.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")}),
                    
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        //SKAction.runBlock({self.texture = nodeC.texture}),
                        SKAction.runBlock({self.node2.texture = nodeC.texture}),
                        SKAction.runBlock({self.node2.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")
                    }),
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        //SKAction.runBlock({self.texture = nodeC.texture}),
                        SKAction.runBlock({self.node3.texture = nodeC.texture}),
                        SKAction.runBlock({self.node3.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                        ]), count: 11),
                    
                    SKAction.runBlock({self.node4.runAction(SKAction.fadeAlphaTo(0.0, duration: 0.25))})
                    
                    
                    ]))
            
  
                self.runAction(deathScream)
            
            return true
        }
        return false
    }
    func strikeAt(enemyLocation: CGPoint){
        print("sytike at")
        if(self.name != "dud"){
            let startLocation = node4.position
            let finalLocation = CGPointMake(
                enemyLocation.x + node3.position.x + node2.position.x + node.position.x - self.position.x,
                enemyLocation.y + node3.position.y + node2.position.y + node.position.y - self.position.y
            )
            
            self.runAction(hitSound)
            
            node4.runAction(SKAction.sequence([
                //SKAction.moveTo(finalLocation, duration: 0.5),
                SKAction.moveTo(CGPointMake((finalLocation.x - startLocation.x)/4, (finalLocation.y - startLocation.y)/4), duration: 0.25),
                SKAction.moveTo(CGPointMake((finalLocation.x - startLocation.x)/1.5, (finalLocation.y - startLocation.y)/1.5), duration: 0.15),
                
                
                SKAction.moveTo(CGPointMake(-80, 0), duration: 0.7)
                
                ]))
            //self.runAction(SKAction.sequence([SKAction.moveToX(self.position.x - 75, duration: 0.25), ]))
            self.texture!.filteringMode = SKTextureFilteringMode.Nearest
        }
    }
    
    
    func killMe(){
                self.size = CGSizeMake(11, 11)

        /*node.size = CGSizeMake(11, 11)
        node2.size = CGSizeMake(11, 11)
        node3.size = CGSizeMake(11, 11)
        node4.size = CGSizeMake(11, 11)
        
       // node.removeFromParent()
       // node2.removeFromParent()
       // node3.removeFromParent()
       // node4.removeFromParent()
        */
        
        canIPlzHaveAMomentToPutMymakeupOn = false
        progressFraction = 0.0
        Health = 150
        HP_bar.updateBar(Float(Health)/150.0)
        Progress_bar.updateBar(0.0)
        self.removeFromParent()
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