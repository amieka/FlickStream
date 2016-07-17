//
//  InterestingnessDetailViewController.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 7/1/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation
import UIKit


class InterestingnessDetailViewController: UIViewController {
	var photoDetailView:PhotoDetailView?
	var interestingnessDetail:Interestingness?
	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.whiteColor()
		self.photoDetailView = PhotoDetailView(frame: self.view.frame)
		self.view.addSubview(self.photoDetailView!)
		
		super.viewDidLoad()
		
	}
	
	override func viewDidAppear(animated: Bool) {
		if let photoId = interestingnessDetail?.id as! String! {
			self.photoDetailView?.PhotoId = photoId
		}
		
		if let url_z = interestingnessDetail?.url_s as String! {
			self.photoDetailView?.urlZ = NSURL(string: url_z)
		}
		super.viewDidAppear(animated)
	}
	
	
	
}
