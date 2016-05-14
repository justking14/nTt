//
//  Constant.swift
//  TBS
//
//  Created by Justin Buergi on 4/1/16.
//  Copyright © 2016 Justking Games. All rights reserved.
//

import Foundation

let STOPPED: UInt8 = 0
let LEFT: UInt8 = 1
let RIGHT: UInt8 = 2
let UP: UInt8 = 3
let DOWN: UInt8 = 4


let SWORDSMAN: UInt8 = 1
let MAGE:      UInt8 = 2
let SLIME:     UInt8 = 3
let SHADOW:    UInt8 = 4
let GOODSLIME: UInt8 = 5
let SCARECROW: UInt8 = 6
let BOSS1:     UInt8 = 7
let SMALL_SHADOW: UInt8 = 8

let playerHealth: UInt8 = 0
let enemyHealth: UInt8 = 1
let enemyProgress: UInt8 = 2
let timerProgress: UInt8 = 3


let boWWow: [Bool] = [
    false, false, false, false, false, false, false, false, true, false, false,
    false, false, false, false, false, false, false, false, true, true, false,
    false, false, false, false, false, false, false, false, true, true, true,
    false, false, false, true,  false,  true, false, false, false, true, true,
    false, false, true,  true,  false, true, true, false, true, true, true,
    false, false, true,  true,   false, true, true, true, true, true, true,
    false, false, true,  true,   true, true, true, true, true, true, true,
    false, false, true,  true,   true, true, true, true, true, true, true,
    false, false, true,  true,   true, true, true, true, true, true, false,
    false, false, true,  true,   true, true, true, true, true, false, false,
    false, false, false,  true,   true, true, true, true, false, false, false,
    false, false, false,  false,   true, true, true, false, false, false, false,
    false, false, false,  true,   true, true, true, true, false, false, false,
    
    false, true, true,  true,   true, true, true, true, true, true, false,
    false, true, true,  true,   true, true, true, true, true, true, false,
    
    true, true, true,  true,   true, true, true, true, true, true, true,
    true, true, true,  true,   true, true, true, true, true, true, true,
    true, true, true,  true,   true, true, true, true, true, true, true,
    true, true, true,  true,  true, true, true, true, true, true, true,
    true, true, true,  true,  true, true, true, true, true, true, true,
    
    false, true, true,  true,   true, true, true, true, true, true, false,
    false, false, true,  true,   true, true, true, true, true, false, false,
]


let boWNoHead: [Bool] = [
    false, false, false, false,  false, false, true,  true,   true,   false,   false,
    false, false, false, true,   true,  false, false, true,  true,   true,   false,
    false, false, true,  true,   false, false, true,  true,  true,   true,   true,
    false, true,  true,  true,   true,  false, false, true,  true,   true,   true,
    true,  true,  true,  true,   false, false, true,  true,  true,   true,   true,
    true,  true,  true,  true,   true,  false, false, true,  false,  true,   true,
    true,  true,  true,  true,   false, false, true,  false, false,  false,  true,
    true,  true,  true,  true,   true,  true,  true,  false, false,  false,  true,
    true,  true,  true,  true,   true,  true,  true,  false, false,  false,  true,
    true,  true,  true,  true,   true,  true,  true,  true,  false,  true,   true,
    false, true,  true,  true,   true,  true,  true,  true,  true,   true,   false,
    false, false, true,  true,   true,  true,  true,  true,  true,   false,  false,
    
    false, false, false, true,   true, true, true, true, false, false, false,
    false, false, true,  true,   true, true, true, true, true,  false, false,
    false, true,  true,  true,   true, true, true, true, true,  true,  false,
    true,  true,  true,  true,   true, true, true, true, true,  true,  true,
    true,  true,  true,  true,   true, true, true, true, true,  true,  true,
    true,  true,  true,  true,   true, true, true, true, true,  true,  true,
    true,  true,  true,  true,   true, true, true, true, true,  true,  true,
    true,  true,  true,  true,   true, true, true, true, true,  true,  true,
    false, true,  true,  true,   true, true, true, true, true,  true, false,
    false, false, true,  true,   true, true, true, true, true,  false, false,
    
    
    
]

