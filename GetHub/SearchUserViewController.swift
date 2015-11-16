//
//  SearchUserViewController.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/13/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate {
	
	
	
	@IBOutlet weak var searchUserBar: UISearchBar!
	@IBOutlet weak var collectionView: UICollectionView!
	
	var users = [User]() {
		didSet {
			
			self.collectionView.reloadData()
		}
	}
	
	
	let customTransition = CustomTransition(duratioin: 2.0)
	
	class func identifier() -> String {
		return "SearchUserViewController"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.collectionView.collectionViewLayout = FLO(colums: 3)
	}
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		let searchTerm = searchUserBar.text
		if let searchTerm = searchTerm {
			self.update(searchTerm)
			print("search works")
			
		}
	}

	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.users.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
		let user = self.users[indexPath.row]
		cell.user = user
		return cell
		
	}
	
	func update(searchTerm : String) {
		
		if let token = OAuthClient.shared.token() {
			
			let url = NSURL(string: "https://api.github.com/search/users?access_token=\(token)&q=\(searchTerm)")!
			print("\(url)")
			let request = NSMutableURLRequest(URL: url)
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			
			NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
				
				if let error = error {
					print(error)
				}
				
				if let data = data {
					
					if let json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject] {
						
						if let items = json["items"] as? [[String : AnyObject]] {
							var users = [User]()
							
							for item in items {
								
								let login = item["login"] as? String
								let avatarURL = item["avatar_url"] as? String
								
								
								if let login = login, avatarURL = avatarURL {
									
									users.append(User(login: login, avatarURL: avatarURL))
									
								}
							}
							
							// This is because NSURLSession comes back on a background q.
							NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
								self.users = users
							})
						}
					}
				}
				
				}.resume()
		
			}

		}
	
	
	func collectionView(collection: UICollectionView, selectedItemIndex: NSIndexPath)
	{
		self.performSegueWithIdentifier("userDetailSegue", sender: self)
	}

	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "userDetailSegue" {
			if let cell = sender as? UICollectionViewCell, indexPath = collectionView.indexPathForCell(cell) {
				guard let userDetailViewController = segue.destinationViewController as? UserDetailViewController else {return}
				userDetailViewController.transitioningDelegate = self
				
				let user = users[indexPath.item]
				userDetailViewController.user = user
			}
		}
	}
	
	
	
	
	// MARK: Transition
	
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return self.customTransition
	}
	
	





}























