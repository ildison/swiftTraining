//
//  SecondViewController.swift
//  PassDataProject
//
//  Created by Ildar Usmanov on 28.02.2020.
//  Copyright © 2020 Ildar Usmanov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var login: String!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func sendPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Hello, \(login ?? "")"
    }
}
