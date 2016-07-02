//
//  InterestingnessCollectionView.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/16/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation
import UIKit

protocol InterestingnessCellSelectedDelegate {
	func didSelectInterestingnessCell(interestingness:Interestingness) -> Void
}

class InterestingnessCollectionView: UICollectionView , UICollectionViewDataSource, UICollectionViewDelegate {
	
	var interestingness:[Interestingness]?
	let cellId = "CellId"
	var interestingnesscellSelectedDelegate:InterestingnessCellSelectedDelegate?
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		self.registerClass(FlickrPhotoCell.self, forCellWithReuseIdentifier: cellId)
		self.backgroundColor = UIColor.whiteColor()
		self.delegate = self
		self.dataSource = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! FlickrPhotoCell
		
		// Set the interestingness info to the Cell and return
		cell.PInterestingness = interestingness?[indexPath.item]
		
		return cell
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if let count = interestingness?.count {
			return count
		}
		return 0
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(self.frame.width, 100)
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(0, 14, 0, 14)
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		//let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FlickrPhotoCell
		let interestingnessDetail = interestingness?[indexPath.item] as Interestingness!
		self.interestingnesscellSelectedDelegate?.didSelectInterestingnessCell(interestingnessDetail)
		
	}
}



extension InterestingnessCollectionView {
	func refreshCollectionView(interestingness:[Interestingness])  {
		self.interestingness = interestingness
		reloadData()
	}
}


