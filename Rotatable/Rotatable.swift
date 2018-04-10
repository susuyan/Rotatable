//
//  Rotatable.swift
//  Rotatable
//
//  Created by susuyan on 2018/3/24.
//  Copyright © 2018年 susuyan. All rights reserved.
//

import UIKit

enum RotateState {
    case rotating
    case pause
    case none
}

private var ROTATABLE_ROTATESTATE : RotateState = .none

extension UIImageView: Rotatable {
    
     
}


protocol Rotatable where Self: UIView{
    
    var rotateState: RotateState {get set}
    
    mutating func rotate()
}

extension Rotatable {
    
    var rotateState: RotateState {
        get {
            let result = objc_getAssociatedObject(self, &ROTATABLE_ROTATESTATE) as? RotateState
            if result == nil {
                return RotateState.none
            }
            return result!
        }
        set {
            objc_setAssociatedObject(self, &ROTATABLE_ROTATESTATE, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
   mutating func rotate() {
        switch self.rotateState {
        case RotateState.rotating:
            pauseRotate()
        case RotateState.pause:
            resumeRotate()
        case RotateState.none:
            startRotate()
        }
    }
    
    mutating func startRotate() {
        let rotateAni = CABasicAnimation(keyPath: "transform.rotation")
        rotateAni.fromValue = 0.0
        rotateAni.toValue = Double.pi * 2.0
        rotateAni.duration = 10
        rotateAni.repeatCount = MAXFLOAT
        self.layer.add(rotateAni, forKey: nil)
        self.rotateState = .rotating
    }
    
    mutating func pauseRotate() {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        
        self.rotateState = .pause

    }
    
    mutating func resumeRotate() {
        
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        
        rotateState = .rotating
        
    }
    
    mutating func stopRotate() {
        self.layer.removeAllAnimations()
        self.rotateState = .none
    }
    
}
