//
//  ContentViewController.swift
//  UIPageView
//
//  Created by Chugtai Ormund on 16/03/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var presentTextLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var pageControll: UIPageControl!
    
    var presentText = ""
    var emoji = ""
    var currentPage = 0 // текущая страница
    var numberOfPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presentTextLabel.text = presentText
        emojiLabel.text = emoji
        pageControll.numberOfPages = numberOfPage
        pageControll.currentPage = currentPage
    }
}
