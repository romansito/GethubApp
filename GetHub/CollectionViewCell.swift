//
//  CollectionViewCell.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/13/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
	
	
	@IBOutlet weak var imageView: UIImageView!
	
	var user : User! {
		
		didSet {
			
			self.layer.cornerRadius = 10.0
			NSOperationQueue().addOperationWithBlock { () -> Void in
				
				if let imageUrl = NSURL(string: self.user.avatarURL) {
					guard let imageData = NSData(contentsOfURL: imageUrl) else {return}
					let image = UIImage(data: imageData)
					NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
						self.imageView.image = image
					})
				}
			}
			
		}
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.imageView.image = nil
	}

	
}
