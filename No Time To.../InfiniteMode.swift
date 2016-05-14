//
//  InfiniteMode.swift
//  No Time To...
//
//  Created by Justin Buergi on 5/3/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import Foundation
import SpriteKit

class infiniteMode: SKScene {
        let lowEnemyZPosition: CGFloat = 6
        let midEnemyZPosition: CGFloat = 7
        let highEnemyZPosition: CGFloat = 5
    
    
    var lowEnemyOrder: Int = 0
    var midEnemyOrder: Int = 0
    var higEnemyOrder: Int = 0
    
    
        var player: Player!
        var state: StateHolder = StateHolder()
        
        //var baseSwipe: Swipe = Swipe(imageNamed: "choicesB.png")
        var baseSwipe: primeSwipe = primeSwipe(imageNamed: "baseChoices.png")
    
        
        var timeSinceLastUpdate: CFTimeInterval = 0
        var timeOfLastUpdate: CFTimeInterval = 0
        var timeOfLastAttack: CFTimeInterval = 0
        var timeBattleBegan: CFTimeInterval = 0
        var timeBattleEnded: CFTimeInterval  = 0
        
        var timeBonus: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        
        var highEnemy: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        var midEnemy: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        var lowEnemy: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
        
        var wasKilledByADemonWhoToreItselfFreeFromAHumanSoul: Bool = false
        
        var battleTimerBar: ProgressBar = ProgressBar(imageNamed: "black.png")
        var battleTimerBarFraction: Float = 1.0
        
        let GO: SKSpriteNode = SKSpriteNode(imageNamed: "GO.png")
        let deadPlayer: SKSpriteNode = SKSpriteNode(imageNamed: "dead2.png")
        
        let DOD: SKSpriteNode = SKSpriteNode(imageNamed: "dodge.png")
    
        
        var allEnemiesDead = false
        
        
        var initialTouch: CGPoint = CGPointMake(0, 0)
        var finalTouch: CGPoint = CGPointMake(0, 0)
        var waitForEnd: SKAction = SKAction()
        
        
        let boss1: Boss1 = Boss1(imageNamed: "creatureCircle2.png")
        let boss2: Boss2 = Boss2(imageNamed: "creatureCircle2.png")
        override func didMoveToView(view: SKView) {
            
            createSprite(baseSwipe, andWithPosition: CGPointMake(self.frame.size.width/2.0, self.frame.size.height * 3.0/20.0), andWithZPosition: 5.0, andWithString: "swipe", andWithSize: 4.0, andWithParent: self)
            baseSwipe.setUpChoices()
            baseSwipe.swipeStateC(state.currentSwipeState)
            
            
            
            player = Player(imageNamed: "playerRight1.png")
            player.isFacing = RIGHT
            player.changeDirection()
            player.returnToIdle()
            self.createSprite(player, andWithPosition: CGPointMake(self.player.position.x, self.frame.size.height/2 + 80), andWithZPosition: 2, andWithString: "player", andWithSize: 4, andWithParent: self)
            player.position = CGPointMake(self.frame.size.width/2 - 150, self.frame.size.height/2)
            player.startPosition = player.position
            //self.addSwiping()
            self.backgroundColor = UIColor.blackColor()
            self.backgroundColor = UIColor(red: 0.0, green: 107.0/255.0, blue: 0.0, alpha: 1.0)
            
            

            self.createEnemy()
            self.setUpProgress()
            
            highEnemy.Progress_bar.hidden = true
            midEnemy.Progress_bar.hidden = true
            lowEnemy.Progress_bar.hidden = true
            
            self.setUpTiles()
            
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(BattleScene.gameLoop), userInfo: nil, repeats: false)
            
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
        
