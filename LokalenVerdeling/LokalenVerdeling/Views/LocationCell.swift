//
//  LocationCell.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 04/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import Foundation
import UIKit

class LocationCell : UITableViewCell{
    
    @IBOutlet weak var locatienaam: UILabel!

    var locatie: Locatie!{
        didSet{
            locatienaam.text = locatie?.naam
        }
    }
}
