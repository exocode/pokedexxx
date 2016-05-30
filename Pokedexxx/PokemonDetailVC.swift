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
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonName.text = pokemon.name.capitalizedString
        pokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")

        // Do any additional setup after loading the view.
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
