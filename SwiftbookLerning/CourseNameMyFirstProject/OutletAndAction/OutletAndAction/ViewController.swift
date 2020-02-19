//
//  ViewController.swift
//  OutletAndAction
//
//  Created by Ildar Usmanov on 19.02.2020.
//  Copyright © 2020 Ildar Usmanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    @IBOutlet var labelCollection: [UILabel]!
    
    @IBAction func changeTextInLabel(_ sender: UIButton) {
        label.text = "Hello, world!"
    }

}

