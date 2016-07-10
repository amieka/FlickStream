//
//  InterestingnessCellDetailPushAnimationTransition.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 7/3/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation
import UIKit

class InterestingnessCellDetailPushAnimationTransition: NSObject , UIViewControllerAnimatedTransitioning {
	var reverse: Bool = false
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 1.5
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
		let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
		
		print("final frame \(finalFrameForVC)")
		let containerView = transitionContext.containerView()
		toViewController.view.frame = finalFrameForVC
		toViewController.view.alpha = 0.5
		containerView?.addSubview(toViewController.view)
		containerView?.sendSubviewToBack(toViewController.view)
		
		let snapshotView = fromViewController.view.snapshotViewAfterScreenUpdates(false)
		snapshotView.frame = fromViewController.view.frame
		containerView?.addSubview(snapshotView)
		
		fromViewController.view.removeFromSuperview()
		
		UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
			snapshotView.frame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width / 2, fromViewController.view.frame.size.height / 2)
			toViewController.view.alpha = 1.0
			let toTransform = CGAffineTransformIdentity
			toViewController.view.transform = CGAffineTransformScale(toTransform, 0, 0)
			}, completion: {
				finished in
				snapshotView.removeFromSuperview()
				transitionContext.completeTransition(true)
		})
	}

}
