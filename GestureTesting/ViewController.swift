//
//  ViewController.swift
//  GestureTesting
//
//  Created by Vojta Stavik on 29/03/16.
//  Copyright © 2016 STRV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var square: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerXconstraint: NSLayoutConstraint!
    @IBOutlet weak var centerYconstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        square.addGestureRecognizer(panGestureRecognizer)
    }
    
    lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let recognizer = TestablePanGestureRecognizer(target: self, action: #selector(ViewController.handlePan))
        return recognizer
    }()

    func handlePan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            UIView.animateWithDuration(0.22, animations: {
                self.widthConstraint.constant = 100
                self.view.layoutIfNeeded()
            })
        
        case .Changed:
            let translation = sender.translationInView(self.view)
            self.centerXconstraint.constant = translation.x
            self.centerYconstraint.constant = translation.y
            self.view.layoutIfNeeded()
        
        case .Ended, .Cancelled:
            UIView.animateWithDuration(0.22, animations: {
                self.widthConstraint.constant = 50
                self.centerXconstraint.constant = 0
                self.centerYconstraint.constant = 0
                self.view.layoutIfNeeded()
            })
            
        default:
            break
        }
    }
}

