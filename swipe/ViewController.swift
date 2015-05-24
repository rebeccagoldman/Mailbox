//
//  ViewController.swift
//  swipe
//
//  Created by Rebecca Goldman on 5/23/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    
    let blueColor = UIColor(red: 68/255, green: 170/255, blue: 210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green: 202/255, blue: 22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/255, green: 213/255, blue: 80/255, alpha: 1)
    let redColor = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
    
    @IBOutlet weak var archiveIconView: UIImageView!
    
    @IBOutlet weak var deleteIconView: UIImageView!
    
    var initialCenter: CGPoint!
    var initialArchiveIconCenter: CGPoint!
    var initialDeleteIconCenter: CGPoint!
    var transitionToGreen: CGFloat!
    var transitionToRed: CGFloat!
    var transitionToYellow: CGFloat!
    var transitionToBrown: CGFloat!
    var alpha: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionView.backgroundColor = grayColor
        archiveIconView.alpha = 0
        deleteIconView.alpha = 0

    }

    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        
        var velocity = sender.velocityInView(view)
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            // define initial center of view
            initialCenter = messageView.center
            
            // define color transition poitns
            transitionToGreen = messageView.center.x + 60
            transitionToRed = messageView.center.x + 260
            transitionToYellow = messageView.center.x - 60
            transitionToBrown = messageView.center.x - 260

            
            println("Gesture began at: \(location)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            messageView.center.x = CGFloat(initialCenter.x + translation.x)
            
            // change to green and show archive icon
            if messageView.center.x >= transitionToGreen && messageView.center.x < transitionToRed {
                
                self.archiveIconView.center.x = translation.x - 25
                archiveIconView.alpha = 1
                self.deleteIconView.alpha = 0
                
                actionView.backgroundColor = greenColor
                
            // change to red and show cancel icon
            } else if messageView.center.x >= transitionToRed {
                
                actionView.backgroundColor = redColor
                self.archiveIconView.alpha = 0
                self.deleteIconView.alpha = 1
                self.deleteIconView.center.x = translation.x - 25
                
            // change to gray and fade in/out archive icon
            } else if messageView.center.x <= transitionToGreen {
                
                archiveIconView.alpha = (translation.x / 60)
                actionView.backgroundColor = grayColor
                
            }
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            // if cancel icon is visible, animate icon + message offscreen
            if messageView.center.x >= transitionToRed && velocity.x > 0  {
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.messageView.center.x = 640
                    self.deleteIconView.center.x = 400
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.actionView.removeFromSuperview()
                        
                })
            
            // if archive icon is visible, animate icon + message offscreen
            } else if messageView.center.x >= transitionToGreen && velocity.x > 0 {
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.messageView.center.x = 640
                    self.archiveIconView.center.x = 400
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.actionView.removeFromSuperview()
                        
                })
            
            // if gray background is visible, return to original position
            } else if messageView.center.x <= transitionToGreen {
                
                messageView.center.x = initialCenter.x
                actionView.backgroundColor = grayColor
                
            }
            
            println("Gesture ended at: \(location)")
            
        }
    }



    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

