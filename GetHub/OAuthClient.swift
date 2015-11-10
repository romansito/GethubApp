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
	
	static let shared = OAuthClient()
	
//	Setup your Github client id and your client secret first.
	func requestGithubAccess() {
		if let authURL = NSURL(string: "\(kOAuthBaseURL)?client_id=\(githubClientId)&redirect_uri=githubclient://&scope=user,repo") {
			UIApplication.sharedApplication().openURL(authURL)
		}
	}
	
	func exchangeCodeInURL(codeURL: NSURL) {
		if let code = codeURL.query {
			let request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token?\(code)&client_id=\(githubClientId)&client_secret=\(githubClientSecret)")!)
			
			request.HTTPMethod = "POST"
			
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			
			
			NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
				if let httpResponse = response as? NSHTTPURLResponse {
					if httpResponse.statusCode == 200 && data != nil {
						do {
							if let rootObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject] {
								guard let token = rootObject["access_token"] as? String else {return}
							
								NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
									NSUserDefaults.standardUserDefaults().setObject(token, forKey: KTokenKey)
									NSUserDefaults.standardUserDefaults().synchronize()
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
	
	func token() -> String? {
		guard let token = NSUserDefaults.standardUserDefaults().stringForKey(KTokenKey) else {return nil}
		
		return token
	}
}



































