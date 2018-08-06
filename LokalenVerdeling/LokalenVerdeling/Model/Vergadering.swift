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
    
    
    //init
    convenience init(datum:String)
    {
        self.init()
        self.datum = datum
    }
    
    //Meta
    override static func primaryKey() -> String? {
        return "datum"
    }
    
    //vergaderingen aanmaken
    private static func createSessions(in realm:Realm) -> Vergadering{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let dag1 = formatter.date(from: "2018/09/01")
        let dag1s = "2018/09/01"
        let dag2 = Calendar.current.date(byAdding: .day, value: 7, to: (dag1)!)
        let dag2s = formatter.string(from: dag2!)
        
        let vergadering1 = Vergadering(datum: dag1s)
        let vergadering2 = Vergadering(datum: dag2s)
        
        try! realm.write {
            let allSessions = realm.objects(Vergadering.self)
            realm.delete(allSessions)
            realm.add(vergadering1)
            realm.add(vergadering2)
        }
        return vergadering2
    }
    
    @discardableResult
    static func checkSessions(in realm:Realm) -> Vergadering{
        return realm.object(ofType: Vergadering.self, forPrimaryKey: "2018/09/08") ?? createSessions(in:realm)
    }
}
