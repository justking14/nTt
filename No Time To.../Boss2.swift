//
//  Boss1.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/28/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import Foundation
import SpriteKit

class Boss2: SKSpriteNode{
    
    var Health_Top: Float = 150
    var Health_Bottom: Float = 150
    
    var Strength: Float = 5
    var progressFraction_Top: Float = 0.0
    var progressFraction_Bottom: Float = 0.0
    
    var damageAnimation: SKAction = SKAction()
    var canStrike: Bool = true
    
    var currentDamage: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    let HP_bar_Top: ProgressBar = ProgressBar(imageNamed: "black.png")
    let Progress_bar_Top: ProgressBar = ProgressBar(imageNamed: "black.png")
    
    let HP_bar_Bottom: ProgressBar = ProgressBar(imageNamed: "black.png")
    let Progress_bar_Bottom: ProgressBar = ProgressBar(imageNamed: "black.png")
    
    
    var deathScream: SKAction = SKAction.playSoundFileNamed("deathScream.mp3", waitForCompletion: true)
    var hitSound: SKAction = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: true)
    
    var currentOrientation_Top: UInt8 = RIGHT
    var currentOrientation_Bottom: UInt8 = RIGHT
    
    let node4_Top_head: SKSpriteNode = SKSpriteNode(imageNamed: "creatureHead1.png")
    let node3_Top_limb: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")
    let node2_Top_limb: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")
    let  node_Top_limb: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")

    let node4_Bottom_head: SKSpriteNode = SKSpriteNode(imageNamed: "creatureHead1.png")
    let node3_Bottom_limb: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")
    let node2_Bottom_limb: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")
    let  node_Bottom_limb: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")
    
    
    var firstHeadDead: Bool = false
    
    var topHeadDead: Bool = false
    var bottomHeadDead: Bool = false
    
    var canIPlzHaveAMomentToPutMymakeupOn: Bool = false
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
    init(imageNamed: String) {
        let imageText =  SKTexture(imageNamed: imageNamed)
        super.init(texture: imageText, color:UIColor.redColor(), size: imageText.size())

        
        self.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        
        self.createSprite(node_Top_limb, andWithPosition: CGPointMake(-25, 0), andWithZPosition: 6, andWithString: "node1", andWithSize: 4, andWithParent: self)
        self.createSprite(node_Bottom_limb, andWithPosition: CGPointMake(-25, 0), andWithZPosition: 6, andWithString: "node1", andWithSize: 4, andWithParent: self)

        self.createSprite(node2_Top_limb, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node2", andWithSize: 4, andWithParent: node_Top_limb)
        self.createSprite(node2_Bottom_limb, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node2", andWithSize: 4, andWithParent: node_Bottom_limb)
        
        self.createSprite(node3_Top_limb, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node3", andWithSize: 4, andWithParent: node2_Top_limb)
        self.createSprite(node3_Bottom_limb, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node3", andWithSize: 4, andWithParent: node2_Bottom_limb)
        
        self.createSprite(node4_Top_head, andWithPosition: CGPointMake(-75, 0), andWithZPosition: 6, andWithString: "node4", andWithSize: 4, andWithParent: node3_Top_limb)
        self.createSprite(node4_Bottom_head, andWithPosition: CGPointMake(-75, 0), andWithZPosition: 6, andWithString: "node4", andWithSize: 4, andWithParent: node3_Bottom_limb)

        
        node_Top_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveToY(75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0),
            SKAction.moveToY(-75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0)
        ])))
        node_Bottom_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveToY(-75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0),
            SKAction.moveToY(75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0)
            ])))
        
        
        node2_Top_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
        ])))
        node2_Bottom_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, -50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, 50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            ])))
        
        
        node3_Top_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0)
        ])))
        node3_Bottom_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0)
            ])))
        
        

        node4_Top_head.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0)
        ])))
        
        node4_Bottom_head.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0)
            ])))
        
        

        self.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.waitForDuration(0.5),
            SKAction.runBlock({self.currentOrientation_Top = UP}),
            SKAction.runBlock({self.currentOrientation_Bottom = DOWN}),
            SKAction.runBlock({print("UP")}),
            SKAction.waitForDuration(1.0),//half way
            SKAction.runBlock({self.currentOrientation_Top = RIGHT}),
            SKAction.runBlock({self.currentOrientation_Bottom = RIGHT}),
            SKAction.runBlock({print("MID")}),
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({self.currentOrientation_Top = DOWN}),
            SKAction.runBlock({self.currentOrientation_Bottom = UP}),
            SKAction.runBlock({print("down")}),
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({self.currentOrientation_Top = RIGHT}),
            SKAction.runBlock({self.currentOrientation_Bottom = RIGHT}),
            SKAction.runBlock({print("Mid")}),
            SKAction.waitForDuration(0.5),
            
            ])))
    
     
        self.setUpHealth()
        self.setUpProgressBar()
    }
    
    
    
    func setUpHealth(){
        Health_Top = 150.0
        Health_Bottom = 150.0
        Strength = 35
        self.createSprite(HP_bar_Top, andWithPosition: CGPointMake(0, (self.frame.size.height)+35), andWithZPosition: 10, andWithString: "HP", andWithSize: 4, andWithParent: node4_Top_head)
        HP_bar_Top.createBar(75, andHeight: 15.0, andType: enemyHealth)
        
        
        self.createSprite(HP_bar_Bottom, andWithPosition: CGPointMake(0, (self.frame.size.height)+35), andWithZPosition: 10, andWithString: "HP", andWithSize: 4, andWithParent: node4_Bottom_head)
        HP_bar_Bottom.createBar(75, andHeight: 15.0, andType: enemyHealth)
        
    
    }
    
    func setUpProgressBar(){
        progressFraction_Top = 0.0
        progressFraction_Bottom = 0.5
        self.createSprite(Progress_bar_Top, andWithPosition: CGPointMake(0, -40), andWithZPosition: 10, andWithString: "Progress", andWithSize: 4, andWithParent: node4_Top_head)
        Progress_bar_Top.createBar(90, andHeight: 15.0, andType: enemyProgress)
        Progress_bar_Top.updateBar(progressFraction_Top)
        Progress_bar_Top.hidden = true
        
        self.createSprite(Progress_bar_Bottom, andWithPosition: CGPointMake(0, -40), andWithZPosition: 10, andWithString: "Progress", andWithSize: 4, andWithParent: node4_Bottom_head)
        Progress_bar_Bottom.createBar(90, andHeight: 15.0, andType: enemyProgress)
        Progress_bar_Bottom.updateBar(progressFraction_Bottom)
        Progress_bar_Bottom.hidden = true
        
        
        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.25), SKAction.runBlock({self.updateProgressBar_Top()})]))

        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.25), SKAction.runBlock({self.updateProgressBar_Bottom()})]))
    }
  
    
    func updateProgressBar_Top() {
        if(self.name != "dud" && topHeadDead == false){
            Progress_bar_Top.hidden = false
            progressFraction_Top+=0.02
            Progress_bar_Top.updateBar(progressFraction_Top)
            
            
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.runBlock({self.updateProgressBar_Top()})]))
        }
    }
    func updateProgressBar_Bottom() {
        if(self.name != "dud" && bottomHeadDead == false){
            
            Progress_bar_Bottom.hidden = false
            progressFraction_Bottom+=0.02
            Progress_bar_Bottom.updateBar(progressFraction_Bottom)
            
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.runBlock({self.updateProgressBar_Bottom()})]))
        }
    }
    
    
    
    func doDamage_Top(damage:Float)->Bool{
        print("Did damage to top")
        print(damage)
        
        currentDamage.hidden = false
        currentDamage.text = String(damage)
        
        self.runAction(damageAnimation)
        Health_Top = Health_Top - damage
        HP_bar_Top.updateBar(Float(Health_Top)/150.0)
        if(Health_Top <= 0){
            self.Progress_bar_Top.hidden = true
            self.Progress_bar_Top.alpha = 0.0
            
            self.HP_bar_Top.hidden = true
            self.HP_bar_Top.alpha = 1.0
            
            var nodeC: transformTextureLimb = transformTextureLimb(imageNamed: "creatureCircle2.png")
            self.texture = nodeC.texture
            
            topHeadDead = true
            
            if(firstHeadDead == true){
                self.name = "dud"
                self.runAction(
                    SKAction.sequence([
                        SKAction.waitForDuration(1.25),
                        
                        SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        SKAction.runBlock({self.texture = nodeC.texture}),
                        //SKAction.runBlock({self.node.texture = nodeC.texture})
                            ]), count: 11)]))
                
                //self.removeAllActions()
                
            }else{
                firstHeadDead = true
            }
            

            //node.texture = nodeC.texture
            //node2.texture = nodeC.texture
            //node3.texture = nodeC.texture
            //self.removeAllActions()
            node_Top_limb.removeAllActions()
            node2_Top_limb.removeAllActions()
            node3_Top_limb.removeAllActions()
            node4_Top_head.removeAllActions()
            
            
            self.runAction(
                SKAction.sequence([
                    SKAction.waitForDuration(0.25),
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        //SKAction.runBlock({self.texture = nodeC.texture}),
                        //SKAction.runBlock({self.node.texture = nodeC.texture})
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")
}),
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        //SKAction.runBlock({self.texture = nodeC.texture}),
                        SKAction.runBlock({self.node_Top_limb.texture = nodeC.texture}),
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")
                    }),
                    
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        //SKAction.runBlock({self.texture = nodeC.texture}),
                        SKAction.runBlock({self.node2_Top_limb.texture = nodeC.texture}),
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")
                    }),
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        //SKAction.runBlock({self.texture = nodeC.texture}),
                        SKAction.runBlock({self.node3_Top_limb.texture = nodeC.texture}),

                        ]), count: 11),
                    
                   // SKAction.runBlock({self.node4_Bottom_head.runAction(SKAction.fadeAlphaTo(0.0, duration: 0.25))}),

                    SKAction.runBlock({self.node4_Top_head.runAction(SKAction.fadeAlphaTo(0.0, duration: 0.25))})
                    
                    
                    ]))
            
  
                self.runAction(deathScream)
            
            return true
        }
        return false
    }
    
    func doDamage_Bottom(damage:Float)->Bool{
        print("Did damage to bottom")
        print(damage)
        
        
        currentDamage.hidden = false
        currentDamage.text = String(damage)
        
        self.runAction(damageAnimation)
        Health_Bottom = Health_Bottom - damage
        HP_bar_Bottom.updateBar(Float(Health_Bottom)/150.0)
        if(Health_Bottom <= 0){
            self.Progress_bar_Bottom.hidden = true
            self.Progress_bar_Bottom.alpha = 0.0
            
            self.HP_bar_Bottom.hidden = true
            self.HP_bar_Bottom.alpha = 1.0
            
            var nodeC: transformTextureLimb = transformTextureLimb(imageNamed: "creatureCircle2.png")
            self.texture = nodeC.texture
            
            bottomHeadDead = true
            
            if(firstHeadDead == true){
                self.name = "dud"
                self.runAction(
                    SKAction.sequence([
                        SKAction.waitForDuration(1.25),
                        
                        SKAction.repeatAction(SKAction.sequence([
                            SKAction.waitForDuration(0.05),
                            SKAction.runBlock({nodeC._collapsePrime()}),
                            SKAction.runBlock({self.texture = nodeC.texture}),
                            //SKAction.runBlock({self.node.texture = nodeC.texture})
                            ]), count: 11)]))
                
                //self.removeAllActions()
            }else{
                firstHeadDead = true
            }
            
         
            //node.texture = nodeC.texture
            //node2.texture = nodeC.texture
            //node3.texture = nodeC.texture
           // self.removeAllActions()
            node_Bottom_limb.removeAllActions()
            node2_Bottom_limb.removeAllActions()
            node3_Bottom_limb.removeAllActions()
            node4_Bottom_head.removeAllActions()
            
            
            self.runAction(
                SKAction.sequence([
                    SKAction.waitForDuration(0.25),
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        //SKAction.runBlock({self.texture = nodeC.texture}),
                        //SKAction.runBlock({self.node.texture = nodeC.texture})
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")
                    }),
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        SKAction.runBlock({self.node_Bottom_limb.texture = nodeC.texture}),
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")
                    }),
                    
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        SKAction.runBlock({self.node2_Bottom_limb.texture = nodeC.texture}),
                        ]), count: 11),
                    SKAction.runBlock({nodeC = transformTextureLimb(imageNamed: "creatureCircle2.png")
                    }),
                    SKAction.repeatAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05),
                        SKAction.runBlock({nodeC._collapsePrime()}),
                        SKAction.runBlock({self.node3_Bottom_limb.texture = nodeC.texture}),
                        
                        ]), count: 11),
                    
                    // SKAction.runBlock({self.node4_Bottom_head.runAction(SKAction.fadeAlphaTo(0.0, duration: 0.25))}),
                    
                    SKAction.runBlock({self.node4_Bottom_head.runAction(SKAction.fadeAlphaTo(0.0, duration: 0.25))})
                    
                    
                    ]))
            
            
            self.runAction(deathScream)
            
            return true
        }
        return false
    }
    
    
    
    
    func strikeAt_Top(enemyLocation: CGPoint){
        print("sytike at")
        if(self.name != "dud"){
            let startLocation = node4_Top_head.position
            let finalLocation = CGPointMake(
                enemyLocation.x + node3_Top_limb.position.x + node2_Top_limb.position.x + node_Top_limb.position.x - self.position.x,
                enemyLocation.y + node3_Top_limb.position.y + node2_Top_limb.position.y + node_Top_limb.position.y - self.position.y
            )
            
            self.runAction(hitSound)
            node4_Top_head.runAction(SKAction.sequence([
                SKAction.moveTo(finalLocation, duration: 0.5),
                SKAction.moveTo(CGPointMake(startLocation.x - finalLocation.x/2, startLocation.y - finalLocation.y/2), duration: 0.25)
                
                ]))

            self.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            
            

        }
    }
    
    func strikeAt_Bottom(enemyLocation: CGPoint){
        print("sytike at")
        if(self.name != "dud"){
            let startLocation2 = node4_Bottom_head.position
            let finalLocation2 = CGPointMake(
                enemyLocation.x + node3_Bottom_limb.position.x + node2_Bottom_limb.position.x + node_Bottom_limb.position.x - self.position.x,
                enemyLocation.y + node3_Bottom_limb.position.y + node2_Bottom_limb.position.y + node_Bottom_limb.position.y - self.position.y
            )
            
            self.runAction(hitSound)
            node4_Bottom_head.runAction(SKAction.sequence([
                SKAction.moveTo(finalLocation2, duration: 0.5),
                SKAction.moveTo(CGPointMake(startLocation2.x - finalLocation2.x/2, startLocation2.y - finalLocation2.y/2), duration: 0.25)
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
        
        
         canStrike = true
         currentOrientation_Top = RIGHT
         currentOrientation_Bottom = RIGHT
        firstHeadDead = false
        topHeadDead = false
        bottomHeadDead = false
        
        canIPlzHaveAMomentToPutMymakeupOn = false
        progressFraction_Top = 0.0
        progressFraction_Bottom = 0.5
        
        Health_Top = 150
        Health_Bottom = 150
        
        HP_bar_Top.updateBar(Float(Health_Top)/150.0)
        Progress_bar_Top.updateBar(0.0)
        
        HP_bar_Bottom.updateBar(Float(Health_Bottom)/150.0)
        Progress_bar_Bottom.updateBar(0.5)
        
        self.removeAllActions()
        //self.removeAllChildren()
        self.name = "boss2"
        
        node_Top_limb.removeFromParent()
        node2_Top_limb.removeFromParent()
        node3_Top_limb.removeFromParent()
        node4_Top_head.removeAllChildren()
        node4_Top_head.removeFromParent()
        
        node_Bottom_limb.removeFromParent()
        node2_Bottom_limb.removeFromParent()
        node3_Bottom_limb.removeFromParent()
        node4_Bottom_head.removeAllChildren()
        node4_Bottom_head.removeFromParent()

        self.removeFromParent()
        node_Bottom_limb.hidden = false
        node_Top_limb.hidden = false
        
        node4_Bottom_head.hidden = false
        node4_Top_head.hidden = false
        
        node3_Bottom_limb.hidden = false
        node3_Top_limb.hidden = false
        
        node2_Bottom_limb.hidden = false
        node2_Top_limb.hidden = false
        
        
        self.hidden = false
        
        self.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        
        self.createSprite(node_Top_limb, andWithPosition: CGPointMake(-25, 0), andWithZPosition: 6, andWithString: "node1", andWithSize: 4, andWithParent: self)
        self.createSprite(node_Bottom_limb, andWithPosition: CGPointMake(-25, 0), andWithZPosition: 6, andWithString: "node1", andWithSize: 4, andWithParent: self)
        
        self.createSprite(node2_Top_limb, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node2", andWithSize: 4, andWithParent: node_Top_limb)
        self.createSprite(node2_Bottom_limb, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node2", andWithSize: 4, andWithParent: node_Bottom_limb)
        
        self.createSprite(node3_Top_limb, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node3", andWithSize: 4, andWithParent: node2_Top_limb)
        self.createSprite(node3_Bottom_limb, andWithPosition: CGPointMake(-50, 0), andWithZPosition: 6, andWithString: "node3", andWithSize: 4, andWithParent: node2_Bottom_limb)
        
        self.createSprite(node4_Top_head, andWithPosition: CGPointMake(-75, 0), andWithZPosition: 6, andWithString: "node4", andWithSize: 4, andWithParent: node3_Top_limb)
        self.createSprite(node4_Bottom_head, andWithPosition: CGPointMake(-75, 0), andWithZPosition: 6, andWithString: "node4", andWithSize: 4, andWithParent: node3_Bottom_limb)
        
        
        node_Top_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveToY(75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0),
            SKAction.moveToY(-75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0)
            ])))
        node_Bottom_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveToY(-75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0),
            SKAction.moveToY(75, duration: 1.0),
            SKAction.moveToY(0, duration: 1.0)
            ])))
        
        
        node2_Top_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            ])))
        node2_Bottom_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, -50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, 50), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            ])))
        
        
        node3_Top_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0)
            ])))
        node3_Bottom_limb.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-25, 0), duration: 1.0)
            ])))
        
        
        
        node4_Top_head.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0)
            ])))
        
        node4_Bottom_head.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.moveTo(CGPointMake(-75, -25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0),
            SKAction.moveTo(CGPointMake(-75, 25), duration: 1.0),
            SKAction.moveTo(CGPointMake(-50, 0), duration: 1.0)
            ])))
        
        
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([
            SKAction.waitForDuration(0.5),
            SKAction.runBlock({self.currentOrientation_Top = UP}),
            SKAction.runBlock({self.currentOrientation_Bottom = DOWN}),
            SKAction.runBlock({print("UP")}),
            SKAction.waitForDuration(1.0),//half way
            SKAction.runBlock({self.currentOrientation_Top = RIGHT}),
            SKAction.runBlock({self.currentOrientation_Bottom = RIGHT}),
            SKAction.runBlock({print("MID")}),
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({self.currentOrientation_Top = DOWN}),
            SKAction.runBlock({self.currentOrientation_Bottom = UP}),
            SKAction.runBlock({print("down")}),
            SKAction.waitForDuration(1.0),
            SKAction.runBlock({self.currentOrientation_Top = RIGHT}),
            SKAction.runBlock({self.currentOrientation_Bottom = RIGHT}),
            SKAction.runBlock({print("Mid")}),
            SKAction.waitForDuration(0.5),
            
            ])))
        
        
        self.setUpHealth()
        self.setUpProgressBar()
        
        
    }
    
    func createSprite(withSprite:SKSpriteNode, andWithPosition aPosition:CGPoint, andWithZPosition zPos: CGFloat, andWithString theString: String, andWithSize aSize: CGFloat, andWithParent parent: AnyObject) {
        withSprite.position = aPosition
        withSprite.zPosition = zPos
        withSprite.name = theString
        if(withSprite.name != "node4"){
            withSprite.size = CGSizeMake(11, 11)
            withSprite.texture = SKTexture(imageNamed: "creatureCircle2.png")
        }else{
            withSprite.size = CGSizeMake(22, 11)
            withSprite.texture = SKTexture(imageNamed: "creatureHead1.png")
        }
        withSprite.hidden = false
        withSprite.alpha = 1.0
        withSprite.size = CGSizeMake(withSprite.size.width * aSize, withSprite.size.height * aSize)
        withSprite.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        parent.addChild(withSprite)
    }

}