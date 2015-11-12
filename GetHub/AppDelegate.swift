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

	var oauthViewController : OAuthViewController?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		lookForToken()
		return true
	}
	
	// Once the user granted us access to Github will send back a url with the request token using our Applications URI Scheme. 
	func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
		return true
	}
	
	func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
		OAuthClient.shared.exchangeCodeInURL(url) { (success) -> () in
			if success {
				
				if let oauthViewController = self.oauthViewController {
					oauthViewController.view.removeFromSuperview()
					oauthViewController.removeFromParentViewController()
				}
				
			}
		}
		return true
	}
	
	// MARK: Setup
	
	
//	 check for Authorization
	
	func lookForToken() {
		
		if let _ = OAuthClient.shared.token() {
			
		} else {
			
			if let homeViewController = self.window?.rootViewController as? HomeViewController, storyboard = homeViewController.storyboard {
				if let oauthViewController = storyboard.instantiateViewControllerWithIdentifier(OAuthViewController.identifier()) as? OAuthViewController {
					homeViewController.addChildViewController(oauthViewController)
					homeViewController.view.addSubview(oauthViewController.view)
					oauthViewController.didMoveToParentViewController(homeViewController)
					self.oauthViewController = oauthViewController
				}
			}
			
		}
		
	}

	
	
	
	
	
}
	
		

	
	



















































