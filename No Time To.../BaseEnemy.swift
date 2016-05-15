//
//  BaseEnemy.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/23/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import Foundation
import SpriteKit

class BaseEnemy: SKSpriteNode{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var Health: Float = 100
    var currentX: Int = 0
    var currentY: Int = 0
    var Strength: Float = 5
    var progressFraction: Float = 0.0
    
    var damageAnimation: SKAction = SKAction()
    var canStrike: Bool = true
    
    //charge
    var isCharging: Bool = false
    //var aura: SKSpriteNode = SKSpriteNode(imageNamed: "evilAura.png")
    var chargeCount: Int = 3
    var fullyCharged: Bool = false
    
    //slime
    var weapon: SKSpriteNode = SKSpriteNode(imageNamed: "dagger.png")
    var top: SKSpriteNode = SKSpriteNode(imageNamed: "badSlimeTop.png")
    var face: SKSpriteNode = SKSpriteNode(imageNamed: "badSlimeFace.png")
    
    
    var currentDamage: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    let HP_bar: ProgressBar = ProgressBar(imageNamed: "black.png")
    let Progress_bar: ProgressBar = ProgressBar(imageNamed: "black.png")
    
    var type: UInt8 = SHADOW
    
    var deathScream: SKAction = SKAction.playSoundFileNamed("deathScream.mp3", waitForCompletion: true)
    var hitSound: SKAction = SKAction.playSoundFileNamed("hit.mp3", waitForCompletion: true)
    
    var positionInLine: Int = 0
    var isSwipeBoolBeingUsed: Bool = false
    
    
    init(imageNamed: String) {
        let imageText =  SKTexture(imageNamed: imageNamed)
        super.init(texture: imageText, color:UIColor.redColor(), size: imageText.size())
        self.alpha = 0.0
        isSwipeBoolBeingUsed = true
        
        damageAnimation = SKAction.repeatAction(SKAction.sequence([SKAction.fadeAlphaTo(0.5, duration: 0.15), SKAction.fadeAlphaTo(1.0, duration: 0.15)]), count: 5)
        
        
         self.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        currentDamage.position = CGPointMake(0, 50)
        currentDamage.text = "0.0"
        //healthbar.addChild(currentDamage)
        
        currentDamage.hidden = true
        
        //self.name = "demon"
        self.setUpHealth()

    }
    
