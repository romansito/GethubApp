//
//  GithubService.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/10/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import Foundation


class GithubService {
	
	class func getRepositories(completion: (success : Bool, json: [AnyObject]) -> () ) {
		if let token = OAuthClient.shared.token() {
			guard let url = NSURL(string: "https://api.github.com/user/repos?access_token=\(token)") else { return }
			
			let request = NSMutableURLRequest(URL: url)
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			request.HTTPMethod = "GET"
			
			NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
				
				if let error = error {
					print(error)
					return
				}
				
				if let data = data {
					
					do {
						let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
						print(json)
					} catch _ {}
					
				}
				
			}).resume()
		}
	}
}
