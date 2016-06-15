//
//  Photo.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/12/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation

class Photo: NSObject {
	var id: String?
	var secret: String?
	var server: NSNumber?
	var farm: NSNumber?
	var dateuploaded: NSDate?
	var isfavorite: NSNumber?
	var license: NSNumber?
	var safety_level: String?
	var rotation: NSNumber?
	var originalsecret: String?
	var originalformat: String?
	var owner: Owner?
	var title: AnyObject?
	var edescription: String?
	var visibility: AnyObject?
	var dates: AnyObject?
	var views: String?
	var publiceditability: AnyObject?
	var usage: AnyObject?
	var comments: AnyObject?
	var notes: AnyObject?
	var people: AnyObject?
	var tags: AnyObject?
	var urls: AnyObject?
}
