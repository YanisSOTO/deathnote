//
//  ViewController.swift
//  DeathNote
//
//  Created by Soto Yanis on 01/07/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit
import RealmSwift

class ListNoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Will containt the objects in the dataBased updated
    var contactList : Results<Contact>!

    // IBOutlet
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Auto size for cell
        tableView.estimatedRowHeight =  20
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .None
        
        //Hide the back button
        self.navigationItem.hidesBackButton = true;
    }
    
    override func viewWillAppear(animated: Bool) {
        readTasksAndUpdateUI()
    }
    
    //MARK: - UITableViewDataSource -
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contactList == nil {
           return 0
        } else {
           return contactList.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! CellListNoteTableViewController
        
        cell.lastNameLabel.text = "\(contactList[indexPath.row].lastName) - \(contactList[indexPath.row].firstName)"
        cell.descriptionLabel.text = contactList[indexPath.row].descriptions
        cell.dateLabel.text = convertDateToString(contactList[indexPath.row].timeDeath)
        if contactList[indexPath.row].imageProfil.length != 0 {
            let image = UIImage(data:contactList[indexPath.row].imageProfil,scale:1.0)
            cell.profilImage.image = image!.circleMask
        } else {
            print("LOL")
        }
        return (cell)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            
            let objectToBeDeleted = self.contactList[indexPath.row]
            //delete in the DB
            do { try uiRealm.write() {
                uiRealm.delete(objectToBeDeleted)
                self.readTasksAndUpdateUI()
                }
            } catch {
                print("Can't delete the list")
            }
        }
        return [deleteAction]
    }
    
    //Mark: - Reaload data -
    func readTasksAndUpdateUI(){
        contactList = uiRealm.objects(Contact)
        self.tableView.reloadData()
    }
}
