//
//  ProgressBar.swift
//  No Time To...
//
//  Created by Justin Buergi on 4/23/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import Foundation
import SpriteKit
class ProgressBar: SKSpriteNode{
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var healthArray = [Bool?](count: 100 * 33 , repeatedValue: true)
    var currentFraction: Float = 0.0
    var type: UInt8 = enemyHealth
    init(imageNamed: String) {
        let imageText =  SKTexture(imageNamed: imageNamed)
        super.init(texture: imageText, color:UIColor.redColor(), size: imageText.size())
    }
    func createBar(width: CGFloat, andHeight height: CGFloat, andType withType: UInt8){
        type = withType
        self.size = CGSizeMake(width, height)
        healthArray = [Bool?](count: Int(width) * Int(height) , repeatedValue: true)
        self.update(Int(size.width), withHeght: Int(size.height), andArray: healthArray, withHealthFraction: 1.0)
        
    }
    func updateBar(withFraction: Float) {
        currentFraction = withFraction
        self.update(Int(size.width), withHeght: Int(size.height), andArray: healthArray, withHealthFraction: withFraction)
    }
    func update( width: Int, withHeght height: Int, andArray boW: [Bool?], withHealthFraction Health: Float) {
        //print(Health)
        let w = width
        let h = height
        
        var countTo5: Int = 0;
        var h2: Int = 0
        for i in 0.stride(to: boW.count, by: 1){
        //for(var i = 0; i < boW.count ; i+=1){
            if(countTo5 == width - 1){
                countTo5 = 0
                h2+=1
            }else{
                countTo5+=1
            }
            let currentWidthLength: Int = i - (h2 * width)
            let healthF: Float = Float(currentWidthLength)/Float(width)
            if(healthF <= Health && healthF >= 0) {
                healthArray[i] = true
            }else{
                healthArray[i] = false
            }
            //countTo5+=1
        }
        
        self.texture =  setUpTexture(healthArray, withWidth: w, withHeight: h)

        
       // self.runAction(SKAction.sequence([SKAction.waitForDuration(0.15), SKAction.runBlock({self._Drop1(width, withHeght: h, andArray: boW2, andZ: zPos + 1, andDropCountUp: dropCount + w + 2, andWithPosition: POSITION, andWithColor:  currentColor2 )})]))
    }
    
    func setUpTexture(boW: [Bool?], withWidth width: Int, withHeight height: Int)->SKTexture{
        let texture = SKMutableTexture(size: CGSize(width: width, height: height))
        texture.modifyPixelDataWithBlock({
            (bytes, len) in
            let d: UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>(bytes)
            for i in 0.stride(to: Int(len), by: 4){
            //for var i = 0; i < Int(len); i += 4 {
                if(self.type == playerHealth){
                    if(boW[i/4] == true){
                        d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                        d[i+1] = 255;//UInt8(self.randomValueBetween(0, high: 255))    // g
                        d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                        d[i+3] = 255 // a
                    }else{
                        d[i] = 255;//UInt8(self.randomValueBetween(0, high: 255))       // r
                        d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                        d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                        d[i+3] = 255 // a
                    }
                }else if(self.type == enemyHealth){
                    if(boW[i/4] == true){
                        d[i] = 255;//UInt8(self.randomValueBetween(0, high: 255))       // r
                        d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                        d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                        d[i+3] = 255 // a
                    }else{
                        d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                        d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                        d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                        d[i+3] = 255 // a
                    }
                }else if(self.type == enemyProgress){
                    if(self.currentFraction < 0.7){
                        if(boW[i/4] == true){
                            d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 255;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }else{
                            d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }
                    }else if(self.currentFraction < 0.9){
                        if(boW[i/4] == true){
                            d[i] = 155;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }else{
                            d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }
                    }else{
                        if(boW[i/4] == true){
                            d[i] = 100;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }else{
                            d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }
                        
                        
                    }
                }else if(self.type == timerProgress){
                    if(self.currentFraction > 0.3){
                        if(boW[i/4] == true){
                            d[i] = 255;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 255;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 255;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }else{
                            d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }
                    }else{
                        if(boW[i/4] == true){
                            d[i] = 255;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }else{
                            d[i] = 0;//UInt8(self.randomValueBetween(0, high: 255))       // r
                            d[i+1] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // g
                            d[i+2] = 0;//UInt8(self.randomValueBetween(0, high: 255))    // b
                            d[i+3] = 255 // a
                        }
                    
                    }
                }
            }
        })
        return texture
    }

}