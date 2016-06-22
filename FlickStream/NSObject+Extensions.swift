//
//  NSObject+Extensions.swift
//  FlickStream
//
//  Created by Arunoday Sarkar on 6/19/16.
//  Copyright © 2016 Sark Software LLC. All rights reserved.
//

import Foundation

extension NSObject {
	public func safe_setValuesForKeysWithDictionary(keyedValues: [String : AnyObject])  {
		let properties = Mirror(reflecting: self)
		for (property, value) in properties.children {
			
			guard case let val? = keyedValues[property!] as AnyObject! else {
				print("property not found, \(property as String!)")
				continue
			}
			
			self.setValue(val, forKey: property as String!)
			
		}
	}
}
