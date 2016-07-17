//
//  InterestingnessViewController.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 7/1/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation
import UIKit

class InterestingnessViewController: UIViewController, UINavigationControllerDelegate {
	let customNavigationAnimationController = InterestingnessCellDetailPushAnimationTransition()
	let searchAPI = InterestingnessAPI()
	var interestingness:[Interestingness]?
	var collectionView:UICollectionView?
	var interestingnessCollectionView: InterestingnessCollectionView?
	override func viewDidLoad() {
		super.viewDidLoad()

		let flowLayOut = UICollectionViewFlowLayout()
		interestingnessCollectionView = InterestingnessCollectionView(frame: self.view.frame, collectionViewLayout: flowLayOut)
		interestingnessCollectionView?.interestingnesscellSelectedDelegate = self
		
		self.view.addSubview(interestingnessCollectionView as UICollectionView!)
		customNavigationAnimationController.transitionDelegate = self
		
		self.navigationController?.navigationItem.title = "Trending"
		self.navigationController?.delegate = self

		typealias interesting = ([Interestingness]) -> (Void)
		typealias apierror = (FlickrAPIError) -> (Void)
		let successHandler:interesting = {interestingness in
			//self.interestingness = interestingness
			dispatch_async(dispatch_get_main_queue(), { [unowned self] in
				self.interestingnessCollectionView?.refreshCollectionView(interestingness)
			})
		}
		
		let errorHandler:apierror = { error in
			// handle error here
			// show some kind of uinotification
		}
		
		searchAPI.callAPI(successHandler, errorHandler: errorHandler)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		customNavigationAnimationController.reverse = operation == .Pop
		
		if fromVC is InterestingnessViewController {
			customNavigationAnimationController.transitionType = ZoomTransitionType.ZoomTransitionTypePresenting
		} else {
			customNavigationAnimationController.transitionType = ZoomTransitionType.ZoomTransitionTypeDismissing
		}
		
		if (self.interestingnessCollectionView?.interestingnessCollectionViewCell as FlickrPhotoCell!) != nil {
			customNavigationAnimationController.targetView = self.interestingnessCollectionView?.interestingnessCollectionViewCell?.thumbnailImage
		}
		
		return customNavigationAnimationController
	}
	

}

extension InterestingnessViewController: InterestingnessCellSelectedDelegate, ZoomTransitionDelegate {
	
	func didSelectInterestingnessCell(interestingnessDetail:Interestingness) {
		let interestingnessDetailVC = InterestingnessDetailViewController()
		self.navigationController?.pushViewController(interestingnessDetailVC, animated: true)
		interestingnessDetailVC.interestingnessDetail = interestingnessDetail

		print("interestingness url \(interestingnessDetail.url_s)")
	}
	
	func rectForZoomTransitionFromPresentedViewController(startView: UIView, targetView: UIView, transition: InterestingnessCellDetailPushAnimationTransition, fromViewController: UIViewController?, toViewController: UIViewController?) -> CGRect {
		
		var ret = CGRectZero
		if (self == fromViewController)  {
			//ret  = (toVC.photoDetailView?.photoDetailImage?.convertRect((toVC.photoDetailView?.photoDetailImage?.bounds)!, toView: startView))!
			ret = (self.interestingnessCollectionView?.interestingnessCollectionViewCell?.convertRect((self.interestingnessCollectionView?.interestingnessCollectionViewCell?.bounds)!, toView: startView))!
		} else {
			//we are popping the view from navigation stack
			//return [_selectedCell.imageView convertRect:_selectedCell.imageView.bounds toView:relativeView];
			let toVC = fromViewController as! InterestingnessDetailViewController
			ret =  (toVC.photoDetailView?.photoDetailImage?.convertRect((toVC.photoDetailView?.photoDetailImage?.bounds)!, toView: startView))!
		}
		
		
		return ret
		
	}
	
	func rectForZoomTransitionFromPresentingViewController(startView: UIView, targetView: UIView, transition: InterestingnessCellDetailPushAnimationTransition, fromViewController: UIViewController?, toViewController: UIViewController?) -> CGRect {
		
		
		var ret = CGRectZero
		if (self == fromViewController) {
			
			
			ret = (self.interestingnessCollectionView?.interestingnessCollectionViewCell?.convertRect((self.interestingnessCollectionView?.interestingnessCollectionViewCell?.bounds)!, toView: startView))!
			
		} else {
			//we are popping the view from navigation stack
			//let toVC = toViewController as! InterestingnessDetailViewController
			//return [_selectedCell.imageView convertRect:_selectedCell.imageView.bounds toView:relativeView];
			
			
			if toViewController is InterestingnessDetailViewController {
				if let toVC = toViewController as! InterestingnessDetailViewController! {
					ret = (toVC.photoDetailView?.photoDetailImage?.convertRect((toVC.photoDetailView?.photoDetailImage?.bounds)!, toView: startView))!
				}
			} else {
				ret = (self.interestingnessCollectionView?.interestingnessCollectionViewCell?.convertRect((self.interestingnessCollectionView?.interestingnessCollectionViewCell?.bounds)!, toView: startView))!
			}
			
		}
		return ret
	}
	
	
}
