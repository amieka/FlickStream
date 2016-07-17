//
//  InterestingnessCellDetailPushAnimationTransition.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 7/3/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation
import UIKit

enum ZoomTransitionType {
	case ZoomTransitionTypePresenting
	case ZoomTransitionTypeDismissing
}

protocol ZoomTransitionDelegate {
	
	func rectForZoomTransitionFromPresentingViewController(startView: UIView, targetView: UIView, transition: InterestingnessCellDetailPushAnimationTransition, fromViewController: UIViewController?, toViewController: UIViewController?) -> CGRect
	func rectForZoomTransitionFromPresentedViewController(startView: UIView, targetView: UIView, transition: InterestingnessCellDetailPushAnimationTransition, fromViewController: UIViewController?, toViewController: UIViewController?) -> CGRect
}

class InterestingnessCellDetailPushAnimationTransition: NSObject , UIViewControllerAnimatedTransitioning {
	var reverse: Bool = false
	var transitionDelegate: ZoomTransitionDelegate?
	var targetView: UIView?
	var transitionType: ZoomTransitionType?
	
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 1.5
	}
	
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
		let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
		
		
		var finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
		
	
		
		/*print("final frame \(finalFrameForVC)")
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
			//let toTransform = CGAffineTransformIdentity
			//toViewController.view.transform = CGAffineTransformScale(toTransform, 0, 0)
			}, completion: {
				finished in
				snapshotView.removeFromSuperview()
				transitionContext.completeTransition(true)
		})*/
		let fromControllerView = fromViewController.view
		let toControllerView = toViewController.view
		let fromControllerSnapshot = fromControllerView.snapshotViewAfterScreenUpdates(false)
		let toControllerSnapshot = toControllerView.snapshotViewAfterScreenUpdates(false)
		
		// create a fade view
		let containerView = transitionContext.containerView()
		
		let fadeView = UIView.init(frame: (containerView?.bounds)!)
		fadeView.backgroundColor = UIColor.whiteColor();
		fadeView.alpha = 0.0;
		
		let startFrame = transitionDelegate?.rectForZoomTransitionFromPresentingViewController(fromControllerView, targetView: targetView!, transition: self, fromViewController: fromViewController, toViewController: toViewController)
		let finishFrame = transitionDelegate?.rectForZoomTransitionFromPresentedViewController(toControllerView, targetView: targetView!, transition: self, fromViewController: fromViewController, toViewController: toViewController)
		
		let scaleFactor = finishFrame!.size.width / startFrame!.size.width

		if transitionType == ZoomTransitionType.ZoomTransitionTypePresenting {
			// Animate the transition for presenting a detail view controller
			
			
			
			let endPoint = CGPointMake((-startFrame!.origin.x * scaleFactor) + finishFrame!.origin.x, (-startFrame!.origin.y * scaleFactor) + finishFrame!.origin.y);
			
			let targetSnapshot = targetView?.snapshotViewAfterScreenUpdates(false)
			targetView?.frame = startFrame!
			
			//containerView?.addSubview(toControllerView)
			containerView?.addSubview(fromControllerSnapshot)
			containerView?.addSubview(fadeView)
			//containerView?.addSubview(targetSnapshot!)
			
			UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.5, options: .CurveEaseOut, animations:{
				// Transform and move the "from" snapshot
				fromControllerSnapshot.transform = CGAffineTransformMakeScale(1.02, 1.02);
				fromControllerSnapshot.frame = CGRectMake(endPoint.x, endPoint.y, fromControllerSnapshot.frame.size.width, fromControllerSnapshot.frame.size.height);
				
				// Fade
				fadeView.alpha = 1.0;
				
				// Move our target snapshot into position
				//targetSnapshot?.frame = finishFrame!
				
				}, completion: { finished in
					containerView?.addSubview(toControllerView)
					fadeView.removeFromSuperview()
					fromControllerSnapshot.removeFromSuperview()
					//targetSnapshot?.removeFromSuperview()
					transitionContext.completeTransition(finished)
			})

		} else {
			let startPoint = CGPointMake((-finishFrame!.origin.x * scaleFactor) + startFrame!.origin.x, (-finishFrame!.origin.y * scaleFactor) + startFrame!.origin.y)
			toControllerSnapshot.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
			toControllerSnapshot.frame = CGRectMake(startPoint.x, startPoint.y, toControllerSnapshot.frame.size.width, toControllerSnapshot.frame.size.height)
			
			containerView?.addSubview(toControllerSnapshot)
			containerView?.addSubview(fadeView)
			
			UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.5, options: .CurveEaseOut, animations:{
				// Transform and move the "from" snapshot
				toControllerSnapshot.transform = CGAffineTransformIdentity;
				toControllerSnapshot.frame = toControllerView.frame;
				
				// Fade
				fadeView.alpha = 1.0;
				
				// Move our target snapshot into position
				//targetSnapshot?.frame = finishFrame!
				
				}, completion: { finished in
					containerView?.addSubview(fromControllerView)
					fadeView.removeFromSuperview()
					toControllerView.removeFromSuperview()
					//targetSnapshot?.removeFromSuperview()
					transitionContext.completeTransition(finished)
			})
		}
		
	}

}
