//
//  ViewController.swift
//  Calculate
//
//  Created by Chugtai Ormund on 13/02/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit
//
//enum oper {
//    case add
//    case sub
//    case mul
//    case div
//}

class ViewController: UIViewController {
    
    var stack = [String]()
    
    @IBOutlet weak var elementsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    func join(_ appended: String, _ label: UILabel) {
        if label.text == "0" {
            label.text = appended
        }
        else if label.text != "-0" {
            label.text?.append(appended)
        }
        else {
            label.text = "-" + appended
        }
    }

    @IBAction func numbers(_ sender: UIButton) {
        join(String(sender.tag), resultLabel)
    }

    @IBAction func dot() {
        if resultLabel.text?.contains(".") == false {
            resultLabel.text?.append(".")
        }
    }
    
    @IBAction func opers(_ sender: UIButton) {
        let oper = ["+", "-", "x", "÷"]
        guard let number = resultLabel.text else { return }
        if number != "0" && number != "-0" {
            join(number, elementsLabel)
            stack.append(number)
            resultLabel.text = "0"
        }
        else if elementsLabel.text!.count > 2 {
            elementsLabel.text?.removeLast(3)
            stack.removeLast()
        }
        join(" \(oper[sender.tag]) ", elementsLabel)
        stack.append(oper[sender.tag])
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
        resultLabel.text = "0"
    }
    
}

