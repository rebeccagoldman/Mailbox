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
    
    @IBOutlet weak var darkView: UIView!
    @IBOutlet var superView: UIView!
    var closedPosition: CGFloat!
    var openPosition: CGFloat!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var searchView: UIView!
    
    var panGesture: UIPanGestureRecognizer!

    
    @IBOutlet weak var rescheduleView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = feedView.image!.size
        actionView.backgroundColor = grayColor
        archiveIconView.alpha = 0
        deleteIconView.alpha = 0
        listIconView.alpha = 0
        laterIconView.alpha = 0
        rescheduleView.alpha = 0
        listView.alpha = 0
        darkView.alpha = 0
        actionView.frame = CGRectMake(0, 65, self.view.frame.width, 86)

        
        searchView.frame = CGRectMake(0, -52, self.view.frame.width, 118)
        composeView.frame = CGRectMake(0, 1136, 320, 225)

        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        containerView.addGestureRecognizer(edgeGesture)
        containerView.userInteractionEnabled = true
        initialScrollViewPosition = scrollView.center.y
        println("initialScrollViewPosition center: \(scrollView.center.y)")

        
        scrollView.delegate = self

        println("container view height: \(containerView.frame)")
        


    }
    
    
    
//    func scrollViewDidScroll(sender: UIScrollView) {
//        
//
//        var scrollOffset: CGFloat = scrollView.contentOffset.y
//
//        if sender.state == sender.scrollViewDidScrollToTop() {
//            
//            println("scrollView action fired: \(scrollView.center.y)")
//
//            
//            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//
//                self.searchView.frame = CGRectMake(0, 52, self.view.frame.width, 118)
//                
//                }, completion: nil)
//        
//
//        }
//    }
//    
    
    @IBAction func didTapCompose(sender: AnyObject) {
        
        textField.becomeFirstResponder()

        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.darkView.alpha = 0.5
            self.composeView.frame = CGRectMake(0, 20, 320, 225)
            
            }, completion: nil )
        

        
        
    }
    
    
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
        
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        panGesture = UIPanGestureRecognizer(target: self, action: "didPanView:")

        
        if sender.state == UIGestureRecognizerState.Began {
            
            initialCenter = containerView.center
            closedPosition = superView.center.x
            openPosition = closedPosition + 265
            
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
    
    
    @IBAction func didPanView(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)

        if sender.state == UIGestureRecognizerState.Began {
            
            initialCenter = containerView.center
            closedPosition = superView.center.x
            openPosition = closedPosition + 265

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

