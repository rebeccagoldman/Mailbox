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
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var laterIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    var initialCenter: CGPoint!
    var initialArchiveIconCenter: CGPoint!
    var initialDeleteIconCenter: CGPoint!
    var transitionToGreen: CGFloat!
    var transitionToRed: CGFloat!
    var transitionToYellow: CGFloat!
    var transitionToBrown: CGFloat!
    var alpha: Int!
    var didPanRight: Bool!
    var didPanLeft: Bool!
    
    @IBOutlet weak var rescheduleView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionView.backgroundColor = grayColor
        archiveIconView.alpha = 0
        deleteIconView.alpha = 0
        listIconView.alpha = 0
        rescheduleView.alpha = 0
        listView.alpha = 0

//        laterIconView.alpha = 0

    }

    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        
        var velocity = sender.velocityInView(view)
        var location = sender.locationInView(view)
        var translation = sender.translationInView(view)
       
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            didPanRight = velocity.x > 0
            didPanLeft = velocity.x < 0

            
            // define initial center of view
            initialCenter = messageView.center
      
            // define color transition points for right-swipe
            transitionToGreen = messageView.center.x + 60
            transitionToRed = messageView.center.x + 260
            
            // define color transition points for left-swipe
            transitionToYellow = messageView.center.x - 60
            println("Transition to Yellow: \(transitionToYellow)")
            transitionToBrown = messageView.center.x - 260

            println("Gesture began at: \(location)")
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            
            messageView.center.x = CGFloat(initialCenter.x + translation.x)
            
            // change to green and show archive icon
            if didPanRight == true {
                
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
            
            } else if didPanLeft == true {
                
                if messageView.center.x <= transitionToYellow && messageView.center.x > transitionToBrown {
                    
                    laterIconView.center.x = messageView.center.x + 185
                    println("later icon center: \(translation.x)")

                    laterIconView.alpha = 1
                    listIconView.alpha = 0
                    
                    actionView.backgroundColor = yellowColor
                    
                    // change to brown and show list icon
                } else if messageView.center.x <= transitionToBrown {
                    
                    actionView.backgroundColor = brownColor
                    laterIconView.alpha = 0
                    listIconView.alpha = 1
                    listIconView.center.x = messageView.center.x + 185
                    
                    // change to gray and fade in/out archive icon
                } else if messageView.center.x >= transitionToYellow {
                    
                    laterIconView.alpha = -(translation.x / 60)
                    println("alpha: \(-(translation.x / 60))")

                    
                    actionView.backgroundColor = grayColor
                    
                }
            }
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            // if cancel icon is visible, animate icon + message offscreen
            if deleteIconView.alpha == 1  {
                
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
            } else if actionView.backgroundColor == grayColor {
                
                messageView.center.x = initialCenter.x
                
            }
            
            
            if laterIconView.alpha == 1 && messageView.center.x <= transitionToYellow {
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.messageView.center.x = -1000
                    self.laterIconView.center.x = -600
                    self.rescheduleView.alpha = 1
                    self.actionView.backgroundColor = self.yellowColor
                    
                    }, completion: nil)
                
                // if list icon is visible, animate icon + message offscreen
            } else if listIconView.alpha == 1 && messageView.center.x <= transitionToBrown {
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.messageView.center.x = -1000
                    self.listIconView.center.x = -600
                    self.listView.alpha = 1
                    self.actionView.backgroundColor = self.brownColor


                    }, completion: nil)
                
                // if gray background is visible, return to original position
            }
            
            
            
            
        }
        
        
        
    }



    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

