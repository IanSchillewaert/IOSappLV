//
//  Locatie.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 03/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import Foundation
import RealmSwift

class Locatie: Object {
    
    @objc dynamic var naam : String = ""
    @objc dynamic var omschrijving : String = ""
    @objc dynamic var plaatsen : Int = 0
    
    convenience init(naam:String, omschrijving:String, plaatsen:Int)
    {
        self.init()
        self.naam = naam
        self.omschrijving = omschrijving
        self.plaatsen = plaatsen
    }
}


