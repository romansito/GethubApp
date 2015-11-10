//
//  AppDelegate.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/9/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	// Once the user granted us access to Github will send back a url with the request token using our Applications URI Scheme. 
	func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
		return true
	}
	
//	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//		OAuthClient.shared.exchangeCodeInURL(url)
//		return true
//	}

}

















































