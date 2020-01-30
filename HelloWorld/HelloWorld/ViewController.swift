//
//  ViewController.swift
//  HelloWorld
//
//  Created by Chugtai Ormund on 30/01/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func pushMe(_ sender: Any) {
        label.text = "Hello world!"
    }
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

