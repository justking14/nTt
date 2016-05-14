//
//  GenerateTexture.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/25/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//
import SpriteKit
import Foundation


class transformTexture: SKSpriteNode{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(imageNamed: String) {
        let imageText =  SKTexture(imageNamed: imageNamed)
        super.init(texture: imageText, color:UIColor.redColor(), size: imageText.size())



        withColorTransArray = boWNoC
        //self.size = CGSizeMake(33, 666)
        
        self.createTextureFromArray(11, withHeight: 22, andBarray: boWWow, andWithTTArray: boWNoBody, andWithPosition: CGPointMake(self.frame.size.width/2 - (7 * 4), self.frame.size.height/2))

    }


   


    var withArray: [Bool?] = [Bool?](count: 11 * 22, repeatedValue: false)

    var withTransArray: [Bool?] = [Bool?](count: 11 * 22, repeatedValue: false)
    
    var withArrayedAlready: [Bool] = [Bool](count: 11 * 22, repeatedValue: false)
    
    var withColorTransArray: [Color] = [Color](count: 11 * 22, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0))
    
    var alphaCount: UInt8 = 250;
    var transCount: UInt8 = 0;
    
    func createTextureFromArray(width: Int, withHeight height: Int, andBarray: [Bool], andWithTTArray: [Bool], andWithPosition POSITION: CGPoint){
        let w = width
        let h = height
    
        var boW: [Bool] = andBarray
    
        var boW2 = [Bool?](count: boW.count, repeatedValue: false)
        var iCount2: Int = 0;
        var countTo5: Int = 0
        for i in 0.stride(to: boW.count, by: 1){
        //for(var i = 0; i < boW.count; i+=1){
            boW2[iCount2] = boW[i]
            iCount2+=1;
            countTo5+=1
        }
        
        var boW4 = [Bool?](count: andWithTTArray.count, repeatedValue: false)
        iCount2 = 0;
        countTo5  = 0
        for i in 0.stride(to: boW.count, by: 1){
        //for(var i = 0; i < boW.count; i+=1){
            boW4[iCount2] = andWithTTArray[i]
            iCount2+=1;
            countTo5+=1
        }
        
        
        var colorW2 = [Color?](count: boW.count, repeatedValue: Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0 ))
        iCount2 = 0
        countTo5 = 0
        for _ in 0.stride(to: boW.count, by: 1){
      //  for(var i = 0; i < boW.count; i+=1){
            colorW2[iCount2] = COLORBLUE
            iCount2+=1;
            countTo5+=1
        }
    
        //var bow3: [Bool?] = ScaleUp(boW4, withScale: 3, withWidth: w, andHeight: h)
        self.texture = setUpTexture(boW2, withWidth: w, withHeight: h)
        
        withArray = boW2
        withTransArray = boW4
        
        //self.shatter(width, withHeght: height, andArray: boW2, andZ: 10, andDropCountUp: 0, andWithPosition: CGPointMake(self.frame.size.width * 0.75, self.frame.size.height/2))
        // self.ScaleUp(boW2, withScale: 15, withWidth: width, andHeight: height)
    }
    
    func shatterPrime() {
        let w = 11
        let h = 22
        var boW: [Bool?] = withArray
        var boWTrnsform: [Bool?] = withTransArray
        
        var boW2 = [Bool?](count: boW.count , repeatedValue: true)
        boW2 = boW
   
        
        var iCount2: Int = 0;
        for i in 0.stride(to: boW.count, by: 1){
       // for(var i = 0; i < boW.count; i+=1){
            boW2[iCount2] = boW[i]
            iCount2+=1;
        }
        let tC: Int = -Int(transCount/2)
        for testI in tC.stride(to: Int(transCount/2), by: 1){
            for testJ in tC.stride(to: Int(transCount/2), by: 1){
        //for(var testI: Int = -Int(transCount/2); testI < Int(transCount/2); testI+=1){
           // for(var testJ: Int = -Int(transCount/2); testJ < Int(transCount/2); testJ+=1){
          
                boW2[boW.count/2 - w/2 + testI + (w * testJ + 1)] =     boWTrnsform[boW.count/2 + testI + (w * testJ)]
                boW2[boW.count/2 - w/2 + testI + (w * (testJ  + 1) * 2)] = boWTrnsform[boW.count/2 + testI + (w * testJ * 2)]
                
                boW2[boW.count/2 + testJ + (w * testI)] =     boWTrnsform[boW.count/2 + testJ + (w * testI)]!
                boW2[boW.count/2 + testJ + (w * testI * 2)] = boWTrnsform[boW.count/2 + testJ + (w * testI * 2)]
                
                withArrayedAlready[boW.count/2 - w/2 + testI + (w * testJ + 1)] =  true
                withArrayedAlready[boW.count/2 - w/2 + testI + (w * (testJ  + 1) * 2)] = true
                withArrayedAlready[boW.count/2 + testJ + (w * testI)] =  true
                withArrayedAlready[boW.count/2 + testJ + (w * testI * 2)] = true
                
                
            }
        }
        if(transCount >= 10){
            boW2 = boWTrnsform
            withArray = boW2
            self.texture = setUpTexture2(boW2, withWidth: w, withHeight: h)
        }else{
            transCount += 1
            withArray = boW2
            self.texture = setUpTexture2(boW2, withWidth: w, withHeight: h)
        }
        
        //var bow3: [Bool?] = ScaleUp(boW2, withScale: 4, withWidth: w, andHeight: h)
    }
    
    
    func setUpTexture(boW: [Bool?], withWidth width: Int, withHeight height: Int)->SKTexture{
        let texture = SKMutableTexture(size: CGSize(width: width, height: height))
        texture.modifyPixelDataWithBlock({
            (bytes, len) in
            let d: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(bytes)
            for i in 0.stride(to: Int(len), by: 4){
            //for var i = 0; i < Int(len); i += 4 {
                if(boW[i/4] == true){
                    d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                    d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                    d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
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

    
    func setUpTexture2(boW: [Bool?], withWidth width: Int, withHeight height: Int)->SKTexture{
    let texture = SKMutableTexture(size: CGSize(width: width, height: height))
    texture.modifyPixelDataWithBlock({
        (bytes, len) in
        let d: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(bytes)
        for i in 0.stride(to: Int(len), by: 4){
        //for var i = 0; i < Int(len); i += 4 {
            if(boW[i/4] == true){
                if(self.withArrayedAlready[i/4] == true){
                    d[i]   = self.withColorTransArray[i/4].RED;//UInt8(self.randomValueBetween(0, high: 255))       // r
                    d[i+1] = self.withColorTransArray[i/4].GREEN;//UInt8(self.randomValueBetween(0, high: 255))    // g
                    d[i+2] = self.withColorTransArray[i/4].BLUE;//UInt8(self.randomValueBetween(0, high: 255))    // b
                    d[i+3] = self.alphaCount // a
                }else{
                    d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                    d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                    d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                    d[i+3] = 255 // a
                }
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
            for l in 0.stride(to: scale, by: 1){
        //for(var k = 0; k < scale; k+=1){
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