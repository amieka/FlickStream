//
//  GetPhotoInfoAPI.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/11/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import UIKit
import Foundation

class GetPhotoInfoAPI: NSObject {
	static let kAPI = FlickrAPIConstants.self
	static func callWithPhotoId(id:String, completionHandler:(PhotoInfo) -> (), errorHandler:(FlickrAPIError) -> () ) {
		
		let parametersPair = [
			
			kAPI.FlickrAPIKeys.API_KEY :kAPI.FlickrAPIValues.API_VALUE,
			kAPI.FlickrAPIKeys.API_METHOD : kAPI.FlickrAPIValues.GET_INFO_METHOD,
			kAPI.FlickrAPIKeys.NOJSON : kAPI.FlickrAPIValues.NOJSON,
			kAPI.FlickrAPIKeys.PAYLOAD_FORMAT: kAPI.FlickrAPIValues.FORMAT,
			kAPI.FlickrAPIKeys.PHOTO_ID: id
		]
		
		let apiUrl = urlBuilder(parametersPair)
		let urlSession = NSURLSession.sharedSession()
		let request = NSURLRequest(URL: apiUrl)
		
		//print("getInfo request \(request)")
		
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
			let photoInfo = PhotoInfo()
			do {
				
				parsedResults = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
				let photo = parsedResults["photo"] as! [String:AnyObject]
				let description = photo["description"] as! [String:AnyObject]
				
				photoInfo.photo = Photo()
				photoInfo.photo?.edescription = description["_content"] as! String!
				photoInfo.stat = parsedResults["stat"] as! String!
				
				completionHandler(photoInfo)
				
				
			} catch {
				print("There was an error parsing data as json")
			}
			
		}
		
		task.resume()
		
	}

}
