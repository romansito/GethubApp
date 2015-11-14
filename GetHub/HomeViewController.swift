//
//  ViewController.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/9/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	
	@IBOutlet weak var searchBar: UISearchBar!
	
	
	var repositories = [Repository]() {
		didSet {
			self.tableView.reloadData()
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.update()
		
		
		CreateRepo.createNewRepo("New Cool Repo 3", description: "Test repo from Gethub app") { (success, error, statusCode) -> () in
			print("call completion handler for createNewRepo")
			if success == true {
				print("yaya")
			} else {
				guard let error = error else { return }
				guard let _ = statusCode else { return }
				print("You got an error\(error), with statusCode\(statusCode)")
			}
		}
	}
	
	func update() {
		
		if let token = OAuthClient.shared.token() {
			
			let url = NSURL(string: "https://api.github.com/user/repos?access_token=\(token)")!
			
			let request = NSMutableURLRequest(URL: url)
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			
			NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
				
				if let error = error {
					print(error)
				}
				
				if let data = data {
					if let arraysOfRepoDictionaries = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
						
						var repositories = [Repository]()
						
						for eachRepository in arraysOfRepoDictionaries {
							
							let name = eachRepository["name"] as? String
							let description = eachRepository["description"] as? String
							let id = eachRepository["id"] as? Int
//							let description = eachRepository["description"] as? String?
							
							
							if let name = name, description = description, id = id {
								let repo = Repository(name: name, description: description, id: id)
								repositories.append(repo)
							}
						}
						
						// This is because NSURLSession comes back on a background q.
						NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
							self.repositories = repositories
						})
					}
				}
				
				}.resume()
		}
	}
	
	
	
	
	
	
	
	// MARK: UITableViewDataSource
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.repositories.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		let repository = self.repositories[indexPath.row]
		
		cell.textLabel?.text = repository.name
//		cell.textLabel?.text = repository.description
//		cell.textLabel?.text = repository.\"(id)"
		
		return cell
		
	}
	
	
	
	
	
}