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
	var estimatedCellRects = [CGRect]()
	var PInterestingness:Interestingness? {
		didSet {
			
			// set the title
			if let title = PInterestingness?.title {
				thumbnailTitle.text = title
			}
			
			// fetch the thumbnail image
			if let thumbnailUrl = PInterestingness?.url_s as String! {
				dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self ] in
					let data = NSData.init(contentsOfURL: NSURL(string: thumbnailUrl)!)
					dispatch_async(dispatch_get_main_queue()) {
						if let imgData = data as NSData! {
							self.thumbnailImage.image = UIImage(data: imgData)
						}
					}
				}
			}
			
			if let profilPhotoUrl = PInterestingness?.profilePhotoUrl as NSURL! {
				dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self ] in
					let data = NSData.init(contentsOfURL: profilPhotoUrl)
					dispatch_async(dispatch_get_main_queue()) {
						if let imgData = data as NSData! {
							self.profileImage.image = UIImage(data: imgData)
						}
					}
				}
			}
			
			// fetch the image description
			
			if let photoOwner = PInterestingness?.owner {
				typealias OwnerInfoType = (Owner) -> (Void)
				typealias PhotoInfoError = (FlickrAPIError) -> (Void)
				let peopleInfoSuccessHandler:OwnerInfoType = {
					peopleInfo in
					
					dispatch_async(dispatch_get_main_queue(), { [unowned self] in
						print("person name \(peopleInfo.realname)")
						if let realName = peopleInfo.realname as [String:AnyObject]! {
							self.authorTitle.text = realName["_content"] as! String!
						}
					})
				}
				
				let peopleInfoErrorHandler:PhotoInfoError = {
					photoInfoError in
					print("getPeopleInfo error handler")
				}
				GetPeopleInfo.callAPIWithId(photoOwner as! String, completionHandler: peopleInfoSuccessHandler, errorHandler: peopleInfoErrorHandler)
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
	
	let profileImage:UIImageView = {
		let th = UIImageView()
		th.contentMode = .ScaleAspectFill
		th.layer.cornerRadius = 16
		th.layer.masksToBounds = true
		th.translatesAutoresizingMaskIntoConstraints = false
		return th
	}()
	
	let thumbnailTitle:UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFontOfSize(12)
		label.numberOfLines = 2
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let authorTitle:UILabel = {
		let label = UILabel()
		label.font = UIFont.italicSystemFontOfSize(12)
		label.numberOfLines = 2
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let photoDetail:UILabel = {
		let label = UILabel()
		label.font = UIFont.monospacedDigitSystemFontOfSize(13, weight: 300)
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
		addSubview(dividerLine)
		addSubview(profileImage)
		addSubview(authorTitle)
		
		thumbnailTitle.frame = CGRectMake(90, 10, frame.width, 40)
		dividerLine.frame = CGRectMake(90, 90, frame.width - 10 , 1)
		thumbnailImage.frame = CGRectMake(10, 10, 75, 75)
		profileImage.frame = CGRectMake(frame.width - 40, 40, 30, 30)
		authorTitle.frame = CGRectMake(90, 40, 100, 30)
		
	}

}
