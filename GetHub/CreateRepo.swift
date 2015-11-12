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
1. Create a dictionary. 
2. Creat the massege or request.
3. Make sure its running on the main thread. 
*/
	class func createNewRepo(name: String, homepage: String, description: String?) {
		do {
			guard let token = KeychainService.loadFromKeychain() else { return }
			guard let url = NSURL(string: "\(kOAuthBaseURL)/user/repos?access_token=\(token)") else { return }
		let request = NSMutableURLRequest(URL: url)
		request.HTTPMethod = "POST"
		var parameters = [String : String]()
		parameters["name"] = name
		if let description = description {
			parameters["description"] = description
		}
		request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted) as NSData
		NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
			if let _ = response as? NSHTTPURLResponse {
				//
			}
			if let _ = error {
				print("error on your createRepo")
			}
			if let data = data {
				print(data)
			}
			}.resume()
			
		} catch {}
	}


}














































