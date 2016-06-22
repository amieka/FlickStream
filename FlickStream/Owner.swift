//
//  Owner.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/12/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation

class Owner: NSObject {
	var nsid:String?
	var id: String?
	var ispro: AnyObject?
	var can_buy_pro: AnyObject?
	var path_alias: AnyObject?
	var has_status: AnyObject?
	var expire: NSNumber?
	var username:[String:AnyObject]?
	var realname: [String:AnyObject]?
	var iconserver:String?
	var iconfarm:AnyObject?
}
