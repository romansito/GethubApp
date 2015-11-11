//
//  ViewController.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/9/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBAction func requestToken(sender: UIButton) {
		
		OAuthClient.shared.requestGithubAccess()
	
	}
	
	@IBAction func printToken (sender: UIButton) {
	
		print(OAuthClient.shared.token())
		
		GithubService.getRepositories { (success, json) -> () in
			//
		}
	
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		//
	}


	
	
}

