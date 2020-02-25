//
//  ViewController.swift
//  Calculate
//
//  Created by Chugtai Ormund on 13/02/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var stack = [String]()
    var lastOper: String = ""
    var ac = true
    
    @IBOutlet weak var elementsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var clear: UIButton!
    
    func joinInLabel(_ appended: String, _ label: UILabel) {
        if label.text == "0" && appended.count != 3 {
            label.text = appended
        }
        else if label == elementsLabel || label.text != "-0" {
            label.text?.append(appended)
        }
        else if label == resultLabel && label.text == "-0" {
            label.text = "-" + appended
        }
    }

    @IBAction func numbers(_ sender: UIButton) {
        joinInLabel(String(sender.tag), resultLabel)
        if sender.tag != 0 && ac == true {
            ac = false
            clear.setTitle("C", for: .normal)
        }
        if !lastOper.isEmpty {
            stack.append(lastOper)
            lastOper = ""
        }
    }

    @IBAction func dot() {
        if resultLabel.text?.contains(".") == false {
            resultLabel.text?.append(".")
        }
        if ac == true {
            ac = false
            clear.setTitle("C", for: .normal)
        }
    }
    
    @IBAction func opers(_ sender: UIButton) {
        let oper = ["+", "-", "x", "÷"]
        guard var number = resultLabel.text else { return }

        if number.last == "." {
            number.removeLast()
            resultLabel.text?.removeLast()
        }
//        if number != "0" && number != "-0" {
        if lastOper.isEmpty {
            joinInLabel(number, elementsLabel)
//            if !lastOper.isEmpty {
//                stack.append(oper[sender.tag])
//            }
            stack.append(number)
            resultLabel.text = "0"
        }
        else {
            elementsLabel.text?.removeLast(3)
//            stack.removeLast()
        }
        if !stack.isEmpty {
            joinInLabel(" \(oper[sender.tag]) ", elementsLabel)
            lastOper = oper[sender.tag]
//            stack.append(oper[sender.tag])
        }
        print(stack)
    }

    @IBAction func plusMinus() {
        guard let num = resultLabel.text else { return }
        if num.first == "-" {
            resultLabel.text?.removeFirst()
        }
        else {
            resultLabel.text = "-" + num
        }
    }
    
    @IBAction func percent() {
    }
    @IBAction func result() {
    }
    
    
    @IBAction func clearResult(_ sender: UIButton) {
        if ac == false {
            resultLabel.text = "0"
            ac = true
            clear.setTitle("AC", for: .normal)
        }
        else {
            elementsLabel.text = "0"
            resultLabel.text = "0"
            stack.removeAll()
            lastOper = ""
        }
    }
    
}

