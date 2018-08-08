//
//  ActivityViewController.swift
//  LokalenVerdeling
//
//  Created by Ian Schillewaert on 08/08/2018.
//  Copyright © 2018 Ian Schillewaert. All rights reserved.
//

import UIKit
import RealmSwift

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var txtGroup: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    var vergadering: Vergadering?
    var activity: Activiteit?
    var selectedGroup: String?
    var selectedLocation: Locatie?
    var update = false
    let picker1 = UIPickerView()
    let picker2 = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDescription.layer.borderColor = UIColor.black.cgColor
        txtDescription.layer.borderWidth = 1.0
        if activity != nil{
            txtGroup.text = activity!.tak
            txtGroup.isEnabled = false
            txtLocation.text = activity!.locatie?.naam
            txtDescription.text = activity!.omschrijving
        }
        createPickers()
        createToolbar()
    }
    
    func createPickers(){
        picker1.delegate = self
        picker2.delegate = self
        
        txtGroup.inputView = picker1
        txtLocation.inputView = picker2
        
    }
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(ActivityViewController.dismissKeyboard))
        toolbar.setItems([doneBtn], animated: false)
        toolbar.isUserInteractionEnabled = true
        txtGroup.inputAccessoryView = toolbar
        txtLocation.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func createAndSaveActivity(activity:Activiteit){
        let realm = try! Realm()
        try! realm.write {
//          activity maken en toevoegen
            realm.add(activity)
            vergadering!.activiteiten.append(activity)
//          enkel bij create, niet bij update
//          tak weghalen uit lijst met beschickbare takken en toevoegen aan gebruikte
            if update == false{
                let indexgroup = vergadering!.availableGroups.index(of: selectedGroup!)
                vergadering!.availableGroups.remove(at: indexgroup!)
                vergadering!.usedGroups.append(selectedGroup!)
            }
//          Locatie toevoegen aan gebruikte locaties en kijken of limiet is bereikt, dan verwijderen
            vergadering!.usedLocations.append(selectedLocation!)
            let used = vergadering!.usedLocations.filter{$0 == self.selectedLocation!}.count
            if(selectedLocation!.plaatsen <= used){
                let indexlocation = vergadering!.availableLocations.index(of: selectedLocation!)
                vergadering!.availableLocations.remove(at: indexlocation!)
            }
        }
    }
    
    @IBAction func save(sender: UIButton!) {
//      check of het een create is ipv edit
        if activity == nil{
            if(selectedLocation != nil && selectedGroup != nil && txtDescription.text != ""){
                activity = Activiteit(datum: vergadering!.datum, tak: selectedGroup!, omschrijving: txtDescription.text, locatie: selectedLocation!)
                createAndSaveActivity(activity: activity!)
                /*let realm = try! Realm()
                try! realm.write {
//                  activity maken en toevoegen
                    activity = Activiteit(datum: vergadering!.datum, tak: selectedGroup!, omschrijving: txtDescription.text, locatie: selectedLocation!)
                    realm.add(activity!)
                    vergadering!.activiteiten.append(activity!)
//                  tak weghalen uit lijst met beschickbare takken en toevoegen aan gebruikte
                    let indexgroup = vergadering!.availableGroups.index(of: selectedGroup!)
                    vergadering!.availableGroups.remove(at: indexgroup!)
                    vergadering!.usedGroups.append(selectedGroup!)
//                  Locatie toevoegen aan gebruikte locaties en kijken of limiet is bereikt, dan verwijderen
                    vergadering!.usedLocations.append(selectedLocation!)
                    let used = vergadering!.usedLocations.filter{$0 == self.selectedLocation!}.count
                    if(selectedLocation!.plaatsen <= used){
                        let indexlocation = vergadering!.availableLocations.index(of: selectedLocation!)
                        vergadering!.availableLocations.remove(at: indexlocation!)
                    }
                }*/
                _ = navigationController?.popToRootViewController(animated: true)
                //TOAST
            }
        }
        else if activity != nil{
            update = true
            print("edit location")
            if(selectedLocation == nil){
                selectedLocation = activity!.locatie
            }
            if(txtDescription.text != ""){
                let temp = Activiteit(datum: vergadering!.datum, tak: activity!.tak, omschrijving: txtDescription.text, locatie: selectedLocation!)
                let realm = try! Realm()
                try! realm.write {
//                  verwijder de activiteit van de vergadering
                    let index = vergadering!.activiteiten.index(of: activity!)
                    vergadering!.activiteiten.remove(at: index!)
//                  verwijder de groep uit de lijst van gebruikte groepen
                    let indexgroup = vergadering!.usedLocations.index(of: activity!.locatie!)
                    vergadering!.usedLocations.remove(at: indexgroup!)
//                  toevoegen aan beschickbare locaties
                    vergadering!.availableLocations.append(activity!.locatie!)
                    realm.delete(activity!)
                    activity = temp
                }
                createAndSaveActivity(activity: activity!)
            }
            _ = navigationController?.popToRootViewController(animated: true)
            //TOAST
        }
        update = false
    }
}

extension ActivityViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowcount = vergadering!.availableGroups.count
        if pickerView == picker2{
            rowcount = vergadering!.availableLocations.count
        }
        return rowcount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1{
            return vergadering!.availableGroups[row]
        }
        else if pickerView == picker2{
            return vergadering!.availableLocations[row].naam
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker1{
            selectedGroup = vergadering!.availableGroups[row]
            txtGroup.text = selectedGroup
        }
        else if pickerView == picker2{
            selectedLocation = vergadering!.availableLocations[row]
            txtLocation.text = selectedLocation?.naam
        }
    }
    
}