let boWNoBodySmall: [Bool] = [
    false, false, true,  true,     true, true, true, true, true, false, false,
    false, true,  true,  true,     true, true, true, true, true, true,  false,
    true,  true,  true,  true,     true, true, true, true, true, true,  true,
    true,  true,  true,  true,     true, true, true, true, true, true,  true,
    true,  true,  true,  true,     true, true, true, true, true, true,  true,
    true,  true,  true,  true,     true, true, true, true, true, true,  true,
    true,  true,  true,  true,     true, true, true, true, true, true,  true,
    true,  true,  true,  true,     true, true, true, true, true, true,  true,
    true,  true,  true,  true,     true, true, true, true, true, true,  true,
    false, true,  true,  true,     true, true, true, true, true, true,  false,
    false, false, true,  true,     true, true, true, true, true, false, false,
    
    
]
let boWNoBody: [Bool] = [
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false, false, false, false,
    
    false, false, true,  true,     true, true, true, true, true, false, false,
    false, true,  true,  true,     true, true, true, true, true, true, false,
    true,  true,  true,  true,     true, true, true, true, true, true, true,
    true,  true,  true,  true,     true, true, true, true, true, true, true,
    true,  true,  true,  true,     true, true, true, true, true, true, true,
    true,  true,  true,  true,     true, true, true, true, true, true, true,
    true,  true,  true,  true,     true, true, true, true, true, true, true,
    true,  true,  true,  true,     true, true, true, true, true, true, true,
    true,  true,  true,  true,     true, true, true, true, true, true, true,
    false, true,  true,  true,     true, true, true, true, true, true, false,
    false, false, true,  true,     true, true, true, true, true, false, false,
    
    
]
let boWNoC: [Color] = [
    
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,
    
    CLEAR, CLEAR, BLACK,  BLACK,  BLACK, BLACK, BLACK, BLACK, BLACK, CLEAR, CLEAR,
    CLEAR, BLACK,  BLACK, BLACK,  BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, CLEAR,
    BLACK, BLACK,  BLACK, BLACK,  REDDD, REDDD, REDDD, BLACK, BLACK, BLACK, BLACK,
    BLACK, BLACK,  BLACK, REDDD,  REDDD, REDDK, REDDD, REDDD, BLACK, BLACK, BLACK,
    BLACK, BLACK,  REDDD, REDDD,  REDDK, REDDK, REDDK, REDDD, REDDD, BLACK, BLACK,
    BLACK, BLACK,  REDDD, REDDK,  REDDK, REDDK, REDDK, REDDK, REDDD, BLACK, BLACK,
    BLACK, BLACK,  REDDD, REDDD,  REDDK, REDDK, REDDK, REDDD, REDDD, BLACK, BLACK,
    BLACK, BLACK,  BLACK, REDDD,  REDDD, REDDK, REDDD, REDDD, BLACK, BLACK, BLACK,
    BLACK, BLACK,  BLACK, BLACK,  REDDD, REDDD, REDDD, BLACK, BLACK, BLACK, BLACK,
    CLEAR, BLACK,  BLACK, BLACK,  BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, CLEAR,
    CLEAR, CLEAR, BLACK,  BLACK,  BLACK, BLACK, BLACK, BLACK, BLACK, CLEAR, CLEAR,
    
    
]








let boWNoCSmall: [Color] = [
    CLEAR, CLEAR, BLACK,  BLACK,  BLACK, BLACK, BLACK, BLACK, BLACK, CLEAR, CLEAR,
    CLEAR, BLACK,  BLACK, BLACK,  BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, CLEAR,
    BLACK, BLACK,  BLACK, BLACK,  REDDD, REDDD, REDDD, BLACK, BLACK, BLACK, BLACK,
    BLACK, BLACK,  BLACK, REDDD,  REDDD, REDDK, REDDD, REDDD, BLACK, BLACK, BLACK,
    BLACK, BLACK,  REDDD, REDDD,  REDDK, REDDK, REDDK, REDDD, REDDD, BLACK, BLACK,
    BLACK, BLACK,  REDDD, REDDK,  REDDK, REDDK, REDDK, REDDK, REDDD, BLACK, BLACK,
    BLACK, BLACK,  REDDD, REDDD,  REDDK, REDDK, REDDK, REDDD, REDDD, BLACK, BLACK,
    BLACK, BLACK,  BLACK, REDDD,  REDDD, REDDK, REDDD, REDDD, BLACK, BLACK, BLACK,
    BLACK, BLACK,  BLACK, BLACK,  REDDD, REDDD, REDDD, BLACK, BLACK, BLACK, BLACK,
    CLEAR, BLACK,  BLACK, BLACK,  BLACK, BLACK, BLACK, BLACK, BLACK, BLACK, CLEAR,
    CLEAR, CLEAR, BLACK,  BLACK,  BLACK, BLACK, BLACK, BLACK, BLACK, CLEAR, CLEAR,
    
    
]

