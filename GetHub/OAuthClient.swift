//
//  OAuthClient.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/9/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

let KTokenKey = "KTokenKey"

class OAuthClient {
	
	// Create a Singleton 
	static let shared = OAuthClient()
	
// Lets create a function to request a Token from github. 
	func requestGithubAccess() {
		if let authURL = NSURL(string: "https://github.com/login/oauth/authorize?client_id=\(githubClientId)&scope=user,repo") {
			UIApplication.sharedApplication().openURL(authURL)
		}
	}
/* Now to turn that request token into our access token lets create another function to handle the response from Github
	once the user grants our application access */
	// since the only item in the query in the url is the request token we can get that code by calling .query on url.
	func exchangeCodeInURL(codeURL: NSURL, completion: (success: Bool) -> ()) {
		// Create the request to pass back to Github to get the access token.
		if let code = codeURL.query {
			let request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token?client_id=\(githubClientId)&client_secret=\(githubClientSecret)&\(code)")!)
			
			
			request.HTTPMethod = "POST"
			
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			
			NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
				if let httpResponse = response as? NSHTTPURLResponse {
					if httpResponse.statusCode == 200 && data != nil {
						
						do {
							if let rootObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject] {
								guard let token = rootObject["access_token"] as? String else {return}
								
								NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
									KeychainService.save(token)
									completion(success: true)
								})
						}
						} catch let error as NSError {
							print(error)
						}
					}
				}
			}).resume()
		}
	}
	
	// Save to token to NSUserDeafults
	func token() -> String? {
		guard let token = KeychainService.loadFromKeychain() else { return nil}
		
		return token as String
	}
}



































