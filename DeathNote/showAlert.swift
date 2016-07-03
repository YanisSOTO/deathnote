//
//  showAlert.swift
//  DeathNote
//
//  Created by Soto Yanis on 01/07/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit

func showAlertWithTitle( title:String, message:String ) -> UIAlertController{
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
    alertVC.addAction(okAction)
    return (alertVC)
}

