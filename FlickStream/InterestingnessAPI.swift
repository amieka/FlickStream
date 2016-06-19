//
//  InterestingnessAPI.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/4/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation


class InterestingnessAPI: NSObject {
	let kAPI = FlickrAPIConstants.self
	func callAPI(completionHandler:([Interestingness]) -> (), errorHandler:(FlickrAPIError) -> () )  {
		let parametersPair = [
		
			kAPI.FlickrAPIKeys.API_KEY : kAPI.FlickrAPIValues.API_VALUE,
			kAPI.FlickrAPIKeys.API_METHOD : kAPI.FlickrAPIValues.INTERESTINGNESS_METHOD,
			kAPI.FlickrAPIKeys.NOJSON : kAPI.FlickrAPIValues.NOJSON,
			kAPI.FlickrAPIKeys.PAGE: kAPI.FlickrAPIValues.PAGE_VALUE,
			kAPI.FlickrAPIKeys.PER_PAGE: kAPI.FlickrAPIValues.PER_PAGE_VALUE,
			kAPI.FlickrAPIKeys.PAYLOAD_FORMAT: kAPI.FlickrAPIValues.FORMAT,
			kAPI.FlickrAPIKeys.EXTRAS : "\(kAPI.FlickrAPIValues.EXTRAS_ICON_SERVER), \(kAPI.FlickrAPIValues.EXTRAS_URL_S)"
		]
		
		print("API parameters,  \(parametersPair)")
		
		
		let apiUrl = urlBuilder(parametersPair)
		let urlSession = NSURLSession.sharedSession()
		let request = NSURLRequest(URL: apiUrl)
		
		print("API request \(request)")
		let task = urlSession.dataTaskWithRequest(request) { (data, response, error) in
			
			// helper function for printing API errors
			func displayError(error: String) {
				print(error)
				
			}
			
			guard (error == nil) else {
				print("there was an error \(error.debugDescription)")
				return
			}
			
			guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
				displayError("Your request returned a status code other than 2xx!")
				return
			}
			
			let parsedResult: AnyObject!
			var photoObjects = [Interestingness]()
			let apiError = FlickrAPIError()
			do {
				parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
				let stat = parsedResult[FlickrAPIConstants.FlickrAPIKeys.RESPONSE_STAT] as! String!
				
				// API returned an error handle it
				if stat ==  FlickrAPIConstants.FlickrAPIValues.RESPONSE_MESSAGE_FAIL {
					apiError.stat = stat
					apiError.code = parsedResult[FlickrAPIConstants.FlickrAPIKeys.RESPONSE_CODE] as! String!
					apiError.message = parsedResult[FlickrAPIConstants.FlickrAPIKeys.RESPONSE_MESSAGE] as! String!
					errorHandler(apiError)
					return
				}
				
				// Process each photo object
				let photos = parsedResult["photos"] as! [String:AnyObject]
				
				for photo in photos["photo"] as! [[String:AnyObject]] {
					let interestingness = Interestingness()
					interestingness.setValuesForKeysWithDictionary(photo)
					let staticPhotoUrl:NSURL = staticPhotoUrlFromParams(interestingness.farm as NSNumber! , server_id: interestingness.server as! String, id: interestingness.id as! String, secret: interestingness.secret as! String, type: "z")
					let thumbnailUrl:NSURL = staticPhotoUrlFromParams(interestingness.farm as NSNumber! , server_id: interestingness.server as! String, id: interestingness.id as! String, secret: interestingness.secret as! String, type: "s")
					interestingness.staticPhotoUrl = staticPhotoUrl
					interestingness.thumbNailUrl = thumbnailUrl
					photoObjects.append(interestingness)
				}
				
				completionHandler(photoObjects)
				
				
			} catch {
				displayError("Could not parse the data as JSON: '\(data)'")
				return
			}
			
			print("photos data \(photoObjects)")
			
		}
		task.resume()
		
	}
	
}
