//
//  GenerateTexture.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/25/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//
import SpriteKit
import Foundation


class enemyTexture: SKSpriteNode{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var oldColorArray: [Color?] = [Color?](count: 11 * 22, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0))

    init(imageNamed: String) {
        let imageText =  SKTexture(imageNamed: imageNamed)
        super.init(texture: imageText, color:UIColor.redColor(), size: imageText.size())


        
        //self.size = CGSizeMake(33, 666)
        oldColorArray = boWShadowColor
        self.createTextureFromArray(11, withHeight: 22, andBarray: boWWow, andWithPosition: CGPointMake(self.frame.size.width/2 - (7 * 4), self.frame.size.height/2))

    }


    var withArray: [Bool?] = [Bool?](count: 5, repeatedValue: false)

    var alphaCount: UInt8 = 250;
    var dropCount2: Int = 0

    var height: Int = 22
    
    var upHeight: Int = 0
    
    var currentXLocation: Int = 0
    
    func createTextureFromArray(width: Int, withHeight height: Int, andBarray: [Bool], andWithPosition POSITION: CGPoint){
        let w = width
        let h = height
    
        var boW: [Bool] = andBarray
    
        var boW2 = [Bool?](count: boW.count, repeatedValue: false)
        var iCount2: Int = 0;
        var countTo5: Int = 0
        for i in 0.stride(to: boW.count, by: 1){
        //    for(var i = 0; i < boW.count; i+=1){
            boW2[iCount2] = boW[i]
            iCount2+=1;
            countTo5+=1
        }
    
        var colorW2 = [Color?](count: boW.count, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0 ))
        iCount2 = 0
        countTo5 = 0
        for _ in 0.stride(to: boW.count, by: 1){
            //    for(var i = 0; i < boW.count; i+=1){
            colorW2[iCount2] = COLORBLUE
            iCount2+=1;
            countTo5+=1
        }
    
       // let bow3: [Bool?] = ScaleUp(boW2, withScale: 3, withWidth: w, andHeight: h)
    
    
        self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)
        withArray = boW2
        //self.shatter(width, withHeght: height, andArray: boW2, andZ: 10, andDropCountUp: 0, andWithPosition: CGPointMake(self.frame.size.width * 0.75, self.frame.size.height/2))
        
        // self.ScaleUp(boW2, withScale: 15, withWidth: width, andHeight: height)
    
    }
     func dropPrime() {
        let w = 11//width
        let h = height

        
        var boW: [Bool?] = withArray
        
        var boW2 = [Bool?](count: boW.count + w , repeatedValue: false)
        var currentColor2 = [Color?](count: boW.count + w, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0 ))
        
        
        var iCount2: Int = 0;
        var countTo5: Int = 0;
        for i in 0.stride(to: boW.count, by: 1){
            if(i <= dropCount2){
                boW2[iCount2] = boW[i]
                currentColor2[iCount2] = oldColorArray[iCount2]
            }else{
                boW2[iCount2 + w] = boW[i]
                currentColor2[iCount2 + w] = oldColorArray[i]
            }
            iCount2+=1;
            countTo5+=1
        }
        
        withArray = boW2
        //let randomDirection = randomValueBetween(15, high: 30)
        dropCount2 += Int((Double(w) * 1.5) + 2)
        height+=1
       // let bow3: [Bool?] = ScaleUp(boW2, withScale: 4, withWidth: w, andHeight: h)
        oldColorArray = currentColor2
        
        
        self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)
        if(Int(self.alphaCount) - 15 >= 0){
            self.alphaCount -= 2
        }else{
            self.alphaCount = 0
        }
        
        //self.runAction(SKAction.sequence([SKAction.waitForDuration(0.15), SKAction.runBlock({self._Drop1(width, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + w + 2, andWithPosition: POSITION, andWithColor:  currentColor2 )})]))
        
        
    }
    
    
    func shatterPrime() {

        let w = 11
        let h = 22
        var boW: [Bool?] = withArray
        
        var color2 = [Color?](count: oldColorArray.count, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0))

        var directionArray: [direction?] = [direction?](count: boW.count , repeatedValue: direction.Nothing)
        
        var boW2 = [Bool?](count: boW.count , repeatedValue: true)
        boW2 = boW
        for i in 0.stride(to: boW.count, by: 1){
            let randomDirection = randomValueBetween(0, high: 50)
            if(randomDirection < 5){
                directionArray[i] = direction.North
            }else if(randomDirection >= 5 && randomDirection < 10){
                directionArray[i] = direction.South
            }else if(randomDirection >= 10 && randomDirection < 15){
                directionArray[i] = direction.Left
            }else if randomDirection < 20{
                directionArray[i] = direction.Right
            }
        }
        
        for i in 0.stride(to: boW.count, by: 1){
            if(directionArray[i] == direction.North && i + w < boW2.count){
                boW2[i] = false
                boW2[i + w] = boW[i]
                
                color2[i] = CLEAR
                color2[i + w] = oldColorArray[i]
                //directionArray[i + w] = directArray[i]
            }else if(directionArray[i] == direction.South && i - w > 0){
                boW2[i] = false
                boW2[i - w] = boW[i]
                
                color2[i] = CLEAR
                color2[i - w] = oldColorArray[i]
                //directionArray[i - w] = directArray[i]
            }else if(directionArray[i] == direction.Left && i - 1 > 0){
                boW2[i] = false
                boW2[i - 1] = boW[i]
                
                color2[i] = CLEAR
                color2[i - 1] = oldColorArray[i]
                //directionArray[i - 1] = directArray[i]
            }else if(directionArray[i] == direction.Right && i + 1 < boW2.count){
                boW2[i] = false
                boW2[i + 1] = boW[i]
                
                color2[i] = CLEAR
                color2[i + 1] = oldColorArray[i]
                //directionArray[i + 1] = directArray[i]
            }
        }
        
        
       // let bow3: [Bool?] = ScaleUp(boW2, withScale: 4, withWidth: w, andHeight: h)
        
        
        self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)

        withArray = boW2
        oldColorArray = color2
        if(Int(self.alphaCount) - 15 >= 0){
            self.alphaCount -= 15
        }else{
            self.alphaCount = 0
        }
    }
 
    
    func collapsePrime() {
        let w = 11
        let h = 22
        
        var boW: [Bool?] = withArray
        var boW2 = [Bool?](count: boW.count, repeatedValue: false)
        var color2 = [Color?](count: oldColorArray.count, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0))
        
        var iCount2: Int = 0;
        var countTo5: Int = 0
        var i2: Int = 0
        for _ in 0.stride(to: boW.count - h, by: 1){
            //for(var i = 0; i < boW.count - h; i+=1){
            if(countTo5 == w/2){
                boW2[iCount2 - 1] = boW[i2];
                color2[iCount2 - 1] = oldColorArray[i2]
                i2+=1
            }else if(countTo5 == w - 1){
                countTo5 = 0
                boW2[iCount2] = false
                color2[iCount2] = CLEAR
                iCount2+=1
            }
            boW2[iCount2] = boW[i2]
            color2[iCount2] = oldColorArray[i2]
            iCount2+=1;
            countTo5+=1
            i2+=1
        }
        if(dropCount2 < h){
            // for k in (width * height) - (width * dropCount).stride(to: boW.count, by: 1){
            for(var i = (w * h) - (w * dropCount2); i < boW2.count; i+=1){
                boW2[i - w] = boW2[i]
                boW2[i] = false
                color2[i - w] = oldColorArray[i]
                color2[i] = CLEAR
            }
        }
        
        withArray = boW2
        //let bow3: [Bool?] = ScaleUp(boW2, withScale: 4, withWidth: w, andHeight: h)
        self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)

        
        if(Int(self.alphaCount) - 75 >= 0){
            //self.alphaCount -= 75
        }else{
            //self.alphaCount = 0
        }
        dropCount2 += 1
        //self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.runBlock({self._collapse(w, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + 1, andWithPosition: POSITION)})]))
    }
    
    
    func stuffPrime() {
        let w = 11
        let h = 22
        
        var boW: [Bool?] = withArray
        var boW2 = [Bool?](count: boW.count, repeatedValue: false)
        
        var color2 = [Color?](count: oldColorArray.count, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0))
        
        var iCount2: Int = 0;
        var countTo5: Int = 0
        var i2: Int = 0
        var widthLocation: Int = 1
        for _ in 0.stride(to: boW.count, by: 1){
            boW2[iCount2] = boW[i2]
            color2[iCount2] = oldColorArray[i2]
            iCount2+=1;
            countTo5+=1
            i2+=1
        }
        
        var countDown: Int = 10
        for heightY in 0.stride(to: 22, by: 1){
            countDown = 10
            for widthX in 0.stride(to: 11, by: 1){

                boW2[widthX + (heightY * w)] = boW[countDown + (heightY * w)]
                color2[widthX + (heightY * w)] = oldColorArray[countDown + (heightY * w)]
                countDown -= 1
            }
        }
        withArray = boW2
        oldColorArray = color2

        //let bow3: [Bool?] = ScaleUp(boW2, withScale: 4, withWidth: w, andHeight: h)
        self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)
        
        if(Int(self.alphaCount) - 75 >= 0){
            //self.alphaCount -= 75
        }else{
            //self.alphaCount = 0
        }
        //dropCount2 += 1
        if(dropCount2 == w){
            //dropCount2 = 0
            upHeight += 1
        }
    }
    
    func dissapearPrime() {
        let w = 11
        let h = 22
        
        var boW: [Bool?] = withArray
        var boW2 = [Bool?](count: boW.count, repeatedValue: false)
        
        var color2 = [Color?](count: oldColorArray.count, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0))
        
        var iCount2: Int = 0;
        var countTo5: Int = 0
        var i2: Int = 0
        var widthLocation: Int = 1
        for _ in 0.stride(to: boW.count, by: 1){
            if(iCount2 > dropCount2){
                boW2[iCount2] = boW[i2]
                color2[iCount2] = oldColorArray[i2]
            }else{
                boW2[iCount2] = false
                color2[iCount2] = CLEAR
            }
            iCount2+=1;
            countTo5+=1
            i2+=1
        }
        
        withArray = boW2
        oldColorArray = color2
        
        //let bow3: [Bool?] = ScaleUp(boW2, withScale: 4, withWidth: w, andHeight: h)
        self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)
        
        if(Int(self.alphaCount) - 75 >= 0){
            //self.alphaCount -= 75
        }else{
            //self.alphaCount = 0
        }
        dropCount2 += 13
        if(dropCount2 == w){
            //dropCount2 = 0
            upHeight += 1
        }
    }
    
    func shatter(width: Int, withHeght height: Int, andArray boW: [Bool?], andZ zPos: Int, andDropCountUp dropCount: Int, andWithPosition POSITION: CGPoint) {
        let w = width
        let h = height
        
        var directionArray: [direction?] = [direction?](count: boW.count , repeatedValue: direction.North)
        
        var boW2 = [Bool?](count: boW.count , repeatedValue: true)
        boW2 = boW
        for i in 0.stride(to: boW.count, by: 1){
        //for(var i = 0; i < boW.count ; i+=1){
            let randomDirection = randomValueBetween(0, high: 20)
            if(randomDirection < 5){
                directionArray[i] = direction.North
            }else if(randomDirection >= 5 && randomDirection < 10){
                directionArray[i] = direction.South
            }else if(randomDirection >= 10 && randomDirection < 15){
                directionArray[i] = direction.Left
            }else{
                directionArray[i] = direction.Right
            }
        }
        
        for i in 0.stride(to: boW.count, by: 1){
 //       for(var i = 0; i < boW.count ; i+=1){
            if(directionArray[i] == direction.North && i + w < boW2.count){
                boW2[i] = false
                boW2[i + w] = boW[i]
                //directionArray[i + w] = directArray[i]
            }else if(directionArray[i] == direction.South && i - w > 0){
                boW2[i] = false
                boW2[i - w] = boW[i]
                //directionArray[i - w] = directArray[i]
            }else if(directionArray[i] == direction.Left && i - 1 > 0){
                boW2[i] = false
                boW2[i - 1] = boW[i]
                //directionArray[i - 1] = directArray[i]
            }else if(directionArray[i] == direction.Right && i + 1 < boW2.count){
                boW2[i] = false
                boW2[i + 1] = boW[i]
                //directionArray[i + 1] = directArray[i]
            }
        }
        
       
        self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)
        
        //let sprite = SKSpriteNode(texture: setUpTexture(boW2, withWidth: width, withHeight: h))
        //self.addChild(sprite)
        //sprite.zPosition = CGFloat(zPos + 1)
        //sprite.position = POSITION
        
        if(dropCount < 14){
            self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)

            //self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.runBlock({sprite.removeFromParent()}) ,  SKAction.runBlock({self.shatter(width, withHeght: height, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + 1, andWithPosition: POSITION)})]))
        }else{

        }
        
    }
    
    
    
    
