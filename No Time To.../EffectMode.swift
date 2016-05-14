//
//  EffectMode.swift
//  No Time To...
//
//  Created by Justin Buergi on 5/3/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import Foundation
import Foundation
import SpriteKit

class effectMode: SKScene {
    let lowEnemyZPosition: CGFloat = 6
    let midEnemyZPosition: CGFloat = 7
    let highEnemyZPosition: CGFloat = 5
    

    
    var currentLevel: Int = 1
    var currentRound: Int = 1
    
    var timeSinceLastUpdate: CFTimeInterval = 0
    var timeOfLastUpdate: CFTimeInterval = 0
    var timeOfLastAttack: CFTimeInterval = 0
    var timeBattleBegan: CFTimeInterval = 0
    var timeBattleEnded: CFTimeInterval  = 0
    
    var timeBonus: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    var highEnemy4: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    var midEnemy4: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    var lowEnemy4: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    
    var highEnemy3: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    var midEnemy3: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    var lowEnemy3: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    
    
    var highEnemy2: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    var midEnemy2: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    var lowEnemy2: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    
    
    var highEnemy1: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    var midEnemy1: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    var lowEnemy1: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
    
    
    var wasKilledByADemonWhoToreItselfFreeFromAHumanSoul: Bool = false
    
    var battleTimerBar: ProgressBar = ProgressBar(imageNamed: "black.png")
    var battleTimerBarFraction: Float = 1.0
    
    
    
    var swipeNode: SKSpriteNode = SKSpriteNode(imageNamed: "slide.png")
    var swipeAction: SKAction = SKAction()
    var swipeBoolDone: Bool = false
    
    var allEnemiesDead = false
    
    
    var initialTouch: CGPoint = CGPointMake(0, 0)
    var finalTouch: CGPoint = CGPointMake(0, 0)
    var waitForEnd: SKAction = SKAction()
    
    
    let boss1: Boss1 = Boss1(imageNamed: "creatureCircle2.png")
    
    override func didMoveToView(view: SKView) {
        currentRound = 1
        
        
        self.backgroundColor = UIColor.blackColor()
        self.backgroundColor = UIColor(red: 0.0, green: 107.0/255.0, blue: 0.0, alpha: 1.0)
        

        
        self.createEnemy()

        
        //highEnemy.Progress_bar.hidden = true
        //midEnemy.Progress_bar.hidden = true
        //lowEnemy.Progress_bar.hidden = true
        
        self.setUpTiles()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(infiniteMode.gameLoop), userInfo: nil, repeats: false)
        
        self.createBossParts()
        
