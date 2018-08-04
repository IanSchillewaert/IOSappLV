//
//  LocationsViewController.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 04/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit
import RealmSwift

class LocationsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var Locations: [Locatie] = []
    
    override func viewDidLoad() {
        self.title = "Locaties"
        super.viewDidLoad()

        let realm = try! Realm()
        Locatie.checkLocations(in: realm)
        Locations = Array(realm.objects(Locatie.self))
    }
}

extension LocationsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = Locations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:  "LocationCell") as! LocationTableViewCell
        
        cell.setLocation(location: location)
        
        return cell
    }
}
