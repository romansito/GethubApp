//
//  ModelExtensions.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/10/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import Foundation

class ModelParser {
	
	class func OwnerJSON(owner : [String : AnyObject]) -> Owner? {
		
		do {
			if let avatarURL = owner["avatar_url"] as? String, url = owner["url"] as? String, login = owner["login"] as? String {
				return Owner(avatarURL: avatarURL, url: url, login: login)
			}
			return nil
	}
}



}