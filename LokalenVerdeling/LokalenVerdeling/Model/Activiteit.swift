//
//  Activiteit.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 03/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import Foundation
import RealmSwift

class Activiteit: Object {
    //Properties
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var datum = ""
    @objc dynamic var tak = ""
    @objc dynamic var omschrijving = ""
    @objc dynamic var locatie: Locatie?

    //init
    convenience init(datum:String, tak:String, omschrijving:String, locatie:Locatie)
    {
        self.init()
        self.datum = datum
        self.tak = tak
        self.omschrijving = omschrijving
        self.locatie = locatie
    }
    
    //Meta
    override static func primaryKey() -> String? {
        return "id"
    }
}
