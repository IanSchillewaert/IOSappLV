//
//  SessionTableViewCell.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 06/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel! 
    @IBOutlet weak var activities: UILabel!
    
    func setSession(session: Vergadering){
        Title.text = session.datum
        activities.text = String(session.activiteiten.count) + "/6 takken ingevuld"
    }
}
