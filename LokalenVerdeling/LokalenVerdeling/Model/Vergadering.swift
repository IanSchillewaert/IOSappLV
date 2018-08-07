//
//  Vergadering.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 03/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import Foundation
import RealmSwift

class Vergadering: Object {
    //Properties
    @objc dynamic var datum = ""
    var activiteiten = List<Activiteit>()
    var usedLocations = List<Locatie>()
    var usedGroups = List<String>()
    var availableLocations = List<Locatie>()
    var availableGroups = List<String>()
    
    
    //init
    convenience init(datum:String)
    {
        self.init()
        self.datum = datum
        let groups = ["Bevers","Welpen","Wolven","JVG","VG","Seniors"]
        self.availableGroups.append(objectsIn: groups)
        let realm = try! Realm()
        let locations = realm.objects(Locatie.self)
        locations.forEach { (loc) in
            availableLocations.append(loc)
        }
    }
    
    //Meta
    override static func primaryKey() -> String? {
        return "datum"
    }
    
    //vergaderingen aanmaken
    private static func createSessions(in realm:Realm) -> Vergadering{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        //vastzetten eerste vergadering.
        var dateLoop = formatter.date(from: "2018/09/01")
        let start = "2018/09/01"
        let vergadering1 = Vergadering(datum: start)
        
        //tijdelijk
        let act1 = Activiteit(datum: start, tak: "Bevers", omschrijving: "eerste vergadering bevers", locatie: Locatie(naam: "test", omschrijving: "Grote zaal beneden", plaatsen: 2))
        let act2 = Activiteit(datum: start, tak: "Welpen", omschrijving: "eerste vergadering welpen", locatie: Locatie(naam: "test2", omschrijving: "Grote zaal beneden", plaatsen: 2))
        let act3 = Activiteit(datum: start, tak: "Wolven", omschrijving: "eerste vergadering wolven", locatie: Locatie(naam: "test3", omschrijving: "Zaal boven", plaatsen: 1))
        let act4 = Activiteit(datum: start, tak: "JVG", omschrijving: "eerste vergadering JVG's", locatie: Locatie(naam: "test4", omschrijving: "Grote zaal beneden", plaatsen: 2))
        let act5 = Activiteit(datum: start, tak: "VG", omschrijving: "eerste vergadering VG's", locatie: Locatie(naam: "test5", omschrijving: "Grote zaal beneden", plaatsen: 2))
        let act6 = Activiteit(datum: start, tak: "Seniors", omschrijving: "eerste vergadering seniors", locatie: Locatie(naam: "test6", omschrijving: "Zaal boven", plaatsen: 1))
        vergadering1.activiteiten.append(act1)
        vergadering1.activiteiten.append(act2)
        vergadering1.activiteiten.append(act3)
        vergadering1.activiteiten.append(act4)
        vergadering1.activiteiten.append(act5)
        vergadering1.activiteiten.append(act6)

        
        try! realm.write {
            let allSessions = realm.objects(Vergadering.self)
            realm.delete(allSessions)
            realm.add(vergadering1)
        }
        
        //loop voor aanmaken alle vergaderingen (tot 25/05/2019)
        for _ in 1...38 {
            let nextDate = Calendar.current.date(byAdding: .day, value: 7, to: (dateLoop)!)
            let datumString = formatter.string(from: nextDate!)
            let nextSession = Vergadering(datum: datumString)
            try! realm.write {
                realm.add(nextSession)
            }
            dateLoop = nextDate
        }

        
        print("created Sessions")
        return vergadering1
    }
    
    @discardableResult
    static func checkSessions(in realm:Realm) -> Vergadering{
        return realm.object(ofType: Vergadering.self, forPrimaryKey: "2019/05/25") ?? createSessions(in:realm)
    }
}
