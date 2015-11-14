//
//  FLO.swift
//  GetHub
//
//  Created by Roman Salazar Lopez on 11/13/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

import UIKit

class FLO: UICollectionViewFlowLayout {
	
	init(colums: Int) {
		
		super.init()
		
		let frame = UIScreen.mainScreen().bounds
		let width = CGRectGetWidth(frame)
		
		let sizeWidth = (width / CGFloat(colums)) - 1.0
		
		self.itemSize = CGSize(width: sizeWidth, height: sizeWidth)
		self.minimumInteritemSpacing = 1.0
		self.minimumLineSpacing = 1.0
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

}
