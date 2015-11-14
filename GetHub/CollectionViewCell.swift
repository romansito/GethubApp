//
//  CollectionViewCell.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/13/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
	

	
	
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
