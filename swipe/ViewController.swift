//
//  ViewController.swift
//  swipe
//
//  Created by Rebecca Goldman on 5/23/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    
    let blueColor = UIColor(red: 68/255, green: 170/255, blue: 210/255, alpha: 1)
    let yellowColor = UIColor(red: 254/255, green: 202/255, blue: 22/255, alpha: 1)
    let brownColor = UIColor(red: 206/255, green: 150/255, blue: 98/255, alpha: 1)
    let greenColor = UIColor(red: 85/255, green: 213/255, blue: 80/255, alpha: 1)
    let redColor = UIColor(red: 231/255, green: 61/255, blue: 14/255, alpha: 1)
    let grayColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
    let lightGrayColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    
    
    var scrollOffset: CGFloat!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var archiveIconView: UIImageView!
    @IBOutlet weak var listIconView: UIImageView!
    @IBOutlet weak var laterIconView: UIImageView!
    @IBOutlet weak var deleteIconView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var composeView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    
    @IBOutlet weak var composeButton: UIButton!
    
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
    var initialScrollViewPosition: CGFloat!
    
    @IBOutlet weak var results1View: UIImageView!
    @IBOutlet weak var results2View: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var darkView: UIView!
    @IBOutlet var superView: UIView!
    var closedPosition: CGFloat!
    var openPosition: CGFloat!
    
    @IBOutlet weak var archiveView: UIImageView!
    @IBOutlet weak var laterView: UIImageView!
    
    @IBOutlet weak var archiveNavView: UIImageView!
    @IBOutlet weak var mailNavView: UIImageView!
    @IBOutlet weak var laterNavView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var searchView: UIView!
    
    var panGesture: UIPanGestureRecognizer!
    
    
    @IBOutlet weak var rescheduleView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial segmented control colors
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.tintColor = blueColor
        
        // set scrollView
        scrollView.contentSize = CGSizeMake(320, 1350)
        
        // set initial background color for actionView
        actionView.backgroundColor = grayColor
        
        // hide all message action icons
        archiveIconView.alpha = 0
        deleteIconView.alpha = 0
        listIconView.alpha = 0
        laterIconView.alpha = 0
        rescheduleView.alpha = 0
        
        // hide views that will be triggered in functions
        listView.alpha = 0
        darkView.alpha = 0
        results1View.alpha = 0
        results2View.alpha = 0
        archiveNavView.alpha = 0
        mailNavView.alpha = 1
        laterNavView.alpha = 0
        archiveView.center.x = 640
        laterView.center.x = -640
        
        actionView.frame = CGRectMake(0, 65, self.view.frame.width, 86)
        
        sendButton.addTarget(self, action: "didTapSend:", forControlEvents: UIControlEvents.TouchUpInside)
        sendButton.tintColor = blueColor
        sendButton.backgroundColor = lightGrayColor
        sendButton.setTitle("Send", forState: UIControlState.Normal)
        sendButton.frame = CGRectMake(274, sendButton.center.y - 18, 40, 34)
        sendButton.alpha = 0
        
        self.composeView.addSubview(sendButton)
        
        searchView.center.y = 5
        composeView.frame = CGRectMake(0, 1136, 320, 225)
        
        scrollView.contentOffset = CGPoint(x: 0, y: -118)
        
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        containerView.addGestureRecognizer(edgeGesture)
        containerView.userInteractionEnabled = true
        initialScrollViewPosition = scrollView.center.y
        println("initialScrollViewPosition center: \(scrollView.center.y)")
        
        
        scrollView.delegate = self
        
        println("container view height: \(containerView.frame)")
        
        
        
    }
    
    @IBAction func didTapSegment(sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            segmentedControl.tintColor = yellowColor
            
            UIView.animateWithDuration(0.24, delay: 0.01, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.laterView.center.x = 160
                self.laterNavView.alpha = 1
                
                
                
                }, completion: nil )
            
            
        } else if segmentedControl.selectedSegmentIndex == 1  {
            
            segmentedControl.tintColor = blueColor
            
            UIView.animateWithDuration(0.24, delay: 0.01, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.archiveView.center.x = 640
                self.laterView.center.x = -640
                self.laterNavView.alpha = 0
                self.archiveNavView.alpha = 0
                
                
                }, completion: nil )
            
            
            
        }  else if segmentedControl.selectedSegmentIndex == 2  {
            
            println("what is the: \(segmentedControl.selectedSegmentIndex)")
            
            segmentedControl.tintColor = greenColor
            
            UIView.animateWithDuration(0.24, delay: 0.01, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.archiveView.center.x = 160
                self.archiveNavView.alpha = 1
                
                
                }, completion: nil )
            
        }
    }
    
    
    @IBAction func didTapSend(sender: UIButton) {
        
        println("user tapped send")
        
        var translate1 = CGAffineTransformMakeTranslation(0, self.composeView.center.y + 4)
        var translate2 = CGAffineTransformMakeTranslation(0, self.composeView.center.y - 600)
        var scale1 = CGAffineTransformMakeScale(0.8, 0.8)
        var scale2 = CGAffineTransformMakeScale(0.5, 0.5)
        
        
        
        UIView.animateWithDuration(0.24, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            
            self.composeView.transform = CGAffineTransformConcat(translate1, scale1)
            
            
            }, completion: { (Bool) -> Void in
                
                
                UIView.animateWithDuration(0.24, delay: 0.01, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.composeView.transform = CGAffineTransformConcat(translate2, scale2)
                    self.darkView.alpha = 0
                    
                    
                    }, completion: nil )
                
        })
        
        self.textField.endEditing(true)
        
    }
    
    
    
    @IBAction func didFillToField(sender: UITextField) {
        
        if textField.text == "re" {
            
            results1View.alpha = 1
            
        } else if textField.text == "rebecca@" {
            
            
            results1View.alpha = 0
            results2View.alpha = 1
            
            
        }
        
        if textField.text == "rebecca@goldman.org" {
            
            results2View.alpha = 0
            sendButton.alpha = 1
            
        }
        
    }
    
    
    //
    //    func scrollViewDidScroll(sender: UIScrollView) {
    //
    //        println("this is the content offet: \(scrollView.contentOffset.y)")
    //
    //        if scrollView.contentOffset.y >= 118 {
    //
    //            println("this is the content offet: \(scrollView.contentOffset.y)")
    //            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
    //
    //                self.scrollView.contentOffset = CGPoint(x: 0, y: -118)
    //
    //
    //
    //                }, completion: nil)
    //        }
    //
    //
    //
    //           }
    
    // dismiss compose view on cancel
    @IBAction func didTapCancel(sender: AnyObject) {
        textField.resignFirstResponder()
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.darkView.alpha = 0
            self.composeView.frame = CGRectMake(0, 1136, 320, 225)
            
            }, completion: nil )
        
        
    }
    
    // tap compose
    @IBAction func didTapCompose(sender: AnyObject) {
        
        textField.becomeFirstResponder()
        
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.darkView.alpha = 0.5
            self.composeView.frame = CGRectMake(0, 20, 320, 225)
            
            }, completion: nil )
        
    }
    
    
    // setup edge pan
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        panGesture = UIPanGestureRecognizer(target: self, action: "didPanView:")
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            initialCenter = containerView.center
            closedPosition = superView.center.x
            openPosition = closedPosition + 280
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            containerView.center.x = CGFloat(initialCenter.x + translation.x)
            
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
            if containerView.center.x >= 320 { // this is open
                
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.containerView.center.x = self.openPosition
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.containerView.addGestureRecognizer(self.panGesture)
                        self.panGesture.enabled = true
                        
                        println("is this adding the gesture")
                        
                        
                })
                
                
            } else {
                
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.containerView.center.x = self.closedPosition
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.containerView.removeGestureRecognizer(self.panGesture)
                        
                        self.panGesture.enabled = false
                        
                })
                
                
            }
            
            
        }
        
        
    }
    
    // setup for shake to undo
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return .Default
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if(event.subtype == UIEventSubtype.MotionShake) {
            
            
            var alert = UIAlertController(title: "Do you want to undo?",
                message: "",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
                })
            
            
            alert.addAction(UIAlertAction(title: "Undo", style: UIAlertActionStyle.Default, handler: {(alertAction) -> Void in
                
                self.undismissMessage()
            }))
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    func undismissMessage() {
        
        self.messageView.center.x = 160
        self.actionView.frame = CGRectMake(0, 65, self.view.frame.width, 86)
        self.feedView.center.y += 88
        
        
    }
    
    
    
    // pan view
    @IBAction func didPanView(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            initialCenter = containerView.center
            closedPosition = superView.center.x
            openPosition = closedPosition + 280
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            containerView.center.x = CGFloat(initialCenter.x + translation.x)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
            if containerView.center.x >= 320 { // this block works
                
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.containerView.center.x = self.openPosition
                    
                    }, completion: nil)
                
                
            } else {
                
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.containerView.center.x = self.closedPosition
                    self.panGesture.enabled = false
                    
                    
                    }, completion: nil )
                
            }
        }
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
                
                laterIconView.alpha = 0
                
                
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
                        
                        
                        
                        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            self.actionView.frame = CGRectMake(0, 65, self.view.frame.width, 0)
                            self.feedView.center.y -= 88
                            
                            }, completion: nil)
                        
                })
                
                // if archive icon is visible, animate icon + message offscreen
            } else if messageView.center.x >= transitionToGreen && velocity.x > 0 {
                
                UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.messageView.center.x = 640
                    self.archiveIconView.center.x = 400
                    
                    }, completion: { (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                            self.actionView.frame = CGRectMake(0, 65, self.view.frame.width, 0)
                            self.feedView.center.y -= 88
                            
                            }, completion: nil)
                        
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
    
    
    
    
    
    @IBAction func didTapRescheduleView(sender: AnyObject) {
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.rescheduleView.alpha = 0
            
            
            }, completion: { (Bool) -> Void in
                
                
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.actionView.frame = CGRectMake(0, 65, self.view.frame.width, 0)
                    self.feedView.center.y -= 88
                    
                    }, completion: nil)
                //                self.actionView.removeFromSuperview()
                
        })
        
        
        
    }
    
    @IBAction func didTapListView(sender: AnyObject) {
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.listView.alpha = 0
            
            
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    self.actionView.frame = CGRectMake(0, 65, self.view.frame.width, 0)
                    self.feedView.center.y -= 88
                    }, completion: nil)
                
        })
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

