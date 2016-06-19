//
//  ViewController.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/4/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	
	let searchAPI = InterestingnessAPI()
	var interestingness:[Interestingness]?
	var collectionView:UICollectionView?
	var interestingnessCollectionView: InterestingnessCollectionView?
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let flowLayOut = UICollectionViewFlowLayout()
		interestingnessCollectionView = InterestingnessCollectionView(frame: self.view.frame, collectionViewLayout: flowLayOut)
		self.view.addSubview(interestingnessCollectionView as UICollectionView!)
		
		self.navigationController?.title = "Trending"
		//print("collectionview frame \(collectionView?.frame.origin.x)")
		// Do any additional setup after loading the view, typically from a nib.
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
	
}





