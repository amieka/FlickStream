//
//  FlickrAPIUrlBuilder.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/4/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation

func urlBuilder(urlParams: [String:AnyObject]) -> NSURL {
	let urlComponents = NSURLComponents()
	urlComponents.scheme = FlickrAPIConstants.API_SCHEME
	urlComponents.host = FlickrAPIConstants.API_HOST
	urlComponents.path = FlickrAPIConstants.API_PATH
	urlComponents.queryItems = [NSURLQueryItem]()
	for (key, value) in urlParams {
		let queryItem = NSURLQueryItem(name: key, value: "\(value)")
		urlComponents.queryItems!.append(queryItem)
	}
	return urlComponents.URL!
}

func staticPhotoUrlFromParams(farm_id:NSNumber, server_id:String, id:String, secret:String, type:String) -> NSURL {
	// https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
	// http://farm{icon-farm}.staticflickr.com/{icon-server}/buddyicons/{nsid}.jpg
	let staticPhotoUrlComponents = NSURLComponents()
	staticPhotoUrlComponents.scheme = FlickrAPIConstants.API_SCHEME
	staticPhotoUrlComponents.host = String(format: "farm%@.%@", farm_id, FlickrAPIConstants.STATIC_FLICKR)
	staticPhotoUrlComponents.path = String(format: "/%@/%@_%@_%@.jpg", server_id, id, secret, type)
	return staticPhotoUrlComponents.URL!
}

func staticProfilePhotoUrlFromParams(icon_farm:String, icon_server:String, id:String) -> NSURL {
	// http://farm{icon-farm}.staticflickr.com/{icon-server}/buddyicons/{nsid}.jpg
	let staticPhotoUrlComponents = NSURLComponents()
	staticPhotoUrlComponents.scheme = FlickrAPIConstants.API_SCHEME
	staticPhotoUrlComponents.host = String(format: "farm%@.%@", icon_farm, FlickrAPIConstants.STATIC_FLICKR)
	staticPhotoUrlComponents.path = String(format: "/%@/buddyicons/%@.jpg", icon_server, id)
	return staticPhotoUrlComponents.URL!
}


