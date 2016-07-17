//
//  PhotoDetailView.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 7/10/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailView: UIView {
	
	let verticalStack:UIStackView?
	let horizontalStack:UIStackView?
	let photoDetailImage: UIImageView?
	let ratingCount: UILabel?
	let commentsCount: UILabel?
	
	var urlZ: NSURL? {
		didSet {
			if let url = urlZ as NSURL! {
				print("final url \(url)")
				dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self ] in
					let data = NSData.init(contentsOfURL: url)
					dispatch_async(dispatch_get_main_queue()) {
						if let imgData = data as NSData! {
							self.photoDetailImage?.image = UIImage(data: imgData)
						}
						
						self.ratingCount?.text = "One"
						self.commentsCount?.text = "two"
					}
				}
			}
		}
	}
	
	var PhotoId:String?
	//{
//		
//		
//		didSet {
//			
//			if let id = PhotoId as String! {
//				typealias completionHandler = (PhotoInfo) -> (Void)
//				typealias errorHandler = (FlickrAPIError) -> (Void)
//				
//				let successHandler:completionHandler  = { photoInfo in
//					print("sucees calling photoinfo api \(photoInfo.description)")
//					
//				}
//				
//				let apiErrorHandler: errorHandler  = { error in
//					print("error occured in getting photo info \(error)")
//				}
//				
//				GetPhotoInfoAPI.callWithPhotoId(id, completionHandler: successHandler, errorHandler: apiErrorHandler)
//			}
//			
//		}
//			
//	}
	
	override init(frame: CGRect) {
		self.verticalStack = UIStackView()
		self.horizontalStack = UIStackView()
		self.photoDetailImage = UIImageView()
		self.ratingCount = UILabel()
		self.commentsCount = UILabel()
		super.init(frame: frame)
		self.configureSubViews()
		//self.fetchPhotoDetail()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

extension PhotoDetailView {
	private func configureSubViews() {
		print("configure subviews")
		verticalStack?.translatesAutoresizingMaskIntoConstraints = false
		horizontalStack?.translatesAutoresizingMaskIntoConstraints = false
		
		// configure vertical stackview
		verticalStack?.axis = .Vertical
		verticalStack?.alignment = .Fill
		verticalStack?.spacing = 5
		verticalStack?.distribution = .FillEqually
		
		// configure the horizontal stackview
		
		horizontalStack?.axis = .Horizontal
		horizontalStack?.alignment = .Fill
		horizontalStack?.spacing = 25
		horizontalStack?.distribution = .FillEqually
		
		
		
		
		ratingCount?.backgroundColor = UIColor.clearColor()
		ratingCount?.font = UIFont.italicSystemFontOfSize(14)
		
		commentsCount?.backgroundColor = UIColor.clearColor()
		commentsCount?.font = UIFont.italicSystemFontOfSize(14)
		
		// Add arranged subviews for
		
		horizontalStack?.addArrangedSubview(ratingCount!)
		horizontalStack?.addArrangedSubview(commentsCount!)
		
		verticalStack?.addArrangedSubview(photoDetailImage!)
		verticalStack?.addArrangedSubview(horizontalStack!)
		
		
	}
	
	private func fetchPhotoDetail() {
//		if let id = PhotoId as String! {
//			typealias completionHandler = (PhotoInfo) -> (Void)
//			typealias errorHandler = (FlickrAPIError) -> (Void)
//			
//			let successHandler:completionHandler  = { photoInfo in
//				print("sucees calling photoinfo api \(photoInfo.description)")
//				if let urls = photoInfo.photo?.urls as! [NSURL]! {
//					print("list of urls \(urls)")
//				}
//				
//			}
//			
//			let apiErrorHandler: errorHandler  = { error in
//				print("error occured in getting photo info \(error)")
//			}
//			
//			GetPhotoInfoAPI.callWithPhotoId(id, completionHandler: successHandler, errorHandler: apiErrorHandler)
//		}
		
		
		
		print("url \(urlZ)")

	}
	
	override func layoutSubviews() {
		self.addSubview(verticalStack!)
		// Main UIStackView contraints, nearly fills its parent view
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[verticalStack]-44-|",
			options: NSLayoutFormatOptions.AlignAllLeading,metrics: nil, views: ["verticalStack":verticalStack!]))
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[verticalStack]-10-|",
			options: NSLayoutFormatOptions.AlignAllLeading,metrics: nil, views: ["verticalStack":verticalStack!]))

	}
}
