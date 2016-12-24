//
//  RandomGenerator.swift
//  TestNavigation
//
//  Created by 田腾飞 on 2016/11/17.
//  Copyright © 2016年 田腾飞. All rights reserved.
//

import UIKit

// Int类型的随机数
public extension Int {
    public static func random(min: Int = 0, max: Int = Int.max) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    
    public static func random(range: Range<Int>) -> Int {
        return random(min: range.lowerBound, max: range.upperBound)
    }
}

// Bool类型的随机数
public extension Bool {
    public static func random() -> Bool {
        return Int.random(min: 0, max: 1) == 0
    }
}

// Double类型的随机数
public extension Double {
    public static func random(min: Double = 0.0, max: Double = 1.0) -> Double {
        return (Double(arc4random()) / Double(UINT32_MAX)) * (max - min) + min
    }
}

// Float类型的随机数
public extension Float {
    public static func random(min: Float = 0.0, max: Float = 1.0) -> Float {
        return (Float(arc4random()) / Float(UINT32_MAX)) * (max - min) + min
    }
}

