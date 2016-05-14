//
//  BattleMode.swift
//  No Time To...
//
//  Created by Justin Buergi on 5/1/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import SpriteKit
import AVFoundation

class BattleScene: SKScene {
    var backgroundMusicPlayer = AVAudioPlayer()
    
    let lowEnemyZPosition: CGFloat = 6
    let midEnemyZPosition: CGFloat = 7
    let highEnemyZPosition: CGFloat = 5
    
    var player: Player!
    var state: StateHolder = StateHolder()
    
    //var baseSwipe: Swipe = Swipe(imageNamed: "choicesB.png")
    var baseSwipe: primeSwipe = primeSwipe(imageNamed: "baseChoices.png")
    
    //var swipeUpGesture = UISwipeGestureRecognizer()
    //var swipeDownGesture = UISwipeGestureRecognizer()
    //var swipeLeftGesture = UISwipeGestureRecognizer()
    //var swipeRightGesture = UISwipeGestureRecognizer()
    
    var currentLevel: Int = 1
    var currentRound: Int = 1
    
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
    
    var swipeNode: SKSpriteNode = SKSpriteNode(imageNamed: "slide.png")
    var swipeAction: SKAction = SKAction()
    var swipeBoolDone: Bool = false
    
    var allEnemiesDead = false
    
    
    var initialTouch: CGPoint = CGPointMake(0, 0)
    var finalTouch: CGPoint = CGPointMake(0, 0)
    var waitForEnd: SKAction = SKAction()
    
    
    let boss1: Boss1 = Boss1(imageNamed: "creatureCircle2.png")
    let boss2: Boss2 = Boss2(imageNamed: "creatureCircle2.png")
    override func didMoveToView(view: SKView) {
        print("Current level is")
        print("Current level is")
        print("Current level is")
        print(currentLevel)
        
        currentRound = 1
        
        createSprite(baseSwipe, andWithPosition: CGPointMake(self.frame.size.width/2.0, self.frame.size.height * 3.0/20.0), andWithZPosition: 15.0, andWithString: "swipe", andWithSize: 4.0, andWithParent: self)
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
        
 
        if(currentLevel == 1){
            self.createSprite(swipeNode, andWithPosition: CGPointMake(player.position.x, self.frame.size.height/2), andWithZPosition: 25, andWithString: "swipe", andWithSize: 4, andWithParent: self)
        
            swipeAction = SKAction.repeatActionForever(SKAction.sequence([
                SKAction.moveToX(self.frame.size.width/2 + 140, duration: 1.2),
                SKAction.waitForDuration(0.2),
                SKAction.runBlock({self.swipeNode.hidden = true}),
                SKAction.waitForDuration(0.15),
                SKAction.runBlock({self.swipeNode.position = CGPointMake(self.player.position.x, self.frame.size.height/2)}),
                SKAction.runBlock({self.swipeNode.hidden = false}),
                SKAction.waitForDuration(0.05),
                SKAction.waitForDuration(0.2),
                
            ]))
            swipeNode.runAction(swipeAction)
        }else{
            swipeBoolDone = true
        }
        
        //let HP: ProgressBar = ProgressBar(imageNamed: "black.png")
        //self.createSprite(HP, andWithPosition: CGPointMake(self.frame.size.width/2, self.frame.size.height/2), andWithZPosition: 10, andWithString: "HP", andWithSize: 3, andWithParent: self)
        // HP.createBar(100.0, andHeight: 25.0)
        
        //self.runAction(SKAction.sequence([SKAction.runBlock({HP.updateBar(0.9)}), SKAction.waitForDuration(0.25),    SKAction.runBlock({HP.updateBar(0.8)}), SKAction.waitForDuration(0.25),  SKAction.runBlock({HP.updateBar(0.7)}), SKAction.waitForDuration(0.25),  SKAction.runBlock({HP.updateBar(0.6)}), SKAction.waitForDuration(0.25), SKAction.runBlock({HP.updateBar(0.5)}), SKAction.waitForDuration(0.25),  SKAction.runBlock({HP.updateBar(0.4)}), SKAction.waitForDuration(0.25),   SKAction.runBlock({HP.updateBar(0.2)}), SKAction.waitForDuration(0.25),  SKAction.runBlock({HP.updateBar(0.1)}), SKAction.waitForDuration(0.25),  SKAction.runBlock({HP.updateBar(0.0)}), SKAction.waitForDuration(0.25), SKAction.runBlock({HP.updateBar(-0.1)}), SKAction.waitForDuration(0.25)   ]))
        self.createEnemy()
        self.setUpProgress()
        
        highEnemy.Progress_bar.hidden = true
        midEnemy.Progress_bar.hidden = true
        lowEnemy.Progress_bar.hidden = true
        
        self.setUpTiles()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(BattleScene.gameLoop), userInfo: nil, repeats: false)

