//
//  ViewController.swift
//  PokeAPI
//
//  Created by Will Carpenter on 8/27/16.
//  Copyright © 2016 SwiftyHacker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	@IBOutlet weak var collection: UICollectionView!
	
	var pokemon = [Pokemon]()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		collection.dataSource = self
		collection.delegate = self
		
		parsePokemonCSV()
		
	}
	
	func parsePokemonCSV(){
		
		let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
		
		do {
			
			let csv = try CSV(contentsOfURL: path)
			let rows = csv.rows
			
			print(rows)
			
			for row in rows {
				
				let pokeId = Int(row["id"]!)!
				let name = row["identifier"]!
				
				let poke = Pokemon(name: name, pokedexId: pokeId)
				pokemon.append(poke)
				
			}
			
		}catch let err as NSError{
			print(err.debugDescription)
		}
		
		
		
	}
	
	// returns the "identifier cell"
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
			
			let poke = pokemon[]
			cell.configureCell(poke)
			
			return cell
			
		} else {
			
			return UICollectionViewCell()
		}
		
	}
	
	// this will be an IBAction, what occurs when the cell is touched
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		
	}
	
	// straightforward - how many you want per section?
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return pokemon.count
	}
	
	// how many sections?
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		
		return 1
	}
	
	// defines the size, programmatically rather than in storyboard
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: 105, height: 105)
	}

	
	

}

