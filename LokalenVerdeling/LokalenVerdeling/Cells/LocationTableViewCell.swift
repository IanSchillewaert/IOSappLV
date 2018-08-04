 //
//  LocationTableViewCell.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 04/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var LocationName: UILabel!
    @IBOutlet weak var LocationSpaces: UILabel!
    
    func setLocation(location: Locatie){
        LocationName.text = location.naam
        LocationSpaces.text = String(location.plaatsen)
    }
 }
