//
//  ViewController.swift
//  Pokedexxx
//
//  Created by Jan Jezek on 29.05.16.
//  Copyright © 2016 mediatainment-productions. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        

        // Write "Done / Fertig" in Keyboard instead of "Return"
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        initAudio()
        parsePokemonCSV()
    }
    
    func initAudio() {
        
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
    
        do {
            // we dont need var or let, because it's defined above
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path))
            musicPlayer.prepareToPlay()
            musicPlayer.volume = 0.3
            musicPlayer.numberOfLoops = 10
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV(){
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            
            let csv = try (CSV(contentsOfURL: path))
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let pokeName = row["identifier"]!
                let poke = Pokemon(name: pokeName, pokedexId: pokeId)
                
                pokemons.append(poke)
            }
            

        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    // everytime it needs a cell, we give it
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // take a unused cell and add our content
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let pokes: Pokemon!
            
            if inSearchMode {
                pokes = filteredPokemon[indexPath.row]
            } else {
                pokes = pokemons[indexPath.row]
            }
                
                
            cell.configureCell(pokes)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    // whenever selected an item
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemons[indexPath.row]
        }
        // we do the transition manually because we are passing DATA.
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
    
    
    // prepare the destination view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC" {
            // we assign detailsVC when the destinationController is a PokemonDetailVC
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                // if sender is a Pokemon ( we have done this by "performSegueWithIdentifier" in "didSelectAtIndexPath" ) assign it to poke
                if let poke = sender as? Pokemon {
                    // sticking the poke into the detailsViewController
                    detailsVC.pokemon = poke
                    
                }
            }
        }
    }
    
    // how many items you wanna show
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemons.count
    
    }
    
    // sections
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //size of the cell
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    @IBAction func playBtnPressed(sender: UIButton!) {

        if musicPlayer.playing {
            musicPlayer.stop()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    // when search button clicked
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // behaviour when textDidChange in searchBar
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            
            // close the keyboard
            view.endEditing(true)
            
            // reload the data
            collection.reloadData()
        } else {
            
            inSearchMode = true
            let searchTerm = searchBar.text!.lowercaseString
            // search every entry of pokemons array and take the name and by rangeOfString
            // it adds if
            filteredPokemon = pokemons.filter({$0.name.rangeOfString(searchTerm) != nil})
            // dont forget to reload data
            collection.reloadData()
        }
    }

}