    func begin(withType: UInt8, andWithStartValue startFraction: Float, andWithPosInLine inPosition: Int){
        self.runAction(SKAction.fadeInWithDuration(0.75))
        
        self.positionInLine = inPosition
        self.type = withType
        
        if(self.type != GOODSLIME){
            self.setUpProgressBar(startFraction)
        }else{
            self.alpha = 1.0
            HP_bar.hidden = true
            HP_bar.alpha = 1.0
        }
        if(self.type == SHADOW){
            self.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.moveByX(0, y: -25, duration: 1.0), SKAction.moveByX(0, y: 25, duration: 1.0)])))
        }
        
        if(type == SLIME){
            weapon = SKSpriteNode(imageNamed: "dagger.png")
            top = SKSpriteNode(imageNamed: "badSlimeTop.png")
            face = SKSpriteNode(imageNamed: "badSlimeFace.png")
            
            weapon.zPosition = self.zPosition + 1
            top.zPosition = weapon.zPosition + 1
            face.zPosition = top.zPosition + 1
            
            weapon = SKSpriteNode(imageNamed: "shotLeft")
            weapon.colorBlendFactor = 0.9
            weapon.color = UIColor.redColor()
            
            
            //self.size = CGSizeMake(self.size.width * 3, self.size.height * 3)
            self.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            weapon.size = CGSizeMake(weapon.size.width * 4, weapon.size.height * 4)
            weapon.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            top.size = CGSizeMake(top.size.width * 4, top.size.height * 4)
            top.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            
            face.size = CGSizeMake(face.size.width * 4, face.size.height * 4)
            face.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            self.addChild(weapon)
            self.addChild(top)
            self.addChild(face)
        }else if(type == GOODSLIME){
            self.removeAllActions()
            top = SKSpriteNode(imageNamed: "topLeft.png")
            face = SKSpriteNode(imageNamed: "faceLeft.png")
            
            weapon.zPosition = self.zPosition + 1
            top.zPosition = weapon.zPosition + 1
            face.zPosition = top.zPosition + 1
            
            weapon = SKSpriteNode(imageNamed: "shotLeft")
            weapon.colorBlendFactor = 0.9
            weapon.color = UIColor.redColor()
            
            
            //self.size = CGSizeMake(self.size.width * 3, self.size.height * 3)
            self.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            weapon.size = CGSizeMake(weapon.size.width * 4, weapon.size.height * 4)
            weapon.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            top.size = CGSizeMake(top.size.width * 4, top.size.height * 4)
            top.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            
            face.size = CGSizeMake(face.size.width * 4, face.size.height * 4)
            face.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
            self.addChild(weapon)
            self.addChild(top)
            self.addChild(face)
        }
    }
    
    func setUpHealth(){
        Health = 100.0
        Strength = 35
        self.createSprite(HP_bar, andWithPosition: CGPointMake(0, (self.frame.size.height) + 50), andWithZPosition: 10, andWithString: "HP", andWithSize: 4, andWithParent: self)
        HP_bar.createBar(75, andHeight: 15.0, andType: enemyHealth)
    }
    
    func setUpProgressBar(withStartValue: Float){
        progressFraction = withStartValue
        self.createSprite(Progress_bar, andWithPosition: CGPointMake(0, -50), andWithZPosition: 10, andWithString: "Progress", andWithSize: 4, andWithParent: self)
        Progress_bar.createBar(90, andHeight: 15.0, andType: enemyProgress)
        Progress_bar.updateBar(progressFraction)
        //Progress_bar.hidden = true
        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.runBlock({self.updateProgressBar()})]))
    }
    
    func updateProgressBar() {
        if(self.name != "dud" && self.type != SCARECROW && self.type != GOODSLIME){
            Progress_bar.hidden = false
            if(isSwipeBoolBeingUsed == false){
                if(type == SMALL_SHADOW){
                    progressFraction+=0.08
                }else if(type == SHADOW){
                    progressFraction+=0.02
                }
            }
            Progress_bar.updateBar(progressFraction)
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.runBlock({self.updateProgressBar()})]))
        }
        if(self.type == SCARECROW){
            Progress_bar.hidden = true
            Progress_bar.alpha = 0.0
        }else if(self.type == GOODSLIME){
            print("good slime")
            
            Progress_bar.hidden = true
            Progress_bar.alpha = 0.0
            
            HP_bar.hidden = true
            HP_bar.alpha = 0.0
        }
    }
    
    func doDamage(damage:Float, withType type: Int)->Bool{
        print("Scarecrow is me")
        print("Scarecrow is me")
        print("Scarecrow is me")
        print("Scarecrow is me")
        print("Scarecrow is me")
        
        currentDamage.hidden = false
        currentDamage.text = String(damage)
        
        self.runAction(damageAnimation)
        Health = Health - damage
        HP_bar.updateBar(Float(Health)/100.0)
        if(Health <= 0){
            self.removeAllActions()
            self.Progress_bar.hidden = true
            self.Progress_bar.alpha = 0.0
            
            self.HP_bar.hidden = true
            self.HP_bar.alpha = 1.0
            
            self.name = "dud"
            if(self.type == SCARECROW || self.type == SMALL_SHADOW){
                self.runAction(SKAction.fadeOutWithDuration(0.5))
            }else if(self.type == SHADOW){
                let nodeA = enemyTexture(imageNamed: "creature2.png")
                
                //self.size = CGSizeMake(11 * 4, 22 * 4)
                //self.texture = nodeA.texture
            
                /*
                 let shader: SKShader = SKShader(fileNamed: "Texture.fsh")
                 let screenSize: CGRect = UIScreen.mainScreen().nativeBounds
                
                 shader.uniforms = [
                    SKUniform(name: "Resolution", floatVector2: GLKVector2(v: (Float(screenSize.height), Float(screenSize.width)))),
                    SKUniform(name: "tex", texture: nodeA.texture),
                    SKUniform(name: "bnw", float: 0.0),
                    
                    SKUniform(name: "withPosX", float: Float(self.frame.minX)),
                    SKUniform(name: "withPosY", float: Float(self.frame.minY)),
                    
                    SKUniform(name: "withWidth", float: Float(self.frame.size.width)),
                    SKUniform(name: "withHeight", float: Float(self.frame.size.height)),
                ]
                
                 self.shader = shader
                */
                if(type == 2){
                    self.runAction(SKAction.sequence([
                        SKAction.runBlock({nodeA.collapsePrime()}),
                        SKAction.runBlock({self.setTexture(andWithtexture: nodeA)}),
                        SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                        SKAction.sequence([
   
                            SKAction.repeatAction(
                                SKAction.sequence([
                                    SKAction.waitForDuration(0.05), SKAction.runBlock({nodeA.collapsePrime()}), SKAction.runBlock({self.setTexture(andWithtexture: nodeA)}),
                                    SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest}),

                                    ]), count: 15),
                            
                            SKAction.runBlock({self.hidden = true})
                            
                    ])]))
                    
                    
  
                    
                }else if(type == 1){
                    self.runAction(SKAction.sequence([
                        SKAction.waitForDuration(0.25),
                            SKAction.runBlock({nodeA.shatterPrime()}),
                            SKAction.runBlock({self.setTexture(andWithtexture: nodeA)}),
                        SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                        SKAction.sequence([
                       
                            
                            SKAction.repeatAction(SKAction.sequence([
                                SKAction.waitForDuration(0.1),
                                SKAction.runBlock({nodeA.shatterPrime()}),
                                SKAction.runBlock({self.setTexture(andWithtexture: nodeA)}),
                                SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                            
                            ]), count: 30),
                       
                            SKAction.runBlock({self.hidden = true})
                        ])]))
                    
                }else if(type == 3){
                    self.runAction(
                        SKAction.sequence([
                            SKAction.runBlock({nodeA.dropPrime()}),
                            SKAction.runBlock({self.size = CGSizeMake(self.size.width, CGFloat(nodeA.height + 1) * 4.0)}),
                            
                            SKAction.runBlock({self.setTexture(andWithtexture: nodeA)}),
                            SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest}),

                            SKAction.repeatAction(SKAction.sequence([
                                SKAction.waitForDuration(0.1),
                                SKAction.runBlock({nodeA.dropPrime()}),
                                SKAction.runBlock({self.size = CGSizeMake(self.size.width, CGFloat(nodeA.height + 1) * 4.0)}),

                                SKAction.runBlock({self.setTexture(andWithtexture: nodeA)}),
                                SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest})

                                ]), count: 50),
                        SKAction.runBlock({self.hidden = true})
                    ]))
                }else if(type == 4){
                    self.runAction(
                       // SKAction.repeatAction(
                        SKAction.sequence([
                            SKAction.runBlock({nodeA.stuffPrime()}),
                            SKAction.runBlock({self.setTexture( andWithtexture: nodeA)}),
                            SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest}),

                                //SKAction.runBlock({self.position = CGPointMake(self.position.x, self.position.y + 4)}),

                            SKAction.repeatAction(
                                SKAction.sequence([
                                    SKAction.waitForDuration(0.2),
                                    SKAction.runBlock({nodeA.stuffPrime()}),
                                    SKAction.runBlock({self.setTexture( andWithtexture: nodeA)}),
                                    
                                    SKAction.runBlock({nodeA.dissapearPrime()}),
                                    SKAction.runBlock({self.setTexture(andWithtexture: nodeA)}),
                                    SKAction.runBlock({self.texture!.filteringMode = SKTextureFilteringMode.Nearest}),

                                    ])
                            , count: 20),
                            
                            SKAction.runBlock({self.hidden = true})
                            
                        ])                    )
                }
            self.runAction(deathScream)
            }
            return true
        }
        return false
    }
    func setTexture(andWithtexture tex: enemyTexture){
        /*
        let screenSize: CGRect = UIScreen.mainScreen().nativeBounds
        let abc = UIScreen.mainScreen().nativeScale
        let cba = UIScreen.mainScreen().bounds
        
        withShader.uniforms = [
            SKUniform(name: "Resolution", floatVector2: GLKVector2(v: (Float(screenSize.height), Float(screenSize.width)))),
            SKUniform(name: "tex", texture: tex.texture),
            SKUniform(name: "bnw", float: 0.0),
            
            SKUniform(name: "withPosX", float: Float(self.frame.minX)),
            SKUniform(name: "withPosY", float: Float(self.frame.minY)),
            
            SKUniform(name: "withWidth", float: Float(self.frame.size.width)),
            SKUniform(name: "withHeight", float: Float(self.frame.size.height)),
        ]
        self.shader = withShader*/
        self.texture = tex.texture
    }
    
    func moveToPosition(locationAt:CGPoint){
        self.runAction(SKAction.moveTo(locationAt, duration: 0.25))
    }
    func update(){
        
    }
    
    func strikeAt(enemyLocation: CGPoint, withPlayerMaxHealth playerHealth: Float)->Float{
        if(self.name != "dud"){
            if(self.type == SHADOW || self.type == SMALL_SHADOW){
                self.isCharging = false
                let startLocation = self.position
                self.runAction(hitSound)
                //self.runAction(SKAction.sequence([SKAction.moveToX(self.position.x - 75, duration: 0.25), SKAction.moveToX(startLocation.x, duration: 0.25)]))
                self.runAction(SKAction.sequence([
                    SKAction.moveToX(self.position.x - 20, duration: 0.15),
                    SKAction.moveToX(self.position.x - 70, duration: 0.1),
                    SKAction.moveToX(startLocation.x, duration: 0.15)
                    ]))
            
                self.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
                if(self.type == SHADOW){
                    return self.Strength
                }else{
                    return playerHealth/10
                }
            }else if(self.type == SLIME){
                let         startLocation = CGPointZero
            
                let newEnemyLocation = CGPointMake(enemyLocation.x - self.position.x, enemyLocation.y - self.position.y)
            
                // self.texture = SKTextureAtlas(named: "rogue").textureNamed("bottomLeftAttack.png")
                //  top.texture = SKTextureAtlas(named: "rogue").textureNamed("topLeftAttack.png")
                //  face.texture = SKTextureAtlas(named: "rogue").textureNamed("faceLeftAttack.png")
            
            
                self.texture = SKTextureAtlas(named: "rogue").textureNamed("badSlimeBottom.png")
                top.texture = SKTextureAtlas(named: "rogue").textureNamed("badSlimeTop.png")
                face.texture = SKTextureAtlas(named: "rogue").textureNamed("badSlimeFace.png")
            
            
                weapon.runAction(SKAction.sequence([SKAction.moveTo(newEnemyLocation, duration: 0.3), SKAction.waitForDuration(0.05), SKAction.moveTo(startLocation, duration: 0.10)]))
                self.texture!.filteringMode = SKTextureFilteringMode.Nearest
                weapon.texture!.filteringMode = SKTextureFilteringMode.Nearest
                top.texture!.filteringMode = SKTextureFilteringMode.Nearest
                face.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.runBlock({self.returnToIdle()})]))
                return self.Strength
            }
        }
        return 1.0
    }
    
    
    
    func returnToIdle(){
        if(type == SLIME){
            self.texture = SKTextureAtlas(named: "rogue").textureNamed("badSlimeBottom.png")
            top.texture = SKTextureAtlas(named: "rogue").textureNamed("badSlimeTop.png")
            face.texture = SKTextureAtlas(named: "rogue").textureNamed("badSlimeFace.png")
            self.texture!.filteringMode = SKTextureFilteringMode.Nearest
            weapon.texture!.filteringMode = SKTextureFilteringMode.Nearest
            top.texture!.filteringMode = SKTextureFilteringMode.Nearest
            face.texture!.filteringMode = SKTextureFilteringMode.Nearest
            
        }else{
            self.removeAllActions()
            self.texture!.filteringMode = SKTextureFilteringMode.Nearest
            canStrike = true
        }
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