//
//  ViewController.swift
//  Calculate
//
//  Created by Chugtai Ormund on 13/02/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var calc = Calculate()
    var calcTheme = CalculateTheme()
    let defaults = UserDefaults.standard
    var styleTheme = ""
    var ac = true
    var errorStatus = false
    var resultStatus = false
    var percentStatus = false
    
    @IBOutlet var background: UIView!
    @IBOutlet weak var elementsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet var numberButtons: [BorderButton]!
    @IBOutlet var operButtons: [BorderButton]!
    @IBOutlet weak var resultButton: BorderButton!
    @IBOutlet weak var imageTheme: UIImageView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return calcTheme.preferredStatusBarStyle
    }

    override func viewDidLoad() {
        styleTheme = defaults.string(forKey: "style") ?? "dark"
        defaults.set(styleTheme, forKey: "style")
        
        calcTheme.vc = self
        calcTheme.setTheme(style: styleTheme)
        
        swipeObserver()
    }
    
    @IBAction func changeTheme() {
        calcTheme.changeTheme(current: styleTheme)
        setNeedsStatusBarAppearanceUpdate()
        styleTheme = styleTheme == "light" ? "dark" : "light"
        defaults.set(styleTheme, forKey: "style")
    }
    
    func joinInLabel(_ appended: String, _ label: UILabel) {
        if label.text == "0" && calc.isNumber(appended) {
            label.text = appended
        }
        else if label == elementsLabel || label.text != "-0" {
            label.text?.append(appended)
        }
        else if label == resultLabel && label.text == "-0" {
            label.text = "-" + appended
        }
    }
    
    func turnAc(to relay: Bool) {
        ac = relay
        if ac == true {
            clear.setTitle("AC", for: .normal)
        }
        else {
            clear.setTitle("C", for: .normal)
        }
    }

    @IBAction func numbers(_ sender: UIButton) {
        if errorStatus == true || resultStatus == true || percentStatus == true { return }
        joinInLabel(String(sender.tag), resultLabel)
        if sender.tag != 0 && ac == true {
            turnAc(to: false)
        }
        if !calc.lastOper.isEmpty {
            try! calc.addInStack(calc.lastOper)
            calc.lastOper = ""
        }
    }

    @IBAction func dot() {
        if errorStatus == true || resultStatus == true || percentStatus == true { return }
        if resultLabel.text?.contains(".") == false {
            resultLabel.text?.append(".")
        }
        if ac == true {
            turnAc(to: false)
        }
    }
    
    func checkNumberBeforAppOper() {
        guard var number = resultLabel.text else { return }

        if number.last == "." {
            number.removeLast()
            resultLabel.text?.removeLast()
        }
        if number == "-0" { number = "0" }
        if calc.lastOper.isEmpty && percentStatus == false {
            joinInLabel(number, elementsLabel)
            if ((try? calc.addInStack(number)) != nil) {
                resultLabel.text = "0"
            }
            else {
                resultLabel.text = "Error"
                turnAc(to: true)
                errorStatus = true
            }
        }
        else if percentStatus == false {
            elementsLabel.text?.removeLast(3)
        }
    }
    
    @IBAction func opers(_ sender: UIButton) {
        if errorStatus == true { return }
        if resultStatus == true { resultStatus = false }
        let oper = ["+", "-", "x", "÷"]
        if percentStatus == true {
            percentStatus = false
        }
        else {
            checkNumberBeforAppOper()
        }
        if !calc.stack.isEmpty {
            joinInLabel(" \(oper[sender.tag]) ", elementsLabel)
            calc.lastOper = oper[sender.tag]
        }
    }

    @IBAction func plusMinus() {
        if errorStatus == true || resultStatus == true || percentStatus == true { return }
        guard let num = resultLabel.text else { return }
        if num.first == "-" {
            resultLabel.text?.removeFirst()
        }
        else {
            resultLabel.text = "-" + num
        }
    }
    
    @IBAction func percent() {
        if errorStatus == true || resultStatus == true { return }
        guard let number = resultLabel.text else { return }
        if number == "0" || number == "0" { return }
        joinInLabel("%", resultLabel)
        if !calc.lastOper.isEmpty {
            try! calc.addInStack(calc.lastOper)
            calc.lastOper = ""
        }
        checkNumberBeforAppOper()
        percentStatus = true
    }

    @IBAction func result() {
        if errorStatus == true { return }
        if !calc.stack.isEmpty {
            checkNumberBeforAppOper()
            if errorStatus == false {
                joinInLabel(" = ", elementsLabel)
                resultLabel.text = calc.result()
                calc.lastOper = ""
                turnAc(to: true)
                resultStatus = true
                percentStatus = false
            }
        }
    }
    
    func swipeObserver() {
        resultLabel.isUserInteractionEnabled = true
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(removeLastInResultLabel))
        rightSwipe.direction = .right
        self.resultLabel.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(removeLastInResultLabel))
        leftSwipe.direction = .left
        self.resultLabel.addGestureRecognizer(leftSwipe)
    }

    @objc func removeLastInResultLabel() {
        if errorStatus == true || resultStatus == true { return }
        guard let count = resultLabel.text?.count else { return }
        guard let number = resultLabel.text else { return }
        if count > 1 && number != "-0"  {
            resultLabel.text?.removeLast()
        }
        else if count == 1 || number == "-0" {
            resultLabel.text = "0"
        }
        if count == 2 && number.first == "-" && number != "-0" {
            resultLabel.text?.append("0")
        }
    }
    
    @IBAction func clearResult(_ sender: UIButton) {
        if ac == false {
            resultLabel.text = "0"
            turnAc(to: true)
        }
        else {
            elementsLabel.text = "0"
            resultLabel.text = "0"
            calc.stack.removeAll()
            calc.lastOper = ""
            errorStatus = false
            resultStatus = false
            percentStatus = false
        }
    }
}
