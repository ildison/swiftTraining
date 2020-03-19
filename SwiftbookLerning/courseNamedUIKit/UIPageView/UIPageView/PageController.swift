//
//  PageController.swift
//  UIPageView
//
//  Created by Chugtai Ormund on 16/03/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class PageController: UIPageViewController {

    let presentScreenContent = ["first page",
                                "second page",
                                "third page",
                                "fourth page",
                                ""]
    let emojiArray = ["🤤", "😬", "👌🏾", "👈🏻", ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self

        if let contentViewCotroller = showViewControllerAtIndex(0) {
            setViewControllers([contentViewCotroller], direction: .forward, animated: true, completion: nil)
        }
    }

    func showViewControllerAtIndex(_ index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil }
        guard index < min(presentScreenContent.count, emojiArray.count) else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "peresentationWasViewed")
            dismiss(animated: true, completion: nil)
            return nil
        }
        guard let contentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController else { return nil }

        contentViewController.presentText = presentScreenContent[index]
        contentViewController.emoji = emojiArray[index]
        contentViewController.currentPage = index
        contentViewController.numberOfPage = min(presentScreenContent.count, emojiArray.count)
        return contentViewController
    }
}


extension PageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber -= 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).currentPage
        pageNumber += 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    
}
