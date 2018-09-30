//
//  AvatarPickerViewController.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController {

	
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		collectionView.delegate = self
		collectionView.dataSource = self
    }

	@IBAction func segmentedControlPressed(_ sender: Any) {
	}
	
	
	@IBAction func dismiss(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}


extension AvatarPickerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 28
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as! AvatarCollectionViewCell
		cell.setUpView()
		return cell
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(
			top: 0,
			left: 0,
			bottom: 0,
			right: 0)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let width = (collectionView.frame.width / 3)
		print(width)
		let height = width
		return CGSize(width: width, height: height)
	}
}







