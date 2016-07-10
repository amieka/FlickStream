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
	
	var PhotoDetail:PhotoInfo? {
		didSet {
			
		}
	}
	
	override init(frame: CGRect) {
		self.verticalStack = UIStackView()
		self.horizontalStack = UIStackView()
		self.photoDetailImage = UIImageView()
		self.ratingCount = UILabel()
		self.commentsCount = UILabel()
		super.init(frame: frame)
		self.layOutViews()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}

extension PhotoDetailView {
	private func layOutViews() {
		
	}
}
