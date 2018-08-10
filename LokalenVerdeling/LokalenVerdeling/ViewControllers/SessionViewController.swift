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
    @IBOutlet weak var lblAdd: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
    var vergadering: Vergadering?
    var activities: [Activiteit] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = vergadering?.datum
        activities = Array(vergadering!.activiteiten)
        activities = sort(activities: activities)
        if vergadering!.activiteiten.count == 6{
            btnAdd.isEnabled = false
            btnAdd.isHidden = true
            lblAdd.text = "Alle takken ingevuld!"
        }
        if vergadering!.activiteiten.count != 6{
            btnAdd.isEnabled = true
            btnAdd.isHidden = false
            lblAdd.text = "Voeg een nieuwe activiteit toe"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "createActivity"
        {
            let activityViewController = (segue.destination ) as! ActivityViewController
            activityViewController.vergadering = vergadering
            activityViewController.activity = nil
        }
        if segue.identifier ==  "showActivity"
        {
            let activityViewController = (segue.destination ) as! ActivityViewController
            let selection = tableView.indexPathForSelectedRow!
            activityViewController.vergadering = vergadering
            activityViewController.activity = activities[selection.row]
            tableView.deselectRow(at: selection, animated: true)
        }
    }
    
    func sort(activities: [Activiteit]) -> [Activiteit]{
        var sorted: [Activiteit] = []
        var names : [String] = []
        var index = 0
        activities.forEach { (act) in
            names.append(act.tak)
        }
        if names.contains("Bevers"){
            index = names.index(of: "Bevers")!
            sorted.append(activities[index])
        }
        if names.contains("Welpen"){
            index = names.index(of: "Welpen")!
            sorted.append(activities[index])
        }
        if names.contains("Wolven"){
            index = names.index(of: "Wolven")!
            sorted.append(activities[index])
        }
        if names.contains("JVG"){
            index = names.index(of: "JVG")!
            sorted.append(activities[index])
        }
        if names.contains("VG"){
            index = names.index(of: "VG")!
            sorted.append(activities[index])
        }
        if names.contains("Seniors"){
            index = names.index(of: "Seniors")!
            sorted.append(activities[index])
        }
        return sorted
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
