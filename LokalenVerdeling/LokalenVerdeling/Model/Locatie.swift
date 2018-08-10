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
    @objc dynamic var lat = 0.0
    @objc dynamic var long = 0.0
    
    //init
    convenience init(naam:String, omschrijving:String, plaatsen:Int, lat: Double, long:Double)
    {
        self.init()
        self.naam = naam
        self.omschrijving = omschrijving
        self.plaatsen = plaatsen
        self.lat = lat
        self.long = long
    }
    
    //Meta
    override static func primaryKey() -> String? {
        return "naam"
    }
    
    //locaties aanmaken
     private static func createLocations(in realm:Realm) -> Locatie{
        let beneden = Locatie(naam: "Beneden", omschrijving: "Grote zaal beneden in het lokaal", plaatsen: 2, lat: 51.031668, long: 3.806890)
        let keuken = Locatie(naam: "Keuken", omschrijving: "Keuken in het lokaal", plaatsen: 1, lat: 51.031668, long: 3.806890)
        let boven = Locatie(naam: "Boven", omschrijving: "Zaal boven", plaatsen: 1, lat: 51.031668, long: 3.806890)
        let mezanine = Locatie(naam: "Mezanine", omschrijving: "Kleine zaal helemaal boven.", plaatsen: 1, lat: 51.031668, long: 3.806890)
        let klaver = Locatie(naam: "De Klaver", omschrijving: "Zaal kleuterblok basisschool De Klaver", plaatsen: 1, lat: 51.033915, long: 3.800710)
        let speelveld = Locatie(naam: "Speelveld", omschrijving: "Speelveld voor het lokaal", plaatsen: 2, lat: 51.031584, long: 3.806213)
        let bib = Locatie(naam: "Bib", omschrijving: "Speelveld achter de bib", plaatsen: 1, lat: 51.031901, long: 3.804979)
        let kollebloem = Locatie(naam: "Kollebloem", omschrijving: "Speelveld/bos de Kollebloem", plaatsen: 3, lat: 51.030209, long: 3.809745)
        
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
        print("created Locations")
        return kollebloem
    }
    
    @discardableResult
    static func checkLocations(in realm:Realm) -> Locatie{
        return realm.object(ofType: Locatie.self, forPrimaryKey: "Kollebloem") ?? createLocations(in:realm)
    }
}


