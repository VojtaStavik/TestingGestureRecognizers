//
//  GestureTestingTests.swift
//  GestureTestingTests
//
//  Created by Vojta Stavik on 29/03/16.
//  Copyright © 2016 STRV. All rights reserved.
//

@testable import GestureTesting
import Quick
import Nimble

class ViewControllerTests: QuickSpec {
    override func spec() {
        describe("View Controller") {
            var vc: ViewController!
            
            beforeEach {
                vc = UIStoryboard(name: "Main", bundle: NSBundle(forClass: ViewController.self))
                    .instantiateInitialViewController() as! ViewController
                _ = vc.view // load view
            }
            
            describe("pan gesture recognizer") {
                var recognizer: TestablePanGestureRecognizer!
                
                beforeEach({ 
                    recognizer = vc.panGestureRecognizer as! TestablePanGestureRecognizer
                })
                
                it("should be added to square view") {
                    expect(vc.square.gestureRecognizers?.contains(recognizer)).to(beTrue())
                }
                
                it("should change squre with to 100 when begins") {
                    recognizer.perfomTouch(nil, translation: nil, state: .Began)
                    expect(vc.widthConstraint.constant).toEventually(equal(100))
                }
                
                it("should change square position by gesture translation when moves") {
                    recognizer.perfomTouch(nil, translation: CGPoint(x: -50, y: 50), state: .Changed)
                    expect(vc.centerXconstraint.constant).toEventually(equal(-50))
                    expect(vc.centerYconstraint.constant).toEventually(equal(50))
                }
                
                it("should reset square position when gesture ends") {
                    recognizer.perfomTouch(nil, translation: nil, state: .Ended)
                    expect(vc.centerXconstraint.constant).toEventually(equal(0))
                    expect(vc.centerYconstraint.constant).toEventually(equal(0))
                    expect(vc.widthConstraint.constant).toEventually(equal(50))
                }
            }
        }
    }
}