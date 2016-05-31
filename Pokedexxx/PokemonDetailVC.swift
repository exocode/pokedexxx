//
//  PokemonDetailVC.swift
//  Pokedexxx
//
//  Created by Jan Jezek on 30.05.16.
//  Copyright © 2016 mediatainment-productions. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonName.text = pokemon.name.capitalizedString
        pokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            // this will be called after the download is done
            // the magic are the closures "() -> () in"
            self.updateUI()
        }
    }
    
    func updateUI(){
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        currentEvoImg.image = UIImage(named: "\(pokemon.pokedexId)")
        if pokemon.nextEvolutionId == "" {
            evoLabel.text = "No Evolution"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLevel != "" {
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
        }
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
