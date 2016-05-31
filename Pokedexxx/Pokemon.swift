//
//  Pokemon.swift
//  Pokedexxx
//
//  Created by Jan Jezek on 29.05.16.
//  Copyright © 2016 mediatainment-productions. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    // private vars, only accessable from the class within
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _pokemonUrl: String!
    
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
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
       
        let url = NSURL(string: _pokemonUrl)!
        
        // make a request to your API
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let type = types[0]["name"] {
                        self._type = type
                    }
                    
                    if types.count > 1 {
                        
                        // swift 3 style instead of 
                        // var x = 1; x < types.count; x++
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name)"
                            }
                        }
                    } else {
                        self._type = ""
                    }
                    
                    if let descArr = dict["descriptions"] as? [Dictionary<String,String>] where descArr.count > 0 {
                        if let url = descArr[0]["resource_uri"] {

                            let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                            Alamofire.request(.GET, nsurl).responseJSON { response in
                                
                                let descResult = response.result
                                if let descDict = descResult.value as? Dictionary<String, AnyObject> {

                                    if let description = descDict["description"] as? String {
                                        self._description = description
                                        debugPrint(self._description)
                                    }
                                }
                            }
                        }
                    } else {
                        self._description = ""
                    }
                }
            }
        }
    }
}