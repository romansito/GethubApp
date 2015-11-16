//
//  UserDetailViewController.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/14/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UIViewControllerTransitioningDelegate {
	
	var user: User?
	
	@IBAction func backbutton(sender: AnyObject) {
		self.performSegueWithIdentifier(SearchUserViewController.identifier(), sender: sender)
	}
	
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var userImage: UIImageView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		downloadImage()

		let customTransition = CustomTransition(duratioin: 3.0)
		
		userNameLabel.text = user?.login
		if let url = NSURL(string: (user?.avatarURL)!) {
			NSOperationQueue().addOperationWithBlock({ () -> Void in
				let imageData = NSData(contentsOfURL: url)!
				let image = UIImage(data: imageData)
				self.userImage.image = image
			}
		)}

		func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
			return customTransition
		}
	}
	
	func downloadImage () {
		guard let string = user?.avatarURL else {return}
		print("is it getting the image\(string)")
		guard let url = NSURL(string: (string)) else { return }
		
		let downloadQ = dispatch_queue_create("downloadQ", nil)
		print("is it downloading the q?")
		dispatch_async(downloadQ, { () -> Void in
			let imageData = NSData(contentsOfURL: url)!
			
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				guard let image = UIImage(data: imageData) else { return }
				self.userImage.image = image
			})
		})
		
	}

}
