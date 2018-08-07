//
//  ActivityTableViewCell.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 07/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var grouplbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    
    func setActivity(activity: Activiteit){
        grouplbl.text = activity.tak
        locationlbl.text = activity.locatie?.naam
        descriptionlbl.text = activity.omschrijving
    }
}
