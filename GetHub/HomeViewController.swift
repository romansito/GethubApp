//
//  ViewController.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/9/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		CreateRepo.createNewRepo("New Cool Repo 2", description: "Test repo from Gethub app") { (success, error, statusCode) -> () in
			print("call completion handler for createNewRepo")
			if success == true {
				print("yaya")
			} else {
				guard let error = error else { return }
				guard let status = statusCode else { return }
				print("You got an error\(error), with statusCode\(statusCode)")
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		//
	}


	
	
}

