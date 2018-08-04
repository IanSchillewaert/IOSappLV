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
    /*//init
    convenience init(tak:Tak, omschrijving:String, datum:Date, locatie:Locatie)
    {
        self.init()
        self.tak = tak
        self.omschrijving = omschrijving
        self.datum = datum
        self.locatie = locatie
    }
    
    //Properties
    enum Tak: String {
        case geen = "Geen"
        case bevers = "Bevers"
        case welpen = "Welpen"
        case wolven = "Wolven"
        case jvg = "Jongverkenners"
        case vg = "Verkenners"
        case seniors = "Seniors"
        
        static let values: [Tak] = [.geen, .bevers, .welpen, .wolven, .jvg, .vg, .seniors]
    }
    @objc dynamic var id = UUID().uuidString
    var locatie: Locatie = Locatie(naam:"naam", omschrijving:"omschrijving", plaatsen:0)
    @objc dynamic var omschrijving = ""
    @objc dynamic var datum: Date = Date()
    
    @objc dynamic var takRaw = ""
    var tak: Tak {
        get {
            return Tak(rawValue: takRaw) ?? .geen
        } set {
            takRaw = newValue.rawValue
        }
    }
    
    //Meta
    override static func primaryKey() -> String? {
        return "id"
    }*/
}
