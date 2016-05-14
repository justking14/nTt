//
//  GameScene.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/23/16.
//  Copyright (c) 2016 Justking Games. All rights reserved.
//

import SpriteKit
import Foundation
import AVFoundation



class GameScene: SKScene {
    //var backgroundMusicPlayer = AVAudioPlayer()
    /*
    func backgroundMusicPlayer(fileName: String){
        let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
        guard let newURL = url else {
            print("found nothing")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError{
            print(error.description)
        }
    }*/
    
    let lowEnemyZPosition: CGFloat = 6
    let midEnemyZPosition: CGFloat = 7
    let highEnemyZPosition: CGFloat = 5

    var player: Player!
    var state: StateHolder = StateHolder()
    
    var timeSinceLastUpdate: CFTimeInterval = 0
    var timeOfLastUpdate: CFTimeInterval = 0
    var timeOfLastAttack: CFTimeInterval = 0
    
    var timeBonus: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    
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
    
    let levelX: SKSpriteNode = SKSpriteNode(imageNamed: "creatureShadow.png")
    let levelY: SKSpriteNode = SKSpriteNode(imageNamed: "creatureShadow.png")
    let level1: SKSpriteNode = SKSpriteNode(imageNamed: "creatureShadow.png")
    let level2: SKSpriteNode = SKSpriteNode(imageNamed: "creatureShadow.png")
    let level3: SKSpriteNode = SKSpriteNode(imageNamed: "creatureShadow.png")
    
    override func didMoveToView(view: SKView) {
        
        
        player = Player(imageNamed: "playerRight1.png")
        player.isFacing = RIGHT
        player.changeDirection()
        player.returnToIdle()
        self.createSprite(player, andWithPosition: CGPointMake(self.player.position.x, self.frame.size.height/2 + 80), andWithZPosition: 12, andWithString: "player", andWithSize: 4, andWithParent: self)
        player.position = CGPointMake(self.frame.size.width/2 - 400, self.frame.size.height/2 + 75)
        player.startPosition = player.position
        //self.addSwiping()
        self.backgroundColor = UIColor.blackColor()
        self.backgroundColor = UIColor(red: 0.0, green: 107.0/255.0, blue: 0.0, alpha: 1.0)
        
        
        
        self.setUpTiles()
        self.createLevels()
        self.createLevelX()

        if(NSUserDefaults().integerForKey("level1Grade") == 1){
            //s
        }else         if(NSUserDefaults().integerForKey("level1Grade") == 2){
            //a
        }else         if(NSUserDefaults().integerForKey("level1Grade") == 3){
            //b
        }else         if(NSUserDefaults().integerForKey("level1Grade") == 4){
            //c
        }else         if(NSUserDefaults().integerForKey("level1Grade") == 5){
            //d
        }else         if(NSUserDefaults().integerForKey("level1Grade") == 6){
            //f
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameScene.gameLoop), userInfo: nil, repeats: false)
        
