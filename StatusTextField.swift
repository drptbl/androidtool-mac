//
//  StatusTextField.swift
//  AndroidTool
//
//  Created by Morten Just Petersen on 11/24/15.
//  Copyright © 2015 Morten Just Petersen. All rights reserved.
//

import Cocoa

class StatusTextField: NSTextField {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        wantsLayer = true
    }
    
    
    
    func animateIn(completion:()->Void?){

        let moveTo = (layer?.frame.origin.y)! - 5
        let move = CABasicAnimation(keyPath: "position.y")
        move.toValue = moveTo
        move.duration = 0.2
        
        move.removedOnCompletion = true
        move.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0
        fade.toValue = 1
        fade.duration = 0.2
        fade.removedOnCompletion = true
        fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            completion()
        }
        
        layer?.addAnimation(fade, forKey: "basicOpacity")
        layer?.opacity = 1
        layer?.addAnimation(move, forKey: "basicMove")
        layer?.frame.origin.y = moveTo
        
        CATransaction.commit()
        

    }
    
    
    func animateOut(completion:()->Void){
        let moveTo = (layer?.frame.origin.y)! + 5
        let move = CABasicAnimation(keyPath: "position.y")
        move.toValue = moveTo
        move.duration = 0.2
        move.removedOnCompletion = true
        move.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1
        fade.toValue = 0
        fade.removedOnCompletion = true
        fade.duration = 0.2
        fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            completion()
        }
        
        layer?.addAnimation(fade, forKey: "basicOpacity")
        layer?.opacity = 0
        layer?.addAnimation(move, forKey: "basicMove")
        layer?.frame.origin.y = moveTo
        
        CATransaction.commit()
    }
    

    func setText(text:String){
        animateOut { () -> Void in
            self.stringValue = text
            self.animateIn { () -> Void? in
                self.slowlyDecay()
            }

        }
    }
    
    
    func slowlyDecay(){
        wantsLayer = true
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 60 //* 5 // 5 mins
        self.layer?.addAnimation(anim, forKey: "opacity")
        alphaValue = 0
    }
    
}
