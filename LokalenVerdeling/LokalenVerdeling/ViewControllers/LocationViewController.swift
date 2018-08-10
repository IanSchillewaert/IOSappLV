//
//  LocationViewController.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 06/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var Descriptiontxt: UITextView!
    @IBOutlet weak var Placestxt: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var location: Locatie?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = location?.naam
        Descriptiontxt.text = location?.omschrijving
        Placestxt.text = String(location!.plaatsen)
        //maak map en drop een pin op de locatie
        let loc = CLLocationCoordinate2DMake(location!.lat, location!.long)
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegion(center: loc, span: span)
        map.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = loc
        pin.title = location!.naam
        map.addAnnotation(pin)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "showFilteredSessions"
        {
            let sessionsViewController = (segue.destination as! UINavigationController).topViewController as! SessionsViewController
            sessionsViewController.location = location
        }
    }
}