        let home = SKSpriteNode(imageNamed: "house.png")
        self.createSprite(home, andWithPosition: CGPointMake(self.frame.size.width * 0.95, self.frame.size.height * 0.95), andWithZPosition: 20, andWithString: "home", andWithSize: 2, andWithParent: self)
    }
    
    func setUpTiles(){
        for(var i = -20; i < Int(self.frame.size.width) + 20; i+=88){
            for(var j = -20; j < Int(self.frame.size.width) + 20; j+=88){
                let a: SKSpriteNode = SKSpriteNode(imageNamed: "tileDark.png")
                self.createSprite(a, andWithPosition: CGPointMake(CGFloat(i), CGFloat(j)), andWithZPosition: 0, andWithString: "tile", andWithSize: 4, andWithParent: self)
            }
        }
    }
 
    
    func gameLoop() {

        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(infiniteMode.gameLoop), userInfo: nil, repeats: false)
    }

    
    func resetGame() {
        
        boss1.killMe()
        self.destroyEnemies()
        self.createEnemy()
        
        
        
        battleTimerBarFraction = 1.0
        battleTimerBar.hidden = false
        
        
        wasKilledByADemonWhoToreItselfFreeFromAHumanSoul = false
        
        self.enumerateChildNodesWithName("tile"){
            node, stop in
            let node2: SKSpriteNode = node as! SKSpriteNode
            node2.texture = SKTexture(imageNamed: "tileDark.png")
            node2.texture!.filteringMode = SKTextureFilteringMode.Nearest
        }
        
    }
    func nextRound(){
        currentRound+=1
        
        self.destroyEnemies()
        self.createEnemy()
        
        
        battleTimerBarFraction = 1.0
        battleTimerBar.hidden = false
        
        
        allEnemiesDead = false
    }

    
    func createEnemy() {
        
        let cre1: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre1, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2 + 180), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
        
        let cre2: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre2, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
        
        let cre3: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre3, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2 - 180), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
        
        let cre12: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre12, andWithPosition: CGPointMake(self.frame.size.width/2 , self.frame.size.height/2 + 180), andWithZPosition: 2, andWithString: "BaseEnemy2", andWithSize: 4.0, andWithParent: self)
        
        let cre22: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre22, andWithPosition: CGPointMake(self.frame.size.width/2 , self.frame.size.height/2), andWithZPosition: 2, andWithString: "BaseEnemy2", andWithSize: 4.0, andWithParent: self)
        
        let cre32: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre32, andWithPosition: CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 180), andWithZPosition: 2, andWithString: "BaseEnemy2", andWithSize: 4.0, andWithParent: self)
        
        let cre13: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre13, andWithPosition: CGPointMake(self.frame.size.width/2 - 200 , self.frame.size.height/2 + 180), andWithZPosition: 2, andWithString: "BaseEnemy3", andWithSize: 4.0, andWithParent: self)
        
        let cre23: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre23, andWithPosition: CGPointMake(self.frame.size.width/2 - 200 , self.frame.size.height/2), andWithZPosition: 2, andWithString: "BaseEnemy3", andWithSize: 4.0, andWithParent: self)
        
        let cre33: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre33, andWithPosition: CGPointMake(self.frame.size.width/2 - 200, self.frame.size.height/2 - 180), andWithZPosition: 2, andWithString: "BaseEnemy3", andWithSize: 4.0, andWithParent: self)
        
        
        let cre14: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre14, andWithPosition: CGPointMake(self.frame.size.width/2 - 400 , self.frame.size.height/2 + 180), andWithZPosition: 2, andWithString: "BaseEnemy4", andWithSize: 4.0, andWithParent: self)
        
        let cre24: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre24, andWithPosition: CGPointMake(self.frame.size.width/2 - 400 , self.frame.size.height/2), andWithZPosition: 2, andWithString: "BaseEnemy4", andWithSize: 4.0, andWithParent: self)
        
        let cre34: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        self.createSprite(cre34, andWithPosition: CGPointMake(self.frame.size.width/2 - 400, self.frame.size.height/2 - 180), andWithZPosition: 2, andWithString: "BaseEnemy4", andWithSize: 4.0, andWithParent: self)
        
        
        
        highEnemy1 = cre1
        midEnemy1 = cre2
        lowEnemy1 = cre3
        
        highEnemy2 = cre12
        midEnemy2 = cre22
        lowEnemy2 = cre32
        
        highEnemy3 = cre13
        midEnemy3 = cre23
        lowEnemy3 = cre33
        
        highEnemy4 = cre14
        midEnemy4  = cre24
        lowEnemy4  = cre34
        
        
        
        highEnemy1.zPosition = CGFloat(highEnemyZPosition)
        midEnemy1.zPosition = CGFloat(midEnemyZPosition)
        lowEnemy1.zPosition = CGFloat(lowEnemyZPosition)
        
        highEnemy2.zPosition = CGFloat(highEnemyZPosition)
        midEnemy2.zPosition = CGFloat(midEnemyZPosition)
        lowEnemy2.zPosition = CGFloat(lowEnemyZPosition)
        
        highEnemy3.zPosition = CGFloat(highEnemyZPosition)
        midEnemy3.zPosition = CGFloat(midEnemyZPosition)
        lowEnemy3.zPosition = CGFloat(lowEnemyZPosition)
        
        
        highEnemy4.zPosition = CGFloat(highEnemyZPosition)
        midEnemy4.zPosition = CGFloat(midEnemyZPosition)
        lowEnemy4.zPosition = CGFloat(lowEnemyZPosition)
        
        
        highEnemy1.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
        midEnemy1.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
        lowEnemy1.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
        
        highEnemy2.begin(SHADOW, andWithStartValue: 0.25, andWithPosInLine: 0)
        midEnemy2.begin(SHADOW, andWithStartValue: 0.25, andWithPosInLine: 0)
        lowEnemy2.begin(SHADOW, andWithStartValue: 0.25, andWithPosInLine: 0)
        
        highEnemy3.begin(SHADOW, andWithStartValue: 0.5, andWithPosInLine: 0)
        midEnemy3.begin(SHADOW, andWithStartValue: 0.5, andWithPosInLine: 0)
        lowEnemy3.begin(SHADOW, andWithStartValue: 0.5, andWithPosInLine: 0)
        
        highEnemy4.begin(SHADOW, andWithStartValue: 0.75, andWithPosInLine: 0)
        midEnemy4.begin(SHADOW, andWithStartValue: 0.75, andWithPosInLine: 0)
        lowEnemy4.begin(SHADOW, andWithStartValue: 0.75, andWithPosInLine: 0)
        
        //self.enemyAttack()
        
    }
    func destroyEnemies(){
        /*
        highEnemy.removeAllActions()
        highEnemy.isCharging = false
        highEnemy.chargeCount = 3
        
        midEnemy.removeAllActions()
        midEnemy.isCharging = false
        midEnemy.chargeCount = 3
        
        lowEnemy.removeAllActions()
        lowEnemy.isCharging = false
        lowEnemy.chargeCount = 3
        
        highEnemy.removeFromParent()
        midEnemy.removeFromParent()
        lowEnemy.removeFromParent()
        */
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
      
        
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            print(touchedNode.name)
            if(touchedNode.name == "home"){
                touchedNode.name = "gone"
                let nextScene = GameScene(size: self.size)
                self.scene?.view?.presentScene(nextScene)
            }else if(touchedNode.name == "BaseEnemy"){
                print(touchedNode.name)
                let xyz: BaseEnemy = touchedNode as! BaseEnemy
                xyz.doDamage(300, withType: 1)
                initialTouch = location
                
            }else if(touchedNode.name == "BaseEnemy2"){
                print(touchedNode.name)
                let xyz: BaseEnemy = touchedNode as! BaseEnemy
                xyz.doDamage(300, withType: 2)
                initialTouch = location
            }else if(touchedNode.name == "BaseEnemy3"){
                print(touchedNode.name)
                let xyz: BaseEnemy = touchedNode as! BaseEnemy
                xyz.doDamage(300, withType: 3)
                initialTouch = location
                
            }else if(touchedNode.name == "BaseEnemy4"){
                print(touchedNode.name)
                let xyz: BaseEnemy = touchedNode as! BaseEnemy
                xyz.doDamage(300, withType: 4)
                initialTouch = location
                
               
                
                
            }else if(touchedNode.name == "boss1"){
                let xyz: Boss1 = touchedNode as! Boss1
                xyz.doDamage(300)
            }
        }
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            finalTouch = location
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            finalTouch = location
        }
    }

    
    override func update(currentTime: CFTimeInterval) {

    }
    func createBossParts(){
        let head: SKSpriteNode = SKSpriteNode(imageNamed: "fitCreature.png")
        let en1: SKSpriteNode = SKSpriteNode(imageNamed: "fitCreature.png")
        let en2: SKSpriteNode = SKSpriteNode(imageNamed: "fitCreature.png")
        let en3: SKSpriteNode = SKSpriteNode(imageNamed: "fitCreature.png")
        let en4: SKSpriteNode = SKSpriteNode(imageNamed: "fitCreature.png")
        
        self.createSprite(head, andWithPosition: CGPointMake(self.frame.size.width - 200, self.frame.size.height), andWithZPosition: 2, andWithString: "boss1", andWithSize: 4, andWithParent: self)
        
        self.createSprite(en1, andWithPosition: CGPointMake(self.frame.size.width - 150, 0), andWithZPosition: 2, andWithString: "boss1", andWithSize: 4, andWithParent: self)
        self.createSprite(en2, andWithPosition: CGPointMake(self.frame.size.width - 100, self.frame.size.height), andWithZPosition: 2, andWithString: "boss1", andWithSize: 4, andWithParent: self)
        self.createSprite(en3, andWithPosition: CGPointMake(self.frame.size.width - 50, 0), andWithZPosition: 2, andWithString: "boss1", andWithSize: 4, andWithParent: self)
        self.createSprite(en4, andWithPosition: CGPointMake(self.frame.size.width , self.frame.size.height), andWithZPosition: 2, andWithString: "boss1", andWithSize: 4, andWithParent: self)
        
        
        let nodeB: transformTextureHead = transformTextureHead(imageNamed: "creature2.png")
        //head.texture = nodeB.texture
        
        let nodeA: transformTexture = transformTexture(imageNamed: "creature2.png")
        //en1.texture = nodeA.texture
        //en2.texture = nodeA.texture
        //en3.texture = nodeA.texture
        //en4.texture = nodeA.texture
        
        head.runAction(SKAction.moveToY(self.frame.size.height/2 + 10, duration: 1.5))
        
        en1.runAction(SKAction.moveToY(self.frame.size.height/2, duration: 1.5))
        en2.runAction(SKAction.moveToY(self.frame.size.height/2, duration: 1.5))
        en3.runAction(SKAction.moveToY(self.frame.size.height/2, duration: 1.5))
        en4.runAction(SKAction.moveToY(self.frame.size.height/2, duration: 1.5))
        
        
        
        self.runAction(
            SKAction.sequence([
                SKAction.waitForDuration(1.5),
                SKAction.repeatAction(SKAction.sequence([
                    SKAction.waitForDuration(0.25),
                    SKAction.runBlock({nodeB.shatterPrime()}),
                    SKAction.runBlock({head.texture = nodeB.texture}),
                    SKAction.runBlock({head.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                    
                    ]), count: 11),
                SKAction.runBlock({head.xScale = -1}),
                SKAction.runBlock({head.runAction(SKAction.rotateByAngle(-1.57079633, duration: 0.01))})
                ]))
        
        
        
        self.runAction(
            SKAction.sequence([
                SKAction.waitForDuration(1.5),
                SKAction.repeatAction(SKAction.sequence([
                    SKAction.waitForDuration(0.25), SKAction.runBlock({nodeA.shatterPrime()}), SKAction.runBlock({en1.texture = nodeA.texture}),SKAction.runBlock({en2.texture = nodeA.texture}),SKAction.runBlock({en3.texture = nodeA.texture}),SKAction.runBlock({en4.texture = nodeA.texture}),
                    SKAction.runBlock({en1.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                    
                    SKAction.runBlock({en2.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                    SKAction.runBlock({en3.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                    SKAction.runBlock({en4.texture!.filteringMode = SKTextureFilteringMode.Nearest}),
                    
                    ]), count: 11)]))
        
        
        self.runAction(SKAction.sequence([
            SKAction.waitForDuration(5.0),
            SKAction.runBlock({en1.removeFromParent()}),
            SKAction.runBlock({en2.removeFromParent()}),
            SKAction.runBlock({en3.removeFromParent()}),
            SKAction.runBlock({en4.removeFromParent()}),
            SKAction.runBlock({head.removeFromParent()}),
            SKAction.runBlock({self.createRealBoss()}),
            
            SKAction.runBlock({en1.size = CGSizeMake(11, 22)}),
            SKAction.runBlock({en2.size = CGSizeMake(11, 22)}),
            SKAction.runBlock({en3.size = CGSizeMake(11, 22)}),
            SKAction.runBlock({en4.size = CGSizeMake(11, 22)}),
            SKAction.runBlock({head.size = CGSizeMake(11, 22)}),
            
            ]))
    }
    
    
    func createRealBoss(){
        self.createSprite(boss1, andWithPosition: CGPointMake(self.frame.size.width, self.frame.size.height/2), andWithZPosition: 2, andWithString: "boss1", andWithSize: 4, andWithParent: self)
        self.boss1.canIPlzHaveAMomentToPutMymakeupOn = true
    }
    
    func createSprite(withSprite:SKSpriteNode, andWithPosition aPosition:CGPoint, andWithZPosition zPos: CGFloat, andWithString theString: String, andWithSize aSize: CGFloat, andWithParent parent: AnyObject) {
        withSprite.size = (withSprite.texture?.size())!
        withSprite.position = aPosition
        withSprite.zPosition = zPos
        withSprite.name = theString
        
        withSprite.size = CGSizeMake(withSprite.size.width * aSize, withSprite.size.height * aSize)
        withSprite.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        parent.addChild(withSprite)
    }
}