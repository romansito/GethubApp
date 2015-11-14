//
//  Repository .swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/10/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import Foundation

class Repository {
	
	let name: String
	let description: String?
	let id: Int
	
	init(name: String, description: String?, id: Int) {
		self.name = name
		self.description = description
		self.id = id
		
	}
}
