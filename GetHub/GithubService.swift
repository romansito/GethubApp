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
	
	class func getUser(completion: (user: User) -> ())  {
		
		if let token = OAuthClient.shared.token() {
			print(token)
			guard let baseURL = NSURL(string: "https://api.github.com/user") else {return}
			let request = NSMutableURLRequest(URL: baseURL)
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
			
			
			NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
				if let error = error {
					print(error)
				}
				if let response = response as? NSHTTPURLResponse {
					print(response.statusCode)
					if response.statusCode == 200 {
						if let data = data {
//							NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//								if let user = User.users(data) {
//									completion(user: user)
//								}
//							})
							
						}
					}
				}
				
				
				}.resume()
		}
	}
	
	
	
	
	
}