func setUpTexture(boW: [Bool?], withWidth width: Int, withHeight height: Int)->SKTexture{
    let texture = SKMutableTexture(size: CGSize(width: width, height: height))
    texture.modifyPixelDataWithBlock({
        (bytes, len) in
        let d: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(bytes)
        for i in 0.stride(to: Int(len), by: 4){
        //for var i = 0; i < Int(len); i += 4 {
            if(boW[i/4] == true){
                d[i] = self.oldColorArray[i/4]!.RED;//UInt8(self.randomValueBetween(0, high: 255))       // r
                d[i+1] = (self.oldColorArray[i/4]?.GREEN)!;//UInt8(self.randomValueBetween(0, high: 255))    // g
                d[i+2] = (self.oldColorArray[i/4]?.BLUE)!;//UInt8(self.randomValueBetween(0, high: 255))    // b
                d[i+3] = self.alphaCount // a
            }else{
                d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                d[i+3] = 0 // a
            }
        }
    })
    return texture
}

 
func ScaleUp(boW: [Bool?], withScale scale: Int, withWidth w: Int, andHeight h: Int)->[Bool?]{
    var boW2 = [Bool?](count: boW.count * scale * scale , repeatedValue: false)
    var w2: Int = 0
    var h2: Int = 0
    //s3 s4  b3 b4
    //s1 s2  b1 b2
    let lineWidth = w * scale
    //s b //a3 a4  c3 c4
    //a c //a1 a2   c1 c2
    var iCount2: Int = 0;
    var countTo5: Int = 0;
    var firstTry: Bool = false
    for i in 0.stride(to: boW.count, by: 1){
    //for(var i = 0; i < boW.count ; i+=1){
        if((i + 1)%w == 0 && firstTry == true){
            h2+=1
            iCount2+=(lineWidth * (scale - 1))
        }
        firstTry = true
        for k in 0.stride(to: scale, by: 1){
        //for(var k = 0; k < scale; k+=1){
            for l in 0.stride(to: scale, by: 1){
            //for(var l = 0; l < scale ; l+=1){
                //boW2[iCount2 + (w * scale) + l] = boW[i]
                if(iCount2 + (lineWidth * k) + l < boW2.count){
                    boW2[iCount2 + (lineWidth * k) + l] = boW[i]
                }
                //boW2[iCount2 + k]     = boW[i]
            }
        }
        
        //boW2[iCount2] = boW[i]
        //currentColor2[iCount2] = currentColor[i]
        w2+=1
        iCount2+=scale;
        countTo5+=1
        
        
        
    }
    self.texture = setUpTexture(boW2, withWidth: w * scale, withHeight: h * scale)
    
    let sprite = SKSpriteNode(texture: setUpTexture(boW2, withWidth: w * scale, withHeight: h * scale))
    self.addChild(sprite)
    sprite.zPosition = CGFloat(20 + 1)
    //sprite.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - sprite.frame.size.height/2)
    
    
    
    
    return boW
}