        let home = SKSpriteNode(imageNamed: "house.png")
        self.createSprite(home, andWithPosition: CGPointMake(self.frame.size.width * 0.95, self.frame.size.height * 0.95), andWithZPosition: 20, andWithString: "home", andWithSize: 2, andWithParent: self)
        
        
        self.backgroundMusicPlayer("trueBattleMusic.mp3")
        
    }
    func createBossTiny() {
        let head: SKSpriteNode = SKSpriteNode(imageNamed: "creatureCircle2.png")
        self.createSprite(head, andWithPosition: CGPointMake(self.frame.size.width - 200, self.frame.size.height/2), andWithZPosition: 2, andWithString: "boss1", andWithSize: 4, andWithParent: self)
        
        let nodeC: transformTextureLimb = transformTextureLimb(imageNamed: "creatureCircle2.png")
        head.texture = nodeC.texture
        
        self.runAction(
            SKAction.sequence([
                SKAction.waitForDuration(1.5),
                SKAction.repeatAction(SKAction.sequence([
                    SKAction.waitForDuration(0.25),
                    SKAction.runBlock({nodeC._collapsePrime()}),
                    SKAction.runBlock({head.texture = nodeC.texture}),
                    SKAction.runBlock({head.texture!.filteringMode = SKTextureFilteringMode.Nearest}),

                    ]), count: 11)
                ]))
        
        
    }
    
    func createBossParts(){
        boss2.Health_Top = 150.0
        boss2.Health_Bottom = 150.0
        boss2.bottomHeadDead = false
        boss2.topHeadDead = false
        
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
        if(currentLevel == 1){
            self.createSprite(boss1, andWithPosition: CGPointMake(self.frame.size.width, self.frame.size.height/2), andWithZPosition: 2, andWithString: "boss1", andWithSize: 4, andWithParent: self)
            
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({            self.boss1.canIPlzHaveAMomentToPutMymakeupOn = true})]))
        }else{
            
            self.createSprite(boss2, andWithPosition: CGPointMake(self.frame.size.width, self.frame.size.height/2), andWithZPosition: 2, andWithString: "boss2", andWithSize: 4, andWithParent: self)
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({            self.boss2.canIPlzHaveAMomentToPutMymakeupOn = true})]))
        }
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
        if(currentRound != 4 && currentRound != 5){
            if((lowEnemy.hidden == true || lowEnemy.name == "dud") && (midEnemy.hidden == true || midEnemy.name == "dud") && (highEnemy.hidden == true || highEnemy.name == "dud")){
                
            }else if(swipeBoolDone  == true && wasKilledByADemonWhoToreItselfFreeFromAHumanSoul == false && allEnemiesDead == false){
                battleTimerBarFraction -= 0.02
            }
            battleTimerBar.updateBar(battleTimerBarFraction)
        }
        NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(BattleScene.updateProgressTimer), userInfo: nil, repeats: false)
    }
    
    func gameLoop() {
        
        if(currentLevel == 2){
            print(boss2.name)
            print(boss2.Health_Top)
            print(boss2.Health_Bottom)
            boss1.canIPlzHaveAMomentToPutMymakeupOn =  false
        }
        if(swipeBoolDone == false){
            //highEnemy.Progress_bar.hidden = true
            //midEnemy.Progress_bar.hidden = true
            //lowEnemy.Progress_bar.hidden = true
            
            highEnemy.progressFraction = 0.0
            midEnemy.progressFraction = 0.0
            lowEnemy.progressFraction = 0.0
        }else{
            highEnemy.Progress_bar.hidden = false
            midEnemy.Progress_bar.hidden = false
            lowEnemy.Progress_bar.hidden = false
            
            highEnemy.isSwipeBoolBeingUsed = false
            midEnemy.isSwipeBoolBeingUsed =  false
            lowEnemy.isSwipeBoolBeingUsed = false
        }
        
        
        if(wasKilledByADemonWhoToreItselfFreeFromAHumanSoul == false && swipeBoolDone == true){
            if(highEnemy.hidden == false && player.Health > 0){
                self.enemyHighAttack()
            }
            if(midEnemy.hidden == false && player.Health > 0){
                self.enemyMidAttack()
            }
            if(lowEnemy.hidden == false && player.Health > 0){
                self.enemyLowAttack()
            }
            
            if(currentLevel == 1){
                if(currentRound == 4 && boss1.name != "dud" && player.Health > 0 && boss1.name != "did"){
                    if(boss1.progressFraction >= 1.0){
                        print("Strike")
                        boss1.strikeAt(player.position)
                        player.doDamage(boss1.Strength, isEnemyDeadly: true)
                        boss1.progressFraction = 0.0
                    }
                }
                if(boss1.name == "dud"){
                    boss1.name = "did"
                    self.runAction(SKAction.sequence([SKAction.waitForDuration(5.0), SKAction.runBlock({self.nextRound()})]))
                }
            }else if(currentLevel == 2){
                if(currentRound == 4 && boss2.name != "dud" && player.Health > 0 && boss2.name != "did"){
                    if(boss2.progressFraction_Top >= 1.0){
                        print("Strike")
                        boss2.strikeAt_Top(player.position)
                        player.doDamage(boss2.Strength, isEnemyDeadly: true)
                        boss2.progressFraction_Top = 0.0
                    }
                    
                    if(boss2.progressFraction_Bottom >= 1.0){
                        print("Strike")
                        boss2.strikeAt_Bottom(player.position)
                        player.doDamage(boss2.Strength, isEnemyDeadly: true)
                        boss2.progressFraction_Bottom = 0.0
                    }
                }
                if(boss2.name == "dud"){
                    print("killed enemy")
                    boss2.name = "did"
                    self.runAction(SKAction.sequence([SKAction.waitForDuration(2.5), SKAction.runBlock({self.boss2.killMe()})]))

                    //boss2.killMe()
                    self.runAction(SKAction.sequence([SKAction.waitForDuration(5.0), SKAction.runBlock({self.nextRound()})]))
                    
                }
            }
            
            if((lowEnemy.hidden == true || lowEnemy.name == "dud") && (midEnemy.hidden == true || midEnemy.name == "dud") && (highEnemy.hidden == true || highEnemy.name == "dud")){
                if(allEnemiesDead == false){
                    allEnemiesDead = true
                    print("victory")
                    self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({self.nextRound()})]))
                }
            }else if(player.Health <= 0 || battleTimerBarFraction <= 0.0){
                print("Yo u dead")
                print(player.Health)
                print(battleTimerBarFraction)
                player.Health = 100
                battleTimerBarFraction = 0.0
                wasKilledByADemonWhoToreItselfFreeFromAHumanSoul = true
                // self.playerLost()
                
                self.player.hidden = true
                self.runAction(SKAction.sequence([SKAction.waitForDuration(0.75), SKAction.runBlock({self.playerLost()})]))
                
            }
        }
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(BattleScene.gameLoop), userInfo: nil, repeats: false)
    }
    func playerLost(){
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
        currentRound+=1
        
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
        if(highEnemy.progressFraction >= 1.0){
            //highEnemy.strikeAt(player.position)
            //player.doDamage(highEnemy.Strength)
            if(highEnemy.type == SMALL_SHADOW){
                player.doDamage(highEnemy.strikeAt(player.position, withPlayerMaxHealth: player.maxHealth), isEnemyDeadly: false)
            }else{
                player.doDamage(highEnemy.strikeAt(player.position, withPlayerMaxHealth: player.maxHealth), isEnemyDeadly: true)
            }
            
            highEnemy.progressFraction = 0.0
        }
    }
    func enemyMidAttack() {
        if(midEnemy.progressFraction >= 1.0){
            //midEnemy.strikeAt(player.position)
            //player.doDamage(midEnemy.Strength)
            if(midEnemy.type == SMALL_SHADOW){
                player.doDamage(midEnemy.strikeAt(player.position, withPlayerMaxHealth: player.maxHealth), isEnemyDeadly: false)
            }else{
                player.doDamage(midEnemy.strikeAt(player.position, withPlayerMaxHealth: player.maxHealth), isEnemyDeadly: true)
            }
            
            midEnemy.progressFraction = 0.0
        }
    }
    func enemyLowAttack(){
        if(lowEnemy.progressFraction >= 1.0){
            //lowEnemy.strikeAt(player.position)
            //player.doDamage(lowEnemy.Strength)
            if(lowEnemy.type == SMALL_SHADOW){
                player.doDamage(lowEnemy.strikeAt(player.position, withPlayerMaxHealth: player.maxHealth), isEnemyDeadly: false)
            }else{
                player.doDamage(lowEnemy.strikeAt(player.position, withPlayerMaxHealth: player.maxHealth), isEnemyDeadly: true)
            }
            
            lowEnemy.progressFraction = 0.0
        }
    }
    
    
    func createEnemy() {
        if(currentLevel == 1 || currentLevel == 2){

            let cre1: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
            self.createSprite(cre1, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2 + 180), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
        
            let cre2: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
            self.createSprite(cre2, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
        
            let cre3: BaseEnemy = BaseEnemy(imageNamed: "fitCreature.png")
            self.createSprite(cre3, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2 - 180), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
        
            highEnemy = cre1
            midEnemy = cre2
            lowEnemy = cre3
        
            highEnemy.zPosition = CGFloat(highEnemyZPosition)
            midEnemy.zPosition = CGFloat(midEnemyZPosition)
            lowEnemy.zPosition = CGFloat(lowEnemyZPosition)
        
            if(currentRound == 1){
                highEnemy.hidden = true
                lowEnemy.hidden = true
            
                baseSwipe.highEnemyKilled = true
                baseSwipe.lowEnemyKilled = true
            
                midEnemy.removeFromParent()
                let cre2: BaseEnemy = BaseEnemy(imageNamed: "scarecrow.png")
                self.createSprite(cre2, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2), andWithZPosition: midEnemyZPosition, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
                midEnemy = cre2
                midEnemy.begin(SCARECROW, andWithStartValue: 0.0, andWithPosInLine:  0)
       
            }else if(currentRound == 2){
                if(currentLevel == 1){
                    swipeNode = SKSpriteNode(imageNamed: "slide.png")
                    self.createSprite(swipeNode, andWithPosition: CGPointMake(player.position.x, self.frame.size.height/2), andWithZPosition: 25, andWithString: "swipe", andWithSize: 4, andWithParent: self)
                    swipeAction = SKAction.repeatActionForever(SKAction.sequence([
                        SKAction.moveTo(CGPointMake(self.frame.size.width/2 + 140, highEnemy.position.y), duration: 1.2),
               
                        SKAction.waitForDuration(0.2),
                        SKAction.runBlock({self.swipeNode.hidden = true}),
                        SKAction.waitForDuration(0.15),
                
                        SKAction.runBlock({self.swipeNode.position = CGPointMake(self.player.position.x, self.frame.size.height/2)}),
                        SKAction.runBlock({self.swipeNode.hidden = false}),
                        SKAction.waitForDuration(0.25),
                        SKAction.moveTo(CGPointMake(self.frame.size.width/2 + 140, lowEnemy.position.y), duration: 1.2),
                
                        SKAction.waitForDuration(0.2),
                        SKAction.runBlock({self.swipeNode.hidden = true}),
                        SKAction.waitForDuration(0.15),
                
                        SKAction.runBlock({self.swipeNode.position = CGPointMake(self.player.position.x, self.frame.size.height/2)}),
                        SKAction.runBlock({self.swipeNode.hidden = false}),
                        SKAction.waitForDuration(0.25),
                        ]))
                    swipeNode.runAction(swipeAction)
                    swipeBoolDone = false
                }
                highEnemy.hidden = false
                midEnemy.hidden = true
                lowEnemy.hidden  = false
            
                baseSwipe.highEnemyKilled = false
                baseSwipe.midEnemyKilled = true
                baseSwipe.lowEnemyKilled = false
            
                if(currentLevel == 1){
                    highEnemy.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
                    lowEnemy.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
                }else{
                    highEnemy.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
                    lowEnemy.begin(SHADOW, andWithStartValue: 0.25, andWithPosInLine: 0)
                }
            }else if(currentRound == 3){
                DOD.removeFromParent()
            
                highEnemy.hidden = false
                midEnemy.hidden = false
                lowEnemy.hidden = false
            
                baseSwipe.highEnemyKilled = false
                baseSwipe.midEnemyKilled = false
                baseSwipe.lowEnemyKilled = false
            
                if(currentLevel == 1){
                    highEnemy.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
                    midEnemy.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
                    lowEnemy.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
                }else{
                    highEnemy.begin(SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
                    midEnemy.begin(SHADOW, andWithStartValue: 0.25, andWithPosInLine: 0)
                    lowEnemy.begin(SHADOW, andWithStartValue: 0.5, andWithPosInLine: 0)
                
                }
                baseSwipe.special2Unlocked = true
            }else if(currentRound == 4){
                //slimeUnlocked = true
                //slime.hidden = false
                self.createBossParts()
            
                highEnemy.hidden = true
                midEnemy.hidden = false
                midEnemy.alpha = 0.0
                lowEnemy.hidden = true
            
                baseSwipe.highEnemyKilled = false
                baseSwipe.midEnemyKilled = false
                baseSwipe.lowEnemyKilled = false
            
                baseSwipe.special2Unlocked = true
        
            }else if(currentRound == 5 && currentLevel == 2){
                //self.runAction(SKAction.playSoundFileNamed("notDemon2.mp3", waitForCompletion: false))
                highEnemy.hidden = true
                lowEnemy.hidden = true
            
                baseSwipe.highEnemyKilled = true
                baseSwipe.lowEnemyKilled = true
            
                midEnemy.removeFromParent()
                let cre2: BaseEnemy = BaseEnemy(imageNamed: "bottom.png")
                self.createSprite(cre2, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
                midEnemy = cre2
            
                //midEnemy.type = GOODSLIME
                midEnemy.begin(GOODSLIME, andWithStartValue: 0.0, andWithPosInLine: 0)
            
                self.runAction(SKAction.sequence([SKAction.playSoundFileNamed("notDemon3.mp3", waitForCompletion: true), SKAction.waitForDuration(4.0), SKAction.runBlock({self.backgroundColor = UIColor(red: 0, green: 107/255, blue: 0, alpha: 1)}), SKAction.runBlock({self.nextRound()})]))
                // self.runAction(SKAction.sequence([SKAction.playSoundFileNamed("notDemon2.mp3", waitForCompletion: true), SKAction.waitForDuration(0.7), SKAction.runBlock({self.destroyEnemies()}), SKAction.runBlock({self.backgroundColor = UIColor(red: 0, green: 107/255, blue: 0, alpha: 1)}), SKAction.runBlock({self.currentRound+=1}), SKAction.runBlock({self.enterBattle()})]))
            
            }else{
                highEnemy.removeFromParent()
                midEnemy.removeFromParent()
                lowEnemy.removeFromParent()
            
                
                backgroundMusicPlayer.pause()
                backgroundMusicPlayer.stop()
                let nextScene = GameScene(size: self.size)
                self.runAction(SKAction.sequence([SKAction.waitForDuration(2.0), SKAction.runBlock({self.scene?.view?.presentScene(nextScene)})]))
            }
            
        }else if(currentLevel == 3){
            let cre1: BaseEnemy = BaseEnemy(imageNamed: "fitSmallCreature.png")
            self.createSprite(cre1, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2 + 180), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
            
            let cre2: BaseEnemy = BaseEnemy(imageNamed: "fitSmallCreature.png")
            self.createSprite(cre2, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
            
            let cre3: BaseEnemy = BaseEnemy(imageNamed: "fitSmallCreature.png")
            self.createSprite(cre3, andWithPosition: CGPointMake(self.frame.size.width/2 + 200, self.frame.size.height/2 - 180), andWithZPosition: 2, andWithString: "BaseEnemy", andWithSize: 4.0, andWithParent: self)
            
            highEnemy = cre1
            midEnemy = cre2
            lowEnemy = cre3
            
            highEnemy.zPosition = CGFloat(highEnemyZPosition)
            midEnemy.zPosition = CGFloat(midEnemyZPosition)
            lowEnemy.zPosition = CGFloat(lowEnemyZPosition)
            
            highEnemy.begin(SMALL_SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
            midEnemy.begin(SMALL_SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
            lowEnemy.begin(SMALL_SHADOW, andWithStartValue: 0.0, andWithPosInLine: 0)
        
        }
        
        
        //self.enemyAttack()
        
    }
    func destroyEnemies(){
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
    }
    
    
    
    func createWizardsHouse(){
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            if(touchedNode.name == "home"){
                backgroundMusicPlayer.pause()
                backgroundMusicPlayer.stop()
                
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
            baseSwipe.leftArrow.alpha = 1.0
            baseSwipe.dodgeSwipe.alpha = 1.0
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.1), SKAction.runBlock({self.baseSwipe.leftArrow.colorBlendFactor = 0.0}),
                SKAction.runBlock({self.baseSwipe.leftArrow.alpha = 0.9}),
                SKAction.runBlock({self.baseSwipe.dodgeSwipe.alpha = 0.9}),
                ]))
            
        }else if(initialTouch.x - finalTouch.x < -200){
            //print(initialTouch.x - finalTouch.x )
            print("swiped right")
            //print(initialTouch.y - finalTouch.y)
            
            baseSwipe.rightArrow.colorBlendFactor = 1.0
            baseSwipe.rightArrow.color = UIColor.redColor()
            baseSwipe.rightArrow.alpha = 1.0
            baseSwipe.attackSwipe.alpha = 1.0
            self.runAction(SKAction.sequence([SKAction.waitForDuration(0.1),
                SKAction.runBlock({self.baseSwipe.rightArrow.colorBlendFactor = 0.0}),
                SKAction.runBlock({self.baseSwipe.rightArrow.alpha = 0.9}),
                SKAction.runBlock({self.baseSwipe.attackSwipe.alpha = 0.9}),
                ]))
            
            if(initialTouch.y - finalTouch.y > 125){
                print("Swiped down")
                self.attackEnemy(lowEnemy)
            }else if(initialTouch.y - finalTouch.y < -125){
                print("swiped up")
                self.attackEnemy(highEnemy)
            }else{
                self.attackEnemy(midEnemy)
            }
            if(swipeBoolDone == false && currentLevel == 1){
                swipeNode.removeAllActions()
                swipeNode.removeFromParent()
                
                highEnemy.progressFraction = 0.0
                midEnemy.progressFraction = 0.0
                lowEnemy.progressFraction = 0.0
            }
            swipeBoolDone = true
            
            
            
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if(timeBattleBegan == 0){
            timeBattleBegan = currentTime
        }else if(currentRound == 5 && timeBattleEnded == 0 && currentLevel == 1){
            timeBattleEnded = currentTime
            print("Done")
            print(timeBattleBegan)
            print(timeBattleEnded)
            print(timeBattleEnded - timeBattleBegan)
            //50 = B
            
            let endLabel: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
            endLabel.text = "Level " + String(currentLevel) + " Completed"
            endLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
            endLabel.zPosition = 20
            endLabel.fontSize = 60
            self.addChild(endLabel)
            
            let endGrade: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
            endGrade.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 100)
            endGrade.fontSize = 60
            endGrade.zPosition = 20
            
            let battleTime = timeBattleEnded - timeBattleBegan
            if(currentLevel == 1){
                let def=NSUserDefaults()
                if(battleTime < 35){
                    endGrade.text = "S"
                    def.setInteger(1, forKey: "level1Grade")
                }else if(battleTime >= 35 && battleTime < 45){
                    endGrade.text = "A"
                    def.setInteger(2, forKey: "level1Grade")
                }else if(battleTime >= 45 && battleTime < 55){
                    endGrade.text = "B"
                    def.setInteger(3, forKey: "level1Grade")
                }else if(battleTime >= 55 && battleTime < 65){
                    endGrade.text = "C"
                    def.setInteger(4, forKey: "level1Grade")
                }else if(battleTime >= 65 && battleTime < 75){
                    endGrade.text = "D"
                    def.setInteger(5, forKey: "level1Grade")
                }else if(battleTime >= 75){
                    endGrade.text = "F"
                    def.setInteger(6, forKey: "level1Grade")
                }
            }
            self.addChild(endGrade)
            
        }else if(currentRound == 5 && timeBattleEnded == 0 && currentLevel == 2){
            timeBattleEnded = currentTime
            print("Done")
            print(timeBattleBegan)
            print(timeBattleEnded)
            print(timeBattleEnded - timeBattleBegan)
            //50 = B
            
            let endLabel: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
            endLabel.text = "Level " + String(currentLevel) + " Completed"
            endLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 300)
            endLabel.zPosition = 20
            endLabel.fontSize = 60
            self.addChild(endLabel)
            
            let endGrade: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
            endGrade.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 200)
            endGrade.fontSize = 60
            endGrade.zPosition = 20
            
            let battleTime = timeBattleEnded - timeBattleBegan

            let def=NSUserDefaults()
                if(battleTime < 35){
                    endGrade.text = "S"
                    def.setInteger(1, forKey: "level2Grade")
                }else if(battleTime >= 35 && battleTime < 45){
                    endGrade.text = "A"
                    def.setInteger(2, forKey: "level2Grade")
                }else if(battleTime >= 45 && battleTime < 55){
                    endGrade.text = "B"
                    def.setInteger(3, forKey: "level2Grade")
                }else if(battleTime >= 55 && battleTime < 65){
                    endGrade.text = "C"
                    def.setInteger(4, forKey: "level2Grade")
                }else if(battleTime >= 65 && battleTime < 75){
                    endGrade.text = "D"
                    def.setInteger(5, forKey: "level2Grade")
                }else if(battleTime >= 75){
                    endGrade.text = "F"
                    def.setInteger(6, forKey: "level2Grade")
                }
            
            self.addChild(endGrade)
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
        if(currentRound  != 4 && currentRound != 5 &&                     wasKilledByADemonWhoToreItselfFreeFromAHumanSoul == false){
            
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
            
            /*if(slimeUnlocked == true){
             currentTurn = .slimesTurn
             }*/
        }else if(currentRound == 4 && boss1.canIPlzHaveAMomentToPutMymakeupOn == true && currentLevel == 1){
            print(timeOfLastUpdate)
            //print(timeOfLastAttack)
            var timeSinceAttack: Float = Float(timeOfLastUpdate - timeOfLastAttack) * 0.5
            if(timeSinceAttack > 1.0){
                timeSinceAttack = 1.0
            }else if(timeSinceAttack == 0){
                timeSinceAttack = 1.0
            }
            //print("doDamage")
           // print(player.Strength)
            //print(timeSinceAttack)
            //print(player.Strength/timeSinceAttack)
            
            let damage: Float = player.Strength/timeSinceAttack
            // timeBonus.text = "Time Bonus: " + String(Int(10 * (damage/player.Strength)) - 10)
            
            
            timeOfLastAttack = timeOfLastUpdate
            state.currentSwipeState = swipeState.Base
            player.isDefending = false
            
            if(currentLevel == 1){
                if(whichEnemy.name != "did"){
                    if(whichEnemy.zPosition == highEnemyZPosition){
                        if(whichEnemy.name != "dud" && boss1.currentOrientation == UP){
                            player.strikeAt(UP, andWithBool: true)
                            boss1.doDamage(damage)
                        }else{
                            player.strikeAt(UP, andWithBool: false)
                        }
                    }else if(whichEnemy.zPosition == midEnemyZPosition){
                        if(whichEnemy.name != "dud" && boss1.currentOrientation == RIGHT){
                            player.strikeAt(RIGHT, andWithBool: true)
                            boss1.doDamage(damage)
                        }else{
                            player.strikeAt(RIGHT, andWithBool: false)
                        }
                    }else{
                        if(whichEnemy.name != "dud" && boss1.currentOrientation == DOWN){
                            player.strikeAt(DOWN, andWithBool: true)
                            boss1.doDamage(damage)
                        }else{
                            player.strikeAt(DOWN, andWithBool: false)
                        }
                    }
                }

            }
        }else if(currentRound == 4 && boss2.canIPlzHaveAMomentToPutMymakeupOn == true && currentLevel == 2){
            //print(timeOfLastUpdate)
            //print(timeOfLastAttack)
            print(boss2.Health_Top)
            print(boss2.Health_Bottom)
            print(boss2.canIPlzHaveAMomentToPutMymakeupOn)
            var timeSinceAttack: Float = Float(timeOfLastUpdate - timeOfLastAttack) * 0.5
            if(timeSinceAttack > 1.0){
                timeSinceAttack = 1.0
            }else if(timeSinceAttack == 0){
                timeSinceAttack = 1.0
            }
            //print("doDamage")
            //print(player.Strength)
            //print(timeSinceAttack)
            //print(player.Strength/timeSinceAttack)
            
            let damage: Float = player.Strength/timeSinceAttack
            // timeBonus.text = "Time Bonus: " + String(Int(10 * (damage/player.Strength)) - 10)
            
            
            timeOfLastAttack = timeOfLastUpdate
            state.currentSwipeState = swipeState.Base
            player.isDefending = false
            
            print("At level 2 with Name")
                print(whichEnemy.name)
                if(whichEnemy.name != "did"){
                    if(whichEnemy.zPosition == highEnemyZPosition){
                        if(whichEnemy.name != "dud"){
                            if(boss2.currentOrientation_Top == UP && boss2.topHeadDead == false){
                                player.strikeAt(UP, andWithBool: true)
                                boss2.doDamage_Top(damage)
                            }else{
                                player.strikeAt(UP, andWithBool: false)
                            }
                            
                            if(boss2.currentOrientation_Bottom == UP && boss2.bottomHeadDead == false){
                                player.strikeAt(UP, andWithBool: true)
                                boss2.doDamage_Bottom(damage)
                            }else{
                                player.strikeAt(UP, andWithBool: false)
                            }
                        }
                    }else if(whichEnemy.zPosition == midEnemyZPosition){
                        if(whichEnemy.name != "dud"){
                            if(boss2.currentOrientation_Top == RIGHT && boss2.topHeadDead == false){
                                player.strikeAt(RIGHT, andWithBool: true)
                                boss2.doDamage_Top(damage)
                            }else{
                                player.strikeAt(RIGHT, andWithBool: false)
                            }
                            
                            if(boss2.currentOrientation_Bottom == RIGHT && boss2.bottomHeadDead == false){
                                player.strikeAt(RIGHT, andWithBool: true)
                                boss2.doDamage_Bottom(damage)
                            }else{
                                player.strikeAt(RIGHT, andWithBool: false)
                            }
                        }
                        
                    }else{
                        if(whichEnemy.name != "dud"){
                            if(boss2.currentOrientation_Top == DOWN && boss2.topHeadDead == false){
                                player.strikeAt(DOWN, andWithBool: true)
                                boss2.doDamage_Top(damage)
                            }else{
                                player.strikeAt(DOWN, andWithBool: false)
                            }
                            
                            if(boss2.currentOrientation_Bottom == DOWN && boss2.bottomHeadDead == false){
                                player.strikeAt(DOWN, andWithBool: true)
                                boss2.doDamage_Bottom(damage)
                            }else{
                                player.strikeAt(DOWN, andWithBool: false)
                            }
                        }
                    }
                }
        }else{
            print("no target")
        }
    }
    func doDamageDirectly(withEnemy: BaseEnemy, withAttack Attack: Float){
        //print(Attack)
        if(withEnemy.doDamage(Attack, withType: 1) == true){
            if(withEnemy.zPosition == lowEnemyZPosition){
                baseSwipe.lowEnemyKilled = true
            }else if(withEnemy.zPosition == midEnemyZPosition){
                baseSwipe.midEnemyKilled = true
            }else if(withEnemy.zPosition == highEnemyZPosition){
                baseSwipe.highEnemyKilled = true
            }
        }
    }
 
    /*
     func addSwiping() {
     swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipe(_:)))
     swipeUpGesture.direction = UISwipeGestureRecognizerDirection.Up
     swipeUpGesture.delaysTouchesEnded = false
     view!.addGestureRecognizer(swipeUpGesture)
     
     swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipe(_:)))
     swipeDownGesture.direction = UISwipeGestureRecognizerDirection.Down
     swipeDownGesture.delaysTouchesEnded = false
     view!.addGestureRecognizer(swipeDownGesture)
     
     swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipe(_:)))
     swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.Left
     swipeLeftGesture.delaysTouchesEnded = false
     view!.addGestureRecognizer(swipeLeftGesture)
     
     swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipe(_:)))
     swipeRightGesture.direction = UISwipeGestureRecognizerDirection.Right
     swipeRightGesture.delaysTouchesEnded = false
     view!.addGestureRecognizer(swipeRightGesture)
     
     }
     
     func removeSwiping(){
     view?.removeGestureRecognizer(swipeUpGesture)
     view?.removeGestureRecognizer(swipeDownGesture)
     view?.removeGestureRecognizer(swipeLeftGesture)
     view?.removeGestureRecognizer(swipeRightGesture)
     
     }
     */
    func createSprite(withSprite:SKSpriteNode, andWithPosition aPosition:CGPoint, andWithZPosition zPos: CGFloat, andWithString theString: String, andWithSize aSize: CGFloat, andWithParent parent: AnyObject) {
        withSprite.size = (withSprite.texture?.size())!
        withSprite.position = aPosition
        withSprite.zPosition = zPos
        withSprite.name = theString
        
        withSprite.size = CGSizeMake(withSprite.size.width * aSize, withSprite.size.height * aSize)
        withSprite.texture!.filteringMode = SKTextureFilteringMode.Nearest
        
        parent.addChild(withSprite)
    }
    func backgroundMusicPlayer(fileName: String){
        let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
        guard let newURL = url else {
            print("found nothing")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.volume = 0.25
            //backgroundMusicPlayer.rate = 0.18
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError{
            print(error.description)
        }
    }
    
}
