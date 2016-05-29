//
//  Pokemon.swift
//  Pokedexxx
//
//  Created by Jan Jezek on 29.05.16.
//  Copyright © 2016 mediatainment-productions. All rights reserved.
//

import Foundation

class Pokemon {
    
    // private vars, only accessable from the class within
    private var _name: String!
    private var _pokedexId: Int!
    
    // getters
    var name: String {
        return _name
    }
    
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}