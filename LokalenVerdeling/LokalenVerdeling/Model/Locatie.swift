//
//  Locatie.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 03/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import Foundation
import RealmSwift

/*class Locatie {
    var naam: String
    var plaatsen: Int
    var omschrijving: String
    init(naam:String, omschrijving:String, plaatsen:Int) {
        self.naam = naam
        self.plaatsen = plaatsen
        self.omschrijving = omschrijving
    }
}*/

class Locatie: Object {
    //Properties
    @objc dynamic var naam = ""
    @objc dynamic var omschrijving = ""
    @objc dynamic var plaatsen = 0
    
    //init
    convenience init(naam:String, omschrijving:String, plaatsen:Int)
    {
        self.init()
        self.naam = naam
        self.omschrijving = omschrijving
        self.plaatsen = plaatsen
    }
    
    //Meta
    override static func primaryKey() -> String? {
        return "naam"
    }
    
    //locaties aanmaken
     private static func createLocations(in realm:Realm) -> Locatie{
        let beneden = Locatie(naam: "Beneden", omschrijving: "Grote zaal beneden in het lokaal", plaatsen: 2)
        let keuken = Locatie(naam: "Keuken", omschrijving: "Keuken in het lokaal", plaatsen: 1)
        let boven = Locatie(naam: "Boven", omschrijving: "Zaal boven", plaatsen: 1)
        let mezanine = Locatie(naam: "Mezanine", omschrijving: "Kleine zaal helemaal boven.", plaatsen: 1)
        let klaver = Locatie(naam: "De Klaver", omschrijving: "Zaal kleuterblok basisschool De Klaver", plaatsen: 1)
        let speelveld = Locatie(naam: "Speelveld", omschrijving: "Speelveld voor het lokaal", plaatsen: 2)
        let bib = Locatie(naam: "Bib", omschrijving: "Speelveld achter de bib", plaatsen: 1)
        let kollebloem = Locatie(naam: "Kollebloem", omschrijving: "Speelveld/bos de Kollebloem", plaatsen: 3)
        
        try! realm.write {
            let allLocations = realm.objects(Locatie.self)
            realm.delete(allLocations)
            realm.add(beneden)
            realm.add(keuken)
            realm.add(boven)
            realm.add(mezanine)
            realm.add(klaver)
            realm.add(speelveld)
            realm.add(bib)
            realm.add(kollebloem)
        }
        return kollebloem
    }
    
    @discardableResult
    static func checkLocations(in realm:Realm) -> Locatie{
        return realm.object(ofType: Locatie.self, forPrimaryKey: "Kollebloem") ?? createLocations(in:realm)
    }
}


