//
//  LocationViewController.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 06/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var Descriptiontxt: UITextView!
    @IBOutlet weak var Placestxt: UILabel!
    
    var location: Locatie?

    override func viewDidLoad() {
        self.title = location?.naam
        Descriptiontxt.text = location?.omschrijving
        Placestxt.text = String(location!.plaatsen)
        super.viewDidLoad()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "showFilteredSessions"
        {
            let sessionsViewController = (segue.destination as! UINavigationController).topViewController as! SessionsViewController
            sessionsViewController.location = location
        }
    }
}
