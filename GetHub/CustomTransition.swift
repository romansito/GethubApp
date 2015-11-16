//
//  CustomTransition.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/14/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {

	var duration = 7.0
	
	init(duratioin: NSTimeInterval) {
		self.duration = duratioin
	}
	
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return self.duration
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		if let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) {
		let containerView = transitionContext.containerView()
		
		let finalFrame = transitionContext.finalFrameForViewController(toViewController)
		let screenBounds = UIScreen.mainScreen().bounds
		
		toViewController.view.frame = CGRectOffset(finalFrame, 0.0, screenBounds.size.height)
		containerView!.addSubview(toViewController.view)
		
		UIView.animateWithDuration(self.duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
			toViewController.view.frame = finalFrame
			}) { (finished) -> Void in
				transitionContext.completeTransition(true)
		}
	}
  }
}