let boWShadowColor: [Color?] = [
    
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,  CLEAR,  CLEAR, CLEAR, BLACK,  CLEAR,  CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,  CLEAR,  CLEAR, CLEAR, BLACK,  BLACK,  CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, CLEAR,  CLEAR,  CLEAR, CLEAR, BLACK,  BLACK,  BLACK,
    CLEAR, CLEAR, CLEAR, BLACK, CLEAR,  BLACK,  CLEAR, CLEAR, CLEAR,  BLACK,  BLACK,
    CLEAR, CLEAR, BLACK, BLACK, CLEAR,  BLACK,  BLACK, CLEAR, BLACK,  BLACK,  BLACK,
    CLEAR, CLEAR, BLACK, BLACK, CLEAR,  BLACK,  BLACK, BLACK, BLACK,  BLACK,  BLACK,
    CLEAR, CLEAR, BLACK, BLACK, BLACK,  BLACK,  BLACK, BLACK, BLACK,  BLACK,  BLACK,
    CLEAR, CLEAR, BLACK, BLACK, BLACK,  BLACK,  BLACK, BLACK, BLACK,  BLACK,  BLACK,
    CLEAR, CLEAR, BLACK, BLACK, BLACK,  BLACK,  BLACK, BLACK, BLACK,  BLACK,  CLEAR,
    CLEAR, CLEAR, BLACK, BLACK, BLACK,  BLACK,  BLACK, BLACK, BLACK,  CLEAR,  CLEAR,
    CLEAR, CLEAR, CLEAR, BLACK, BLACK,  BLACK,  BLACK, BLACK, CLEAR,  CLEAR,  CLEAR,
    CLEAR, CLEAR, CLEAR, CLEAR, BLACK,  BLACK,  BLACK, CLEAR, CLEAR,  CLEAR,  CLEAR,
    CLEAR, CLEAR, CLEAR, BLACK, BLACK,  BLACK,  BLACK, BLACK, CLEAR,  CLEAR,  CLEAR,
    CLEAR, BLACK, BLACK, BLACK, BLACK,  BLACK,  BLACK, BLACK, BLACK,  BLACK,  CLEAR,
    CLEAR, BLACK, BLACK, BLACK, BLACK,  BLACK,  BLACK, BLACK, BLACK,  BLACK,  CLEAR,
    BLACK, REDDD, REDDD, BLACK, BLACK,  BLACK,  REDDD, REDDD, BLACK,  BLACK,  BLACK,
    REDDD, REDDK, REDDK, REDDD, BLACK,  REDDD,  REDDK, REDDK, REDDD,  BLACK,  BLACK,
    REDDD, REDDK, REDDK, REDDD, BLACK,  REDDD,  REDDK, REDDK, REDDD,  BLACK,  BLACK,
    REDDD, REDDK, REDDK, REDDD, BLACK,  REDDD,  REDDK, REDDK, REDDD,  BLACK,  BLACK,
    BLACK, REDDD, REDDD, BLACK, BLACK,  BLACK,  REDDD, REDDD, BLACK,  BLACK,  BLACK,
    CLEAR, BLACK, BLACK, BLACK, BLACK,  BLACK,  BLACK, BLACK, BLACK,  BLACK,  CLEAR,
    CLEAR, CLEAR, BLACK, BLACK, BLACK,  BLACK,  BLACK, BLACK, BLACK,  CLEAR,  CLEAR,
    
]


struct Color {
    var RED: UInt8  = 0
    var GREEN: UInt8 = 0
    var BLUE: UInt8 = 0
    var ALPHA: UInt8 = 0
}

enum direction {
    case North
    case South
    case Left
    case Right
    case Nothing
}

let CLEAR: Color = Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 0)

let BLACK: Color = Color(RED: 0, GREEN: 0, BLUE: 0, ALPHA: 255)
let COLORWHITE: Color = Color(RED: 255, GREEN: 255, BLUE: 255, ALPHA: 255)

let REDDK :  Color = Color(RED: 88, GREEN: 0, BLUE: 0, ALPHA: 255)

let REDDD :  Color = Color(RED: 125, GREEN: 0, BLUE: 0, ALPHA: 255)

let COLORGREEN :Color = Color(RED: 0, GREEN: 255, BLUE: 0, ALPHA: 255)
let COLORBLUE : Color = Color(RED: 0, GREEN: 0, BLUE: 255, ALPHA: 255)

let COLORYellow:Color = Color(RED: 255, GREEN: 255, BLUE: 0, ALPHA: 255)
let COLORpurple:Color = Color(RED: 255, GREEN: 0, BLUE: 255, ALPHA: 255)
let COLORcyan   :Color = Color(RED: 0, GREEN: 255, BLUE: 255, ALPHA: 255)

let COLORGRAY : Color = Color(RED: 50, GREEN: 50, BLUE: 50, ALPHA: 255)


enum swipeState {
    case Base
    case Special
    case Target
}
enum worldState{
    case Exploring
    case inBattle
}
enum whoseTurn{
    case playersTurn
    case slimesTurn
}

class StateHolder{
    
    var currentGameState: worldState = worldState.Exploring
    var currentSwipeState: swipeState = swipeState.Base
    var currentTurn: whoseTurn = whoseTurn.playersTurn
}

