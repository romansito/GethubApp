//
//  OAuthViewController.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/10/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

	@IBAction func loginButton(sender: UIButton) {
		OAuthClient.shared.requestGithubAccess()
	}
	
	
	class func identifier() -> String {
		return "OAuthViewController"
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
