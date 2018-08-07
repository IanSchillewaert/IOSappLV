//
//  SessionViewController.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 06/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {    
    
    @IBOutlet weak var tableView: UITableView!
    var vergadering: Vergadering?
    var activities: [Activiteit] = []
    
    
    override func viewDidLoad() {
        self.title = vergadering?.datum
        activities = Array(vergadering!.activiteiten)
        super.viewDidLoad()
    }
}
extension SessionViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activity = activities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:  "ActivityCell") as! ActivityTableViewCell
        
        cell.setActivity(activity: activity)
        cell.accessoryType = .detailButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked activity")
    }
}
