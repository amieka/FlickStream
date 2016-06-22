//
//  GetPeopleInfo.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/19/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation

class GetPeopleInfo: NSObject {
	static let kAPI = FlickrAPIConstants.self
	static func callAPIWithId(userid:String, completionHandler:(Owner) -> (), errorHandler:(FlickrAPIError) -> ()) {
		// https://api.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=1f96d6cb44a1b19ff6922f9d914f7875&user_id=110870569%40N08&format=json&nojsoncallback=1
		let parametersPair = [
			
			kAPI.FlickrAPIKeys.API_KEY :kAPI.FlickrAPIValues.API_VALUE,
			kAPI.FlickrAPIKeys.API_METHOD : kAPI.FlickrAPIValues.GET_PEOPLE_INFO,
			kAPI.FlickrAPIKeys.NOJSON : kAPI.FlickrAPIValues.NOJSON,
			kAPI.FlickrAPIKeys.PAYLOAD_FORMAT: kAPI.FlickrAPIValues.FORMAT,
			kAPI.FlickrAPIKeys.USER_ID: userid
		]
		
		let apiUrl = urlBuilder(parametersPair)
		let urlSession = NSURLSession.sharedSession()
		let request = NSURLRequest(URL: apiUrl)
		
		let task = urlSession.dataTaskWithRequest(request) { (data, response, error) in
			guard(error == nil) else {
				print("error caused \(error .debugDescription)")
				return
			}
			
			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
				print("Your request returned a status code other than 2xx!")
				return
			}
			
			let parsedResults: AnyObject!
			let owner = Owner()
			let apiError = FlickrAPIError()
			do {
				
				parsedResults = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
				let stat = parsedResults[FlickrAPIConstants.FlickrAPIKeys.RESPONSE_STAT] as! String!
				if stat == FlickrAPIConstants.FlickrAPIValues.RESPONSE_MESSAGE_FAIL {
					apiError.stat = stat
					apiError.message = parsedResults[FlickrAPIConstants.FlickrAPIKeys.RESPONSE_MESSAGE] as! String!
					apiError.code = parsedResults[FlickrAPIConstants.FlickrAPIKeys.RESPONSE_CODE] as? NSNumber
					errorHandler(apiError)
					return
				}
				//owner.setValuesForKeysWithDictionary(parsedResults["person"] as! [String:AnyObject])
				owner.safe_setValuesForKeysWithDictionary(parsedResults["person"] as! [String:AnyObject])
				completionHandler(owner)
			} catch {
				print("There was an error parsing data as json")
			}
			
		}
		
		task.resume()
	}
}
