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
	
	var bckType = BackgroundType.dark
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		collectionView.delegate = self
		collectionView.dataSource = self
    }

	@IBAction func segmentedControlPressed(_ sender: Any) {
		
		if let segControl = sender as? UISegmentedControl {
			if segControl.selectedSegmentIndex == 0 {
				bckType = .dark
				collectionView.reloadData()
			} else {
				bckType = .light
				collectionView.reloadData()
			}
		}
		
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
		cell.configureCell(forIndex: indexPath.row, withBackgroundType: bckType)
		return cell
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(
			top: 0,
			left: 5,
			bottom: 0,
			right: 5)
	}
	
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let width = (collectionView.frame.width / 3) - 10
		print(width)
		let height = width
		return CGSize(width: width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if bckType == .dark {
			UserDataService.instance.setAvatarName(name: "dark\(indexPath.row)")
		} else {
			UserDataService.instance.setAvatarName(name: "light\(indexPath.row)")
		}
		
		dismiss(animated: true, completion: nil)
	}
}

