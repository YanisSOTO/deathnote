//
//  getDocumentsDirectory.swift
//  DeathNote
//
//  Created by Soto Yanis on 02/07/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit

func getDocumentsDirectory() -> NSString {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let documentsDirectory = paths.first
    return documentsDirectory!
}