        //self.backgroundMusicPlayer("battleTune2.wav")
        //self.runAction(SKAction.repeatActionForever(SKAction.playSoundFileNamed("", waitForCompletion: true)))
    }

    func createLevels() {
        var currentLevel: Int = 1
        
        var currentString: String = "level" + String(currentLevel)
        self.createSprite(level1, andWithPosition: CGPointMake(player.position.x + 75, 440), andWithZPosition: 4, andWithString: currentString, andWithSize: 10, andWithParent: self)
        
        let level1Text: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        self.createText(level1Text, andWithPosition: CGPointMake(level1.position.x, level1.position.y + 50), andWithZPosition: 10, andWithString: currentString, andWithSize: 1, andWithParent: self, andWithText: "Level " + String(currentLevel))
       
        let level1Default: String = "level" + String(currentLevel) + "Grade"
        let level1Letter: SKSpriteNode = SKSpriteNode(imageNamed: "letterS.png")
        if(NSUserDefaults().integerForKey(level1Default) == 1){
            level1Letter.texture = SKTexture(imageNamed: "letterS.png")
        }else         if(NSUserDefaults().integerForKey(level1Default) == 2){
            level1Letter.texture = SKTexture(imageNamed: "letterA.png")
        }else         if(NSUserDefaults().integerForKey(level1Default) == 3){
            level1Letter.texture = SKTexture(imageNamed: "letterB.png")
        }else         if(NSUserDefaults().integerForKey(level1Default) == 4){
            level1Letter.texture = SKTexture(imageNamed: "letterC.png")
        }else         if(NSUserDefaults().integerForKey(level1Default) == 5){
            level1Letter.texture = SKTexture(imageNamed: "letterD.png")
        }else         if(NSUserDefaults().integerForKey(level1Default) == 6){
            level1Letter.texture = SKTexture(imageNamed: "letterE.png")
        }else{
            level1Letter.texture = SKTexture(imageNamed: "letterF.png")
        }
        self.createSprite(level1Letter, andWithPosition: level1.position, andWithZPosition: 11, andWithString: currentString, andWithSize: 3, andWithParent: self)
        
        
        
        currentLevel+=1
        currentString = "level" + String(currentLevel)
        self.createSprite(level2, andWithPosition: CGPointMake(player.position.x + 225, 440), andWithZPosition: 4, andWithString: currentString, andWithSize: 10, andWithParent: self)
        
        let level2Text: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        self.createText(level2Text, andWithPosition: CGPointMake(level2.position.x, level2.position.y + 50), andWithZPosition: 10, andWithString: currentString, andWithSize: 1, andWithParent: self, andWithText: "Level " + String(currentLevel))
        
        let level2Default: String = "level" + String(currentLevel) + "Grade"
        let level2Letter: SKSpriteNode = SKSpriteNode(imageNamed: "letterS.png")
        if(NSUserDefaults().integerForKey(level2Default) == 1){
            level2Letter.texture = SKTexture(imageNamed: "letterS.png")
        }else         if(NSUserDefaults().integerForKey(level2Default) == 2){
            level2Letter.texture = SKTexture(imageNamed: "letterA.png")
        }else         if(NSUserDefaults().integerForKey(level2Default) == 3){
            level2Letter.texture = SKTexture(imageNamed: "letterB.png")
        }else         if(NSUserDefaults().integerForKey(level2Default) == 4){
            level2Letter.texture = SKTexture(imageNamed: "letterC.png")
        }else         if(NSUserDefaults().integerForKey(level2Default) == 5){
            level2Letter.texture = SKTexture(imageNamed: "letterD.png")
        }else         if(NSUserDefaults().integerForKey(level2Default) == 6){
            level2Letter.texture = SKTexture(imageNamed: "letterE.png")
        }else{
            level2Letter.texture = SKTexture(imageNamed: "letterF.png")
        }
        self.createSprite(level2Letter, andWithPosition: level2.position, andWithZPosition: 11, andWithString: currentString, andWithSize: 3, andWithParent: self)
        
        
        currentLevel+=1
        currentString = "level" + String(currentLevel)
        self.createSprite(level3, andWithPosition: CGPointMake(player.position.x + 375, 440), andWithZPosition: 4, andWithString: currentString, andWithSize: 10, andWithParent: self)
        
        let level3Text: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        self.createText(level3Text, andWithPosition: CGPointMake(level3.position.x, level3.position.y + 50), andWithZPosition: 10, andWithString: currentString, andWithSize: 1, andWithParent: self, andWithText: "Level " + String(currentLevel))
        
        let level3Default: String = "level" + String(currentLevel) + "Grade"
        let level3Letter: SKSpriteNode = SKSpriteNode(imageNamed: "letterS.png")
        if(NSUserDefaults().integerForKey(level3Default) == 1){
            level3Letter.texture = SKTexture(imageNamed: "letterS.png")
        }else         if(NSUserDefaults().integerForKey(level3Default) == 2){
            level3Letter.texture = SKTexture(imageNamed: "letterA.png")
        }else         if(NSUserDefaults().integerForKey(level3Default) == 3){
            level3Letter.texture = SKTexture(imageNamed: "letterB.png")
        }else         if(NSUserDefaults().integerForKey(level3Default) == 4){
            level3Letter.texture = SKTexture(imageNamed: "letterC.png")
        }else         if(NSUserDefaults().integerForKey(level3Default) == 5){
            level3Letter.texture = SKTexture(imageNamed: "letterD.png")
        }else         if(NSUserDefaults().integerForKey(level3Default) == 6){
            level3Letter.texture = SKTexture(imageNamed: "letterE.png")
        }else{
            level3Letter.texture = SKTexture(imageNamed: "letterF.png")
        }
        self.createSprite(level3Letter, andWithPosition: level3.position, andWithZPosition: 11, andWithString: currentString, andWithSize: 3, andWithParent: self)
        
        
        
    }
    
    func createLevelX(){
        var currentString: String = "levelX"
        self.createSprite(levelX, andWithPosition: CGPointMake(player.position.x + 75, 240), andWithZPosition: 4, andWithString: currentString, andWithSize: 10, andWithParent: self)
        
        let level1Text: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        self.createText(level1Text, andWithPosition: CGPointMake(levelX.position.x, levelX.position.y + 50), andWithZPosition: 10, andWithString: currentString, andWithSize: 1, andWithParent: self, andWithText: "Level X")
        
        
        var currentStringY: String = "levelY"
        self.createSprite(levelY, andWithPosition: CGPointMake(player.position.x + 500, 240), andWithZPosition: 4, andWithString: currentStringY, andWithSize: 10, andWithParent: self)
        
        let level2Text: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        self.createText(level2Text, andWithPosition: CGPointMake(levelY.position.x, levelY.position.y + 50), andWithZPosition: 10, andWithString: currentStringY, andWithSize: 1, andWithParent: self, andWithText: "Level Y")
    
    }
    
    func setUpTiles(){
        for(var i = 0; i < Int(self.frame.size.width) + 44; i+=88){
            for(var j = 0; j < Int(self.frame.size.height) + 44; j+=88){

                if(j != 440){
                    let a: SKSpriteNode = SKSpriteNode(imageNamed: "tileDark.png")
                    self.createSprite(a, andWithPosition: CGPointMake(CGFloat(i), CGFloat(j)), andWithZPosition: 0, andWithString: "tile", andWithSize: 4, andWithParent: self)
                }else{
                    let a: SKSpriteNode = SKSpriteNode(imageNamed: "pathTile.png")
                    self.createSprite(a, andWithPosition: CGPointMake(CGFloat(i), CGFloat(j)), andWithZPosition: 0, andWithString: "tile", andWithSize: 4, andWithParent: self)
                }
            }
        }
    }
 
    
    func gameLoop() {
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameScene.gameLoop), userInfo: nil, repeats: false)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            // print("Begin")
            //print(touch.locationInNode(self))
            initialTouch = location
          
            if((touchedNode.name?.rangeOfString("level")) != nil){
                print(touchedNode.name)
                print(touchedNode.position)
                
                //backgroundMusicPlayer.numberOfLoops = 0
                //backgroundMusicPlayer.pause()
                if(touchedNode.name == "level1"){
                    print("1")
                    let def=NSUserDefaults()
                    def.setInteger(1, forKey: "currentLevel")
                }else if(touchedNode.name == "level2"){
                    print("2")
                    let def=NSUserDefaults()
                    def.setInteger(2, forKey: "currentLevel")
                }else if(touchedNode.name == "level3"){
                    print("3")
                    let def=NSUserDefaults()
                    def.setInteger(3, forKey: "currentLevel")
                }
                
                if(touchedNode.name != "levelX" && touchedNode.name != "levelY"){
                
                    let moveToTime: CGFloat = abs(self.player.position.x  - touchedNode.position.x)/150.0
                    self.player.runAction(self.player.walkRight)
                    self.player.texture!.filteringMode = SKTextureFilteringMode.Nearest
                    self.runAction(SKAction.sequence([SKAction.waitForDuration(0.05), SKAction.runBlock({                self.player.texture!.filteringMode = SKTextureFilteringMode.Nearest})]))
                
                    self.player.runAction(SKAction.sequence([SKAction.moveToX(touchedNode.position.x, duration: NSTimeInterval(moveToTime)), SKAction.runBlock({self.player.returnToIdle()})
                    ]))
                    let moveToTime2: Double = Double(moveToTime * CGFloat(1.2))
                    self.runAction(SKAction.sequence([SKAction.waitForDuration(moveToTime2), SKAction.runBlock({self.newLevel()})]))
                    
                    
                    self.runAction(SKAction.repeatAction(SKAction.playSoundFileNamed("step2.mp3", waitForCompletion: true), count: Int(moveToTime/1.15)))
                
                }else if(touchedNode.name == "levelX"){
                    
                    let moveToTime: CGFloat = abs(self.player.position.x  - touchedNode.position.x)/300.0 + abs(self.player.position.y  - touchedNode.position.y)/300.0
                    self.player.runAction(self.player.walkRight)
                    self.player.texture!.filteringMode = SKTextureFilteringMode.Nearest
                    self.runAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05), SKAction.runBlock({
                        self.player.texture!.filteringMode = SKTextureFilteringMode.Nearest})]))
                    self.player.runAction(SKAction.sequence([SKAction.moveTo(levelX.position, duration: NSTimeInterval(moveToTime)), SKAction.runBlock({self.player.returnToIdle()})
                        ]))
                    let moveToTime2: Double = Double(moveToTime * CGFloat(1.2))
                    self.runAction(SKAction.sequence([SKAction.waitForDuration(moveToTime2), SKAction.runBlock({self.newLevelX()})]))
                    
                    self.runAction(SKAction.repeatAction(SKAction.playSoundFileNamed("step2.mp3", waitForCompletion: true), count: Int(moveToTime/1.15)))

                }else if(touchedNode.name == "levelY"){
                    let moveToTime: CGFloat = abs(self.player.position.x  - touchedNode.position.x)/300.0 + abs(self.player.position.y  - touchedNode.position.y)/300.0
                    self.player.runAction(self.player.walkRight)
                    self.player.texture!.filteringMode = SKTextureFilteringMode.Nearest
                    self.runAction(SKAction.sequence([
                        SKAction.waitForDuration(0.05), SKAction.runBlock({
                            self.player.texture!.filteringMode = SKTextureFilteringMode.Nearest})]))
                    self.player.runAction(SKAction.sequence([SKAction.moveTo(levelY.position, duration: NSTimeInterval(moveToTime)), SKAction.runBlock({self.player.returnToIdle()})
                        ]))
                    let moveToTime2: Double = Double(moveToTime * CGFloat(1.2))
                    self.runAction(SKAction.sequence([SKAction.waitForDuration(moveToTime2), SKAction.runBlock({self.newLevelY()})]))
                    
                    self.runAction(SKAction.repeatAction(SKAction.playSoundFileNamed("step2.mp3", waitForCompletion: true), count: Int(moveToTime/1.15)))
                }
            }
        
        }
    }
    func newLevel(){
        //backgroundMusicPlayer.pause()
        //backgroundMusicPlayer.stop()
        let colorA1 = UIColor(red: 0.0, green: 107.0/255.0, blue: 0.0, alpha: 1.0)
        //let trans1: SKTransition = SKTransition.fadeWithDuration(1.0)
        let trans2: SKTransition = SKTransition.fadeWithColor(colorA1, duration: 1.0    )
        let nextScene = BattleScene(size: self.size)
        nextScene.currentLevel = NSUserDefaults().integerForKey("currentLevel")
        self.scene?.view?.presentScene(nextScene, transition: trans2)
        //self.scene?.view?.presentScene(nextScene)
    }
    func newLevelX(){
        //backgroundMusicPlayer.pause()
        //backgroundMusicPlayer.stop()
        
        let colorA1 = UIColor(red: 0.0, green: 107.0/255.0, blue: 0.0, alpha: 1.0)
        //let trans1: SKTransition = SKTransition.fadeWithDuration(1.0)
        let trans2: SKTransition = SKTransition.fadeWithColor(colorA1, duration: 1.0    )
        
        let nextScene = infiniteMode(size: self.size)
       // nextScene.currentLevel = NSUserDefaults().integerForKey("currentLevel")
        self.scene?.view?.presentScene(nextScene, transition: trans2)
    }
    func newLevelY(){
        //backgroundMusicPlayer.pause()
        //backgroundMusicPlayer.stop()
        
        let colorA1 = UIColor(red: 0.0, green: 107.0/255.0, blue: 0.0, alpha: 1.0)
        //let trans1: SKTransition = SKTransition.fadeWithDuration(1.0)
        let trans2: SKTransition = SKTransition.fadeWithColor(colorA1, duration: 1.0    )
        
        let nextScene = effectMode(size: self.size)
        // nextScene.currentLevel = NSUserDefaults().integerForKey("currentLevel")
        self.scene?.view?.presentScene(nextScene, transition: trans2)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            //print("mid")
            //print(touch.locationInNode(self))
            finalTouch = location
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            //print("end")
            //print(touch.locationInNode(self))
            finalTouch = location

        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    func createText(withSprite:SKLabelNode, andWithPosition aPosition:CGPoint, andWithZPosition zPos: CGFloat, andWithString theString: String, andWithSize aSize: CGFloat, andWithParent parent: AnyObject, andWithText text: String){
        
        withSprite.position = aPosition
        withSprite.zPosition = zPos
        withSprite.name = theString
        withSprite.fontSize = withSprite.fontSize * aSize
        withSprite.text = text
        parent.addChild(withSprite)
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
