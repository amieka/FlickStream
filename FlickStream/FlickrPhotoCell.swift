//
//  FlickrPhotoCell.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/11/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import UIKit
import Foundation

class FlickrPhotoCell: UICollectionViewCell {
	
	var Photo:Interestingness? {
		didSet {
			
			// set the title
			if let title = Photo?.title {
				thumbnailTitle.text = title
			}
			
			// fetch the thumbnail image
			if let thumbnailUrl = Photo?.thumbNailUrl {
				dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self ] in
					let data = NSData.init(contentsOfURL: thumbnailUrl as! NSURL)
					dispatch_async(dispatch_get_main_queue()) {
						self.thumbnailImage.image = UIImage(data: data!)
					}
				}
			}
			
			// fetch the image description
			
			//let getPhotoSuccessHandler:
			if let id = Photo?.id {
				typealias PhotoInfoType = (PhotoInfo) -> (Void)
				typealias PhotoInfoError = (FlickrAPIError) -> (Void)
				let photoSuccessHandler:PhotoInfoType = {
					photoInfo in
					//print("description: \(photoInfo.photo?.edescription)")
					dispatch_async(dispatch_get_main_queue(), {
						self.photoDetail.text = photoInfo.photo?.edescription as String!
					})
					
					
				}
				let photoErrorHandler:PhotoInfoError = {
					photoInfoError in
					print("getPhotoInfo error handler")
					
				}
				
				GetPhotoInfoAPI.callWithPhotoId(id as! String, completionHandler: photoSuccessHandler, errorHandler: photoErrorHandler)
				
				print("description\(id)")
			}
		}
	}
	
	
	
	let thumbnailImage:UIImageView = {
		let th = UIImageView()
		th.contentMode = .ScaleAspectFill
		th.layer.cornerRadius = 16
		th.layer.masksToBounds = true
		th.translatesAutoresizingMaskIntoConstraints = false
		return th
	}()
	
	let thumbnailTitle:UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFontOfSize(16)
		label.numberOfLines = 2
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let photoDetail:UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFontOfSize(12)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let thumbnailDescription:UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFontOfSize(14)
		label.numberOfLines = 2
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let dividerLine: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let subviewConstraints = [NSLayoutConstraint]()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpSubViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setUpSubViews()  {
		addSubview(thumbnailImage)
		addSubview(thumbnailTitle)
		//addSubview(dividerLine)
		addSubview(photoDetail)
		// title
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-90-[v0(200)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailTitle]))
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[v0(40)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailTitle]))
		// image
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[v0(75)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImage]))
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[v0(75)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImage]))
		
		// add constraints for photoDetail
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-90-[v0(200)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": photoDetail]))
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[v0(75)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": photoDetail]))
		
		
		//thumbnailTitle.frame = CGRectMake(90, 0, frame.width, 40)
		//dividerLineView.frame = CGRectMake(90, 90, frame.width - 10 , 1)
		//thumbnailImageView.frame = CGRectMake(10, 10, 75, 75)
		self.layer.borderWidth = 1
		self.layer.borderColor = UIColor.blueColor().CGColor
	}
	
	
	
}
