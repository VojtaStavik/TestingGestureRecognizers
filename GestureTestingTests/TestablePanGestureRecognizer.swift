//
//  TestablePanGestureRecognizer.swift
//  GestureTesting
//
//  Created by Vojta Stavik on 29/03/16.
//  Copyright © 2016 STRV. All rights reserved.
//

import UIKit

class TestablePanGestureRecognizer: UIPanGestureRecognizer {
    let testTarget: AnyObject?
    let testAction: Selector
    
    var testState: UIGestureRecognizerState?
    var testLocation: CGPoint?
    var testTranslation: CGPoint?
    
    override init(target: AnyObject?, action: Selector) {
        testTarget = target
        testAction = action
        super.init(target: target, action: action)
    }
    
    func perfomTouch(location: CGPoint?, translation: CGPoint?, state: UIGestureRecognizerState) {
        testLocation = location
        testTranslation = translation
        testState = state
        testTarget?.performSelector(testAction, onThread: NSThread.currentThread(), withObject: self, waitUntilDone: true)
    }
    
    override func locationInView(view: UIView?) -> CGPoint {
        if let testLocation = testLocation {
            return testLocation
        }
        return super.locationInView(view)
    }
    
    override func translationInView(view: UIView?) -> CGPoint {
        if let testTranslation = testTranslation {
            return testTranslation
        }
        return super.translationInView(view)
    }
    
    override var state: UIGestureRecognizerState {
        if let testState = testState {
            return testState
        }
        return super.state
    }
}
