//
//  APIConstants.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/4/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation


struct FlickrAPIConstants {
	static let API_SCHEME = "https"
	static let API_HOST = "api.flickr.com"
	static let API_PATH = "/services/rest"
	static let STATIC_FLICKR = "staticflickr.com"
	
	
	// Common API params
	struct FlickrAPIKeys {
		static let API_KEY = "api_key"
		static let API_METHOD = "method"
		static let PAGE = "page"
		static let PER_PAGE = "per_page"
		static let DATE = "date"
		static let PAYLOAD_FORMAT = "format"
		static let NOJSON = "nojsoncallback"
		static let PHOTO_ID = "photo_id"
	}
	
	// API spec for flickr.interestingness.getList
	struct FlickrAPIValues {
		static let API_VALUE = Constants.FlickrAPI.API_KEY
		static let INTERESTINGNESS_METHOD = "flickr.interestingness.getList"
		static let GET_INFO_METHOD = "flickr.photos.getInfo"
		static let PER_PAGE_VALUE = "10"
		static let PAGE_VALUE = "1"
		static let DATE_VALUE = ""
		static let FORMAT = "json"
		static let NOJSON = "1"
	}
	
}