private func _Drop1( width: Int, withHeght height: Int, andArray boW: [Bool?], andZ zPos: Int, andDropCountUp dropCount: Int, andWithPosition POSITION: CGPoint, andWithColor currentColor: [Color?] ) {
    let w = width
    let h = height + 1
    //let texture = SKMutableTexture(size: CGSize(width: w , height: h))
    var boW2 = [Bool?](count: boW.count + w , repeatedValue: false)
    var currentColor2 = [Color?](count: boW.count + w, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0 ))
    
    
    var iCount2: Int = 0;
    var countTo5: Int = 0;
    for i in 0.stride(to: boW.count, by: 1){
  //  for(var i = 0; i < boW.count ; i+=1){
        /*if(countTo5 == w/2){
         iCount2+=1;
         }else if(countTo5 == w - 1){
         countTo5 = 0
         //iCount2++
         }*/
        
        if(i <= dropCount){
            boW2[iCount2] = boW[i]
            currentColor2[iCount2] = currentColor[i]
        }else{
            boW2[iCount2 + w] = boW[i]
            currentColor2[iCount2 + w] = currentColor[i]
        }
        iCount2+=1;
        countTo5+=1
    }
    
    let sprite = SKSpriteNode(texture: setUpTexture(boW2, withWidth: w, withHeight: h))
    self.addChild(sprite)
    sprite.zPosition = CGFloat(zPos + 1)
    sprite.position = CGPointMake(POSITION.x, self.frame.size.height/2 - sprite.frame.size.height/2)
    
    self.runAction(SKAction.sequence([SKAction.waitForDuration(0.15), SKAction.runBlock({self._Drop1(width, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + w + 2, andWithPosition: POSITION, andWithColor:  currentColor2 )})]))
    
    //self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.runBlock({self._splitLikeALog(width, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + w + 2, andWithPosition: POSITION)})]))
    
    // self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.runBlock({self._newMutableTextureByCode34(w, withHeght: h, andArray: boW2, andZ: zPos + 1)})]))
    
    // if(dropCount > 1200){
    //   self.runAction(SKAction.sequence([SKAction.waitForDuration(0.15), SKAction.runBlock({self._newMutableTextureByDropping3(w, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount - w - 2)})]))
    // }else{
    // self.runAction(SKAction.sequence([SKAction.waitForDuration(0.15), SKAction.runBlock({self._newMutableTextureByDropping2(w, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + w + 2, andStopDropCount: stopCount + 2)})]))
    //}
    
}



