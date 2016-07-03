//
//  DeathNoteList.swift
//  DeathNote
//
//  Created by Soto Yanis on 01/07/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//



import Foundation
import RealmSwift

class DeathNoteContactList: Object {
    
    dynamic var name = ""
    let tasks = List<Contact>()
    
    dynamic var createdAt = NSDate()
}