//
//  ModelExtensions.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/10/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import Foundation

class GetUser {
	
	class func UserJSON(user : [String : AnyObject]) -> User? {
		
		do {
			if let name = user["name"] as? String, avatarURL = user["avatar_url"] as? String {
				return User(name : name, avatarURL: avatarURL)
				
				
			}
			return nil
		}
	}		
}