//
//  SearchRepoViewController.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/13/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class SearchRepoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchRepoBar: UISearchBar!
	
	var repositories = [Repository]() {
		didSet {
			self.tableView.reloadData()
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.repositories.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		let repository = self.repositories[indexPath.row]
		cell.textLabel?.text = repository.name
		
		return cell
		
	}

	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		let searchTerm = searchBar.text
		if let searchTerm = searchTerm {
			self.update(searchTerm)

		}
		
	}
	
	func update(searchTerm : String) {
		
		if let token = OAuthClient.shared.token() {
			
			let url = NSURL(string: "https://api.github.com/search/repositories?access_token=\(token)&q=\(searchTerm)")!
			
			let request = NSMutableURLRequest(URL: url)
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			
			NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
				
				if let error = error {
					print(error)
				}
				
				if let data = data {
					
					if let arraysOfRepoDictionaries = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject] {
						
						if let items = arraysOfRepoDictionaries["items"] as? [[String : AnyObject]] {
							var repositories = [Repository]()
							
							for eachRepository in items {
								
								let name = eachRepository["name"] as? String
								let description = eachRepository["description"] as? String
								let id = eachRepository["id"] as? Int
								
								
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
				}
				
				}.resume()
		}
	}

}







