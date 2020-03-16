//
//  ViewController.swift
//  UIPageView
//
//  Created by Chugtai Ormund on 16/03/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startPresentation()
    }
    
    func startPresentation() {
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageController {
            present(pageViewController, animated: true, completion: nil)
        }
    }
}

