//
//  ViewController.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/4/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

	let cellId = "CellId"
	let searchAPI = InterestingnessAPI()
	var interestingness:[Interestingness]?
	var collectionView:UICollectionView?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let flowLayOut = UICollectionViewFlowLayout()
		collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayOut)
		collectionView?.registerClass(FlickrPhotoCell.self, forCellWithReuseIdentifier: cellId)
		collectionView?.delegate = self
		collectionView?.dataSource = self
		collectionView?.backgroundColor = UIColor.whiteColor()
		self.view.addSubview(collectionView!)
		self.navigationController?.title = "Trending"
		
		//print("collectionview frame \(collectionView?.frame.origin.x)")
		// Do any additional setup after loading the view, typically from a nib.
		typealias interesting = ([Interestingness]) -> (Void)
		typealias apierror = (FlickrAPIError) -> (Void)
		let successHandler:interesting = {interestingness in
			self.interestingness = interestingness
			dispatch_async(dispatch_get_main_queue(), {
				self.collectionView?.reloadData()
			})
		}
		
		let errorHandler:apierror = { error in
			// handle error here
		}
		
		searchAPI.callAPI(successHandler, errorHandler: errorHandler)
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! FlickrPhotoCell
		
		// Set the interestingness info to the Cell and return
		cell.Photo = interestingness?[indexPath.item]
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let count = interestingness?.count {
			return count
		}
		return 0
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		
		return CGSizeMake(view.frame.width, 100)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(0, 14, 0, 14)
	}

}





