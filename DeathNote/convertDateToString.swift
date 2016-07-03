//
//  convertDateToString.swift
//  DeathNote
//
//  Created by Soto Yanis on 02/07/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit

func convertDateToString(date: NSDate) -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
    let dateString = dateFormatter.stringFromDate(date)
    return(dateString)
}
