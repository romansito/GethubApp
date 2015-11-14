//
//  SearchUserViewController.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/13/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class SearchUserViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
	
	@IBOutlet weak var searchUserBar: UISearchBar!
	@IBOutlet weak var collectionView: UICollectionView!
	
	var users = [User]() {
		didSet {
			self.collectionView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
//	func update(searchTerm: String) {
//		
//		if let token = OAuthClient.shared.token() {
//			
//			let url = NSURL(string: "https://api.github.com/search/users?access_token=\(token)&q=\(searchTerm)")!
//			
//			let request = NSMutableURLRequest(URL: url)
//			request.setValue("application/json", forHTTPHeaderField: "Accept")
//			
//			NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
//				
//				if let error = error {
//					print(error)
//				}
//				
//				if let data = data {
//					
//					if let json = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject] {
//						
//						if let items = json["items"] as? [[String : AnyObject]] {
//		
//							var users = [User]()
//							
//							for item in items {
//								
//								let name = item["login"] as? String
//								let avatarURL = item["avatar_url"] as? String
//								
//								if let name = name, avatarURL = avatarURL {
//									
//									users.append(User(name: name, avatarURL: avatarURL))
//									
//								}
//							}
//							
//							NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//								self.users = users
//							})
//							
//						}
//						
//					}
//					
//				}
//				
//				}.resume()
//		}
//	}

	
	
	

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		let searchTerm = searchUserBar.text
		if let searchTerm = searchTerm {
			self.update(searchTerm)
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
									let user = User(login: login, avatarURL: avatarURL)
									users.append(user)
								}
							}
							
							// This is because NSURLSession comes back on a background q.
							NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
								self.users = self.users
							})
						}
					}
				}
				
				}.resume()
		
			}

		}

	}