func _splitLikeALog(width: Int, withHeght height: Int, andArray boW: [Bool?], andZ zPos: Int, andDropCountUp dropCount: Int, andWithPosition POSITION: CGPoint) {
    let w = width + 1
    let h = height + 1
    
    //let texture = SKMutableTexture(size: CGSize(width: w , height: h))
    
    var boW2 = [Bool?](count: boW.count + h + w, repeatedValue: false)
    var iCount2: Int = 0;
    var countTo5: Int = 0
    for i in 0.stride(to: boW.count, by: 1){
    //for(var i = 0; i < boW.count; i+=1){
        if(countTo5 == w/2){
            iCount2+=1;
        }else if(countTo5 == w - 1){
            countTo5 = 0
        }
        boW2[iCount2] = boW[i]
        iCount2+=1;
        countTo5+=1
    }
    
    let sprite = SKSpriteNode(texture: setUpTexture(boW2, withWidth: w, withHeight: h))
    self.addChild(sprite)
    sprite.zPosition = CGFloat(zPos + 1)
    sprite.position = CGPointMake(POSITION.x, self.frame.size.height/2 - sprite.frame.size.height/2)
    
    self.runAction(SKAction.sequence([SKAction.waitForDuration(0.15), SKAction.runBlock({self._splitLikeALog(w, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + w + 2, andWithPosition: POSITION)})]))
    
}
func _collapse(width: Int, withHeght height: Int, andArray boW: [Bool?], andZ zPos: Int, andDropCountUp dropCount: Int, andWithPosition POSITION: CGPoint) {
    let w = width
    let h = height
    
    
    //let texture = SKMutableTexture(size: CGSize(width: w , height: h))
    var boW2 = [Bool?](count: boW.count, repeatedValue: false)
    var iCount2: Int = 0;
    var countTo5: Int = 0
    var i2: Int = 0
    for _ in 0.stride(to: boW.count - h, by: 1){
    //for(var i = 0; i < boW.count - h; i+=1){
        if(countTo5 == w/2){
            boW2[iCount2 - 1] = boW[i2];
            i2+=1
        }else if(countTo5 == w - 1){
            countTo5 = 0
            boW2[iCount2] = false
            iCount2+=1
        }
        boW2[iCount2] = boW[i2]
        iCount2+=1;
        countTo5+=1
        i2+=1
    }
    if(dropCount < height){
       // for k in (width * height) - (width * dropCount).stride(to: boW.count, by: 1){
        for(var i = (width * height) - (width * dropCount); i < boW2.count; i+=1){
            boW2[i - w] = boW2[i]
            boW2[i] = false
        }
    }
    //abcdefg
    //1234567
    //if 4, 3 = d
    //move to e
    let sprite = SKSpriteNode(texture: setUpTexture(boW2, withWidth: w, withHeight: h))
    self.addChild(sprite)
    sprite.zPosition = CGFloat(zPos + 1)
    sprite.position = CGPointMake(POSITION.x, self.frame.size.height/2 - sprite.frame.size.height/2)
    
    self.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), SKAction.runBlock({self._collapse(w, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + 1, andWithPosition: POSITION)})]))
}

    
    func generateBGSprite(withSprite: SKSpriteNode){
        let txt3: SKTexture = withSprite.texture!
        let txt4: SKTexture = txt3.textureByGeneratingNormalMap()
        
        
        //var txt5: SKMutableTexture!
        //txt5.modifyPixelDataWithBlock(block: (UnsafeMutablePointer<Void>, Int) -> Void)
        
        
        
        let shader: SKShader = SKShader(fileNamed: "frag5.fsh")
        shader.uniforms = [
            SKUniform(name: "tex", texture: txt3),
            SKUniform(name: "norm", texture: txt4),
            SKUniform(name: "bnw", float: 0.0),
            SKUniform(name: "light", floatVector3: GLKVector3(v: (Float(self.frame.size.width/2), Float(self.frame.size.height/2.0), 0.5))),
            
            SKUniform(name: "withPosX", float: Float(withSprite.frame.minX)),
            SKUniform(name: "withPosY", float: Float(withSprite.frame.minY)),
            
            SKUniform(name: "withWidth", float: Float(withSprite.frame.size.width)),
            SKUniform(name: "withHeight", float: Float(withSprite.frame.size.height)),
        ]
        //node.shader = shader
        
        withSprite.runAction(SKAction.fadeAlphaTo(0.0, duration: 6.0))
        
    }
    
func randomValueBetween(low:Float,  high:Float)->Float {
    let lower : UInt32 = UInt32(low)
    let upper : UInt32 = UInt32(high)
    let randomNumber = arc4random_uniform(upper - lower) + lower
    return Float(randomNumber)
    
}

}