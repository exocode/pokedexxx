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

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonName.text = pokemon.name.capitalizedString
        pokemonImage.image = UIImage(named: "\(pokemon.pokedexId)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
