//
//  SessionsViewController.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 06/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit
import RealmSwift

class SessionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var sessions: [Vergadering] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        Vergadering.checkSessions(in: realm)
        sessions = Array(realm.objects(Vergadering.self))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "showSession"
        {
            let sessionViewController = (segue.destination ) as! SessionViewController
            let selection = tableView.indexPathForSelectedRow!
            sessionViewController.vergadering = sessions[selection.row]
            tableView.deselectRow(at: selection, animated: true)
        }
    }
}
extension SessionsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let session = sessions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier:  "SessionCell") as! SessionTableViewCell
        
        cell.setSession(session: session)
        if(session.activiteiten.count == 6){
            let color = UIColor(red: 169/255, green: 247/255, blue: 74/255, alpha: 0.5)
            cell.backgroundColor = color
        }
        if(session.activiteiten.count != 6){
            cell.backgroundColor = UIColor.white
        }
        cell.accessoryType = .detailButton

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked session")
    }
}
