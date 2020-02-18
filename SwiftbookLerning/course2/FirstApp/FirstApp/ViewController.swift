//
//  ViewController.swift
//  FirstApp
//
//  Created by Chugtai Ormund on 17/02/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBAction func Button(_ sender: UIButton) {
        let ac = UIAlertController(title: "Hey", message: "Hey man", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        ac.addAction(alertAction)
        present(ac, animated: true, completion: nil)
        sender.layer.cornerRadius = 30
        sender.layer.borderWidth = 3
        sender.layer.borderColor = UIColor.red.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