        func setUpProgress(){
            self.createSprite(battleTimerBar, andWithPosition: CGPointMake(self.frame.size.width/2, self.frame.size.height * 0.95), andWithZPosition: 10, andWithString: "progress", andWithSize: 4, andWithParent: self)
            battleTimerBar.createBar(self.frame.size.width * 0.75, andHeight: 25.0, andType: timerProgress)
            battleTimerBar.updateBar(battleTimerBarFraction)
            NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(BattleScene.updateProgressTimer), userInfo: nil, repeats: false)
        }
        
        func updateProgressTimer(){
                if((lowEnemy.hidden == true || lowEnemy.name == "dud") && (midEnemy.hidden == true || midEnemy.name == "dud") && (highEnemy.hidden == true || highEnemy.name == "dud")){
                    
                }else if(wasKilledByADemonWhoToreItselfFreeFromAHumanSoul == false && allEnemiesDead == false){
                    battleTimerBarFraction -= 0.02
                }
                battleTimerBar.updateBar(battleTimerBarFraction)
            
            NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(BattleScene.updateProgressTimer), userInfo: nil, repeats: false)
        }
        
        func gameLoop() {
            

                highEnemy.Progress_bar.hidden = false
                midEnemy.Progress_bar.hidden = false
                lowEnemy.Progress_bar.hidden = false
            
            
            
            if(wasKilledByADemonWhoToreItselfFreeFromAHumanSoul == false){
                if(highEnemy.hidden == false && player.Health > 0){
                    self.enemyHighAttack()
                }
                if(midEnemy.hidden == false && player.Health > 0){
                    self.enemyMidAttack()
                }
                if(lowEnemy.hidden == false && player.Health > 0){
                    self.enemyLowAttack()
                }

                
                if((lowEnemy.hidden == true || lowEnemy.name == "dud") && (midEnemy.hidden == true || midEnemy.name == "dud") && (highEnemy.hidden == true || highEnemy.name == "dud")){
                    if(allEnemiesDead == false){
                        allEnemiesDead = true
                        print("victory")
                        self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({self.nextRound()})]))
                    }
                }else if(battleTimerBarFraction <= 0.0){
                    print("Yo u dead")
                    //print(player.Health)
                    //print(battleTimerBarFraction)
                   // player.Health = 100
                    battleTimerBarFraction = 1.0
                    self.createEnemy()
        
                    
                    //self.player.hidden = true
                    //self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({self.playerLost()})]))
                    
                }else if(player.Health <= 0){
                    wasKilledByADemonWhoToreItselfFreeFromAHumanSoul = true
                    self.playerLost()
                    
                }
            }
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(BattleScene.gameLoop), userInfo: nil, repeats: false)
        }
        func playerLost(){
            higEnemyOrder = 0
            midEnemyOrder = 0
            lowEnemyOrder = 0
            
            self.enumerateChildNodesWithName("tile"){
                node, stop in
                let node2: SKSpriteNode = node as! SKSpriteNode
                node2.texture = SKTexture(imageNamed: "tileBlack.png")
                node2.texture!.filteringMode = SKTextureFilteringMode.Nearest
            }
            DOD.removeFromParent()
            battleTimerBarFraction = 1.0
            player.hidden = true
            highEnemy.hidden = true
            midEnemy.hidden = true
            lowEnemy.hidden = true
            
            boss1.killMe()
            boss2.killMe()
            
            print("player died")
            
            //boss1.hidden = true
            //boss2.hidden = true
            
            battleTimerBar.hidden = true
            
            self.createSprite(GO, andWithPosition: CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 180), andWithZPosition: 2, andWithString: "go", andWithSize: 5, andWithParent: self)
            
            self.createSprite(deadPlayer, andWithPosition: CGPointMake(self.frame.size.width/2, self.frame.size.height/2), andWithZPosition: 2, andWithString: "go", andWithSize: 5, andWithParent: self)
            wasKilledByADemonWhoToreItselfFreeFromAHumanSoul = true
            self.runAction(SKAction.sequence([SKAction.waitForDuration(1.0), SKAction.runBlock({self.resetGame()})]))
        }
        func resetGame() {
            print("Game has been reset")
            
            //currentRound = 1
            //self.size = CGSizeMake(44, 44)
            
            //boss1.killMe()
            //boss2.killMe()
            //boss1.removeFromParent()
            //self.size = CGSizeMake(44, 44)
            
            self.destroyEnemies()
            self.createEnemy()
            
            GO.removeFromParent()
            GO.size = CGSizeMake(52, 7 )
            deadPlayer.removeFromParent()
            deadPlayer.size = CGSizeMake(22, 20)
            
            self.player.hidden = false
            self.player.isDefending = false
            
            self.player.Health = 100
            self.player.HP_bar.updateBar(1.0)
            
            battleTimerBarFraction = 1.0
            battleTimerBar.hidden = false
            
            baseSwipe.highEnemyKilled = false
            baseSwipe.midEnemyKilled = false
            baseSwipe.lowEnemyKilled = false
            
            wasKilledByADemonWhoToreItselfFreeFromAHumanSoul = false
            
            self.enumerateChildNodesWithName("tile"){
                node, stop in
                let node2: SKSpriteNode = node as! SKSpriteNode
                node2.texture = SKTexture(imageNamed: "tileDark.png")
                node2.texture!.filteringMode = SKTextureFilteringMode.Nearest
            }
            
        }
        func nextRound(){
            
            self.destroyEnemies()
            self.createEnemy()
            
            self.player.Health = self.player.Health + self.player.Health/0.25
            if(self.player.Health > 100){
                self.player.Health = 100
            }
            self.player.HP_bar.updateBar(self.player.Health/100.0)
            
            print("player advanced with health")
            print(player.Health)
            
            self.player.isDefending = false
            
            battleTimerBarFraction = 1.0
            battleTimerBar.hidden = false
            
            baseSwipe.highEnemyKilled = false
            baseSwipe.midEnemyKilled = false
            baseSwipe.lowEnemyKilled = false
            
            allEnemiesDead = false
        }
        
        func enemyHighAttack(){
            self.enumerateChildNodesWithName("BaseEnemy"){
                node, stop in
                let rNode: BaseEnemy = node as! BaseEnemy
                if(rNode.zPosition == self.highEnemyZPosition){
                    if(rNode.progressFraction >= 1.0){
                        //rNode.strikeAt(self.player.position)
                        //self.player.doDamage(rNode.Strength)
                        
                        if(rNode.type == SMALL_SHADOW){
                            self.player.doDamage(rNode.strikeAt(self.player.position, withPlayerMaxHealth: self.player.maxHealth), isEnemyDeadly: false)
                        }else{
                            self.player.doDamage(rNode.strikeAt(self.player.position, withPlayerMaxHealth: self.player.maxHealth), isEnemyDeadly: true)
                        }
                        rNode.progressFraction = 0.0
                    }
                }
            }
        }
        func enemyMidAttack() {
            self.enumerateChildNodesWithName("BaseEnemy"){
                node, stop in
                let rNode: BaseEnemy = node as! BaseEnemy
                if(rNode.zPosition == self.midEnemyZPosition){
                    if(rNode.progressFraction >= 1.0){
                        //rNode.strikeAt(self.player.position)
                        //self.player.doDamage(rNode.Strength)
                        
                        if(rNode.type == SMALL_SHADOW){
                            self.player.doDamage(rNode.strikeAt(self.player.position, withPlayerMaxHealth: self.player.maxHealth), isEnemyDeadly: false)
                        }else{
                            self.player.doDamage(rNode.strikeAt(self.player.position, withPlayerMaxHealth: self.player.maxHealth), isEnemyDeadly: true)
                        }
                        rNode.progressFraction = 0.0
                    }
                }
            }
        }
    
        func enemyLowAttack(){
            self.enumerateChildNodesWithName("BaseEnemy"){
                node, stop in
                let rNode: BaseEnemy = node as! BaseEnemy
                if(rNode.zPosition == self.lowEnemyZPosition){
                    if(rNode.progressFraction >= 1.0){
                        //rNode.strikeAt(self.player.position)
                        //self.player.doDamage(rNode.Strength)
                        
                        if(rNode.type == SMALL_SHADOW){
                            self.player.doDamage(rNode.strikeAt(self.player.position, withPlayerMaxHealth: self.player.maxHealth), isEnemyDeadly: false)
                        }else{
                            self.player.doDamage(rNode.strikeAt(self.player.position, withPlayerMaxHealth: self.player.maxHealth), isEnemyDeadly: true)
                        }
                        
                        rNode.progressFraction = 0.0
                    }
                }
            }
        }
        
        
        func createEnemy() {
            
            let cre1: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
            self.createSprite(cre1, andWithPosition: CGPointMake(self.frame.size.width/2 + 200 + CGFloat(75 * higEnemyOrder), self.frame.size.height/2 + 180), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
            
            let cre2: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
            self.createSprite(cre2, andWithPosition: CGPointMake(self.frame.size.width/2 + 200 + CGFloat(75 * midEnemyOrder), self.frame.size.height/2), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
            
            let cre3: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
            self.createSprite(cre3, andWithPosition: CGPointMake(self.frame.size.width/2 + 200 + CGFloat(75 * lowEnemyOrder), self.frame.size.height/2 - 180), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
            
    
                
            cre1.zPosition = CGFloat(highEnemyZPosition)
            cre2.zPosition = CGFloat(midEnemyZPosition)
            cre3.zPosition = CGFloat(lowEnemyZPosition)
            
            
            cre1.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: higEnemyOrder)
            cre2.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: midEnemyOrder)
            cre3.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: lowEnemyOrder)

            
            if(higEnemyOrder == 0){
                highEnemy = cre1
            }
            if(midEnemyOrder == 0){
                midEnemy = cre2
            }
            if(lowEnemyOrder == 0){
                lowEnemy = cre3
            }
            
            
            higEnemyOrder += 1
            midEnemyOrder += 1
            lowEnemyOrder += 1
            //highEnemy.begin(SHADOW, andWithStartValue: 0.0)
            //midEnemy.begin(SHADOW, andWithStartValue: 0.25)
            //lowEnemy.begin(SHADOW, andWithStartValue: 0.5)
    
    
        }
        func destroyEnemies(){
            print(midEnemy.name)
            self.enumerateChildNodesWithName("BaseEnemy"){
                node, stop in
                let rNode: BaseEnemy = node as! BaseEnemy
                rNode.removeAllActions()
                rNode.isCharging = false
                rNode.chargeCount = 3
                rNode.removeFromParent()
            }
            
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
            lowEnemy.removeFromParent()*/
        }
    
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            /* Called when a touch begins */
            
            for touch in touches {
                let location = touch.locationInNode(self)
                let touchedNode = self.nodeAtPoint(location)
                if(touchedNode.name == "home"){
                    touchedNode.name = "gone"
                    let nextScene = GameScene(size: self.size)
                    self.scene?.view?.presentScene(nextScene)
                }else{
                    initialTouch = location
                    
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
                self.pseudoSwipe()
            }
        }
        
        func pseudoSwipe(){
            if(initialTouch.x - finalTouch.x > 200 && player.isDefending == false){
                //print(initialTouch.x - finalTouch.x )
                print("swiped Left")
                player.isDefending = true
                player.dodge()
                
                baseSwipe.leftArrow.colorBlendFactor = 1.0
                baseSwipe.leftArrow.color = UIColor.redColor()
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.runBlock({self.baseSwipe.leftArrow.colorBlendFactor = 0.0})]))
                
            }else if(initialTouch.x - finalTouch.x < -200){
                //print(initialTouch.x - finalTouch.x )
                print("swiped right")
                //print(initialTouch.y - finalTouch.y)
                
                baseSwipe.rightArrow.colorBlendFactor = 1.0
                baseSwipe.rightArrow.color = UIColor.redColor()
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.runBlock({self.baseSwipe.rightArrow.colorBlendFactor = 0.0})]))
                
                if(initialTouch.y - finalTouch.y > 125){
                    print("Swiped down")
                    self.attackEnemy(lowEnemy)
                }else if(initialTouch.y - finalTouch.y < -125){
                    print("swiped up")
                    self.attackEnemy(highEnemy)
                }else{
                    self.attackEnemy(midEnemy)
                }
            }
        }
        
        override func update(currentTime: CFTimeInterval) {
            /* Called before each frame is rendered */
            if(timeBattleBegan == 0){
                timeBattleBegan = currentTime
            }
        }
        
        func handleSwipe(gesture: UIGestureRecognizer) {
            if(midEnemy.type != GOODSLIME){// && isMultiAttacking == false){
                if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                    switch state.currentTurn {
                    case .playersTurn:
                        //slimeSwipe.hidden = true
                        baseSwipe.hidden = false
                        //self.performPersonSwipe(swipeGesture)
                        break
                    case .slimesTurn:
                        print("slime")
                        //slimeSwipe.hidden = false
                        baseSwipe.hidden = true
                        //self.performSlimeSwipe(swipeGesture)
                        break
                    }
                }
            }
        }
        func attackEnemy(whichEnemy: BaseEnemy) {
            print("Attakc enemy")
            if(wasKilledByADemonWhoToreItselfFreeFromAHumanSoul == false){
                
                print("not boss")
                
                if(whichEnemy.zPosition == highEnemyZPosition){
                    if(whichEnemy.name != "dud" && whichEnemy.hidden == false){
                        player.strikeAt(UP, andWithBool: true)
                    }else{
                        player.strikeAt(UP, andWithBool: false)
                    }
                }else if(whichEnemy.zPosition == midEnemyZPosition){
                    if(whichEnemy.name != "dud" && whichEnemy.hidden == false){
                        player.strikeAt(RIGHT, andWithBool: true)
                    }else{
                        player.strikeAt(RIGHT, andWithBool: false)
                    }
                }else{
                    if(whichEnemy.name != "dud" && whichEnemy.hidden == false){
                        player.strikeAt(DOWN, andWithBool: true)
                    }else{
                        player.strikeAt(DOWN, andWithBool: false)
                    }
                }
                
                if(timeOfLastAttack != 0){
                    print("attack time")
                    var timeSinceAttack: Float = Float(timeOfLastUpdate - timeOfLastAttack) * 0.5
                    if(timeSinceAttack > 1.0){
                        timeSinceAttack = 1.0
                    }
                    let damage: Float = player.Strength/timeSinceAttack
                    if(whichEnemy.name != "dud" && whichEnemy.hidden == false){
                        self.doDamageDirectly(whichEnemy, withAttack: damage)
                    }
                    //print(Int(10 * (damage/player.Strength)))
                    
                    timeBonus.text = "Time Bonus: " + String(Int(10 * (damage/player.Strength)) - 10)
                }else{
                    if(whichEnemy.name != "dud" && whichEnemy.hidden == false){
                        self.doDamageDirectly(whichEnemy, withAttack: player.Strength)
                    }
                }
                
                timeOfLastAttack = timeOfLastUpdate
                state.currentSwipeState = swipeState.Base
                player.isDefending = false
                
                
            }else{
                print("no target")
            }
        }
        func doDamageDirectly(withEnemy: BaseEnemy, withAttack Attack: Float){
            //print(Attack)
            if(withEnemy.doDamage(Attack, withType: 1) == true){
                if(withEnemy.zPosition == lowEnemyZPosition){
                    baseSwipe.lowEnemyKilled = true
                    lowEnemyOrder -= 1
                    
                    self.enumerateChildNodesWithName("BaseEnemy"){
                        node, stop in
                        let rNode: BaseEnemy = node as! BaseEnemy
                        if(rNode.zPosition == self.lowEnemyZPosition){
                            rNode.positionInLine -= 1
                            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({rNode.position = CGPointMake(self.frame.size.width/2 + 200 + CGFloat(75 * rNode.positionInLine), rNode.position.y)})]))
                            if(rNode.positionInLine == 0){
                                self.lowEnemy = rNode
                            }
                        }
                    }
                }else if(withEnemy.zPosition == midEnemyZPosition){
                    baseSwipe.midEnemyKilled = true
                    midEnemyOrder -= 1
                    
                    self.enumerateChildNodesWithName("BaseEnemy"){
                        node, stop in
                        let rNode: BaseEnemy = node as! BaseEnemy
                        if(rNode.zPosition == self.midEnemyZPosition){
                            rNode.positionInLine -= 1
                            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({rNode.position = CGPointMake(self.frame.size.width/2 + 200 + CGFloat(75 * rNode.positionInLine), rNode.position.y)})]))
                            
                            if(rNode.positionInLine == 0){
                                self.midEnemy = rNode
                            }
                        }
                    }
                
                }else if(withEnemy.zPosition == highEnemyZPosition){
                    baseSwipe.highEnemyKilled = true
                    higEnemyOrder -= 1
                    
                    self.enumerateChildNodesWithName("BaseEnemy"){
                        node, stop in
                        let rNode: BaseEnemy = node as! BaseEnemy
                        if(rNode.zPosition == self.highEnemyZPosition){
                            rNode.positionInLine -= 1
                            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({rNode.position = CGPointMake(self.frame.size.width/2 + 200 + CGFloat(75 * rNode.positionInLine), rNode.position.y)})]))
                            if(rNode.positionInLine == 0){
                                self.highEnemy = rNode
                            }
                        }
                    }
                }
            }
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
