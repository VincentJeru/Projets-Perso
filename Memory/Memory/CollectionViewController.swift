//
//  CollectionViewController.swift
//  Memory
//
//  Created by Student on 22/02/2017.
//  Copyright © 2017 Student. All rights reserved.
//

import UIKit
import GameKit

var failed = 0

struct Score{
	static var monScore = 0
}

class MyCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var memoryCell: UICollectionViewCell!
	
	/*override func layoutSubviews() {
		super.layoutSubviews()
		backgroundColor = .darkGray
	}*/
}

class MyCollectionViewController: UICollectionViewController {

	var arrayOfCellValidated: [IndexPath] = []
	
	var backgroundsColoursTab:[UIColor] = [.red,
	                                       .blue,
										   .yellow,
	                                       .green,
	                                       .orange,
	                                       .purple,
	                                       .brown,
	                                       .red,
	                                       .blue,
	                                       .yellow,
	                                       .green,
										   .orange,
										   .purple,
										   .brown,
										   .magenta,
										   .magenta,
										   .lightGray,
										   .lightGray,
										   .cyan,
										   .cyan,
		
										  ]
	
	override func viewDidLoad(){
		super.viewDidLoad()
		
		collectionView?.allowsMultipleSelection = true
		
		backgroundsColoursTab = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: backgroundsColoursTab) as! [UIColor]
		
	}


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return backgroundsColoursTab.count
		//return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memoryCell", for: indexPath)
		//let item = backgroundsColoursTab[indexPath.item]
		
        // Configure the cell     Si elle a été sélectionnée on la met en rouge et on la désactive sinon on la met en blanc et on la laisse active (a changer avec un tableau de cellules validées)
	
		
		
		if (arrayOfCellValidated.contains(indexPath)){
			cell.backgroundColor = .black
			cell.isUserInteractionEnabled = false
		} else {
			cell.backgroundColor = .darkGray	// on (tente) d'utiliser le tableau de backgrounds aléatoire
			cell.isUserInteractionEnabled = true
		}
		
        return cell
		
    }
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		//let cell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
		let compteur = collectionView.indexPathsForSelectedItems?.count ?? 0
		var listOfIndexPathOfSelectedCells = collectionView.indexPathsForSelectedItems ?? []
		let item = backgroundsColoursTab[indexPath.item]
		
		let selectedCell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
		
		selectedCell.isUserInteractionEnabled = false

		selectedCell.backgroundColor = item
		
		if(compteur > 1){
			
			//for indexPathOfSelectedCell in listOfIndexPathOfSelectedCells{
			
			let item1 = backgroundsColoursTab[listOfIndexPathOfSelectedCells[0].item]
			let item2 = backgroundsColoursTab[listOfIndexPathOfSelectedCells[1].item]
			
			let selectedCell1 = collectionView.cellForItem(at: listOfIndexPathOfSelectedCells[0]) as? MyCollectionViewCell
			let selectedCell2 = collectionView.cellForItem(at: listOfIndexPathOfSelectedCells[1]) as? MyCollectionViewCell
			
			print("2 éléments selectionnés")
			
			if(selectedCell1 == selectedCell2){    // inutile??
				for ip in listOfIndexPathOfSelectedCells {
					collectionView.deselectItem(at: ip, animated: false)
				}
				return
			}
			if(item1 == item2){	// Si on a bien cliqué sur les 2 bonnes cellules identiques
				selectedCell1?.isUserInteractionEnabled = false
				selectedCell2?.isUserInteractionEnabled = false
				arrayOfCellValidated.append(listOfIndexPathOfSelectedCells[0])
				arrayOfCellValidated.append(listOfIndexPathOfSelectedCells[1])
				UIView.animate(withDuration: 3.0, animations: {
					selectedCell1?.backgroundColor = .black
					selectedCell2?.backgroundColor = .black
				})
				
				
				print("MAAATCH")
				
				for ip in listOfIndexPathOfSelectedCells {
					collectionView.deselectItem(at: ip, animated: false)
				}

			} else{
				UIView.animate(withDuration: 1.0, animations: {
					selectedCell1?.backgroundColor = .darkGray
					selectedCell2?.backgroundColor = .darkGray
					})
				
				selectedCell1?.isUserInteractionEnabled = true
				selectedCell2?.isUserInteractionEnabled = true
				if(selectedCell1?.isUserInteractionEnabled == true){
					print("Cell1Deselection!")
				}
				
				if(selectedCell2?.isUserInteractionEnabled == true){
					print("Cell2Deselecton!")
				}
				
				
				print("NOOOPE")
				failed += 1
				print("failed = \(failed)")
				
				for ip in listOfIndexPathOfSelectedCells {
					collectionView.deselectItem(at: ip, animated: false)
				}
			}
			if(arrayOfCellValidated.count == backgroundsColoursTab.count){
				
//				Score.monScore = backgroundsColoursTab.count
				Score.monScore = 0
				Score.monScore += arrayOfCellValidated.count
				Score.monScore -= failed
				
				print("score = \(Score.monScore)")
				print("failed = \(failed)")
				dismiss(animated: true, completion: nil)
			}
		}
		
	}
		
	
	override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		let cell = collectionView.cellForItem(at: indexPath)
		
		let listOfIndexPathOfSelectedCells = collectionView.indexPathsForSelectedItems ?? []
		
		cell?.backgroundColor = .darkGray
		
		cell?.isUserInteractionEnabled = true
		
		print("NOOOOPE.... désélection")
		for ip in listOfIndexPathOfSelectedCells {
			collectionView.deselectItem(at: ip, animated: false)
		}
		
		
	}
}
