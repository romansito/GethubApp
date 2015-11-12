//
//  CreateRepo.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/11/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import Foundation

class CreateRepo {
	
	/*
	Steps to create a new Repository
	Create a token,
	create a url
	create a diccionary with paramenters
	let body = NSSerialization
	create resquest.
	*/
	

	
	class func createNewRepo(name: String, description: String?, completion:(success: Bool, error: String?, statusCode: Int?) -> ()  ) {
		if let token = OAuthClient.shared.token() {
			if let url = NSURL(string: "https://api.github.com/user/repos?access_token=\(token)") {
				
				let request = NSMutableURLRequest(URL: url)
				request.HTTPMethod = "POST"
				
				do {

					request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(["name":name], options: NSJSONWritingOptions.PrettyPrinted)
					
					NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
						
						if let error = error {
							print(error)
						}
						
						if let data = data {
							do {
								
								let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
								print(json)
								print(response)
								
							} catch {}
						}
						
					}).resume()
					
				} catch let error {
					print(error)
				}
			}
			
		}
		
	}
	
	
}














































