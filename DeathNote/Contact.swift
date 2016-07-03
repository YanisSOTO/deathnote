//
//  Contact.swift
//  DeathNote
//
//  Created by Soto Yanis on 01/07/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    
    dynamic var firstName = ""
    dynamic var lastName = ""
    dynamic var descriptions = ""
    dynamic var timeDeath = NSDate()
    dynamic var imageProfil = NSData()
}
