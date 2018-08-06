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
        super.viewDidLoad()

        let realm = try! Realm()
        Locatie.checkLocations(in: realm)
        Vergadering.checkSessions(in: realm)
        Locations = Array(realm.objects(Locatie.self))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "showLocation"
        {
            let locationViewController = (segue.destination ) as! LocationViewController
            let selection = tableView.indexPathForSelectedRow!
            locationViewController.location = Locations[selection.row]
            tableView.deselectRow(at: selection, animated: true)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("something silly")
    }
}
