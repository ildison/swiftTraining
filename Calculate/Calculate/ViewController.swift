//
//  ViewController.swift
//  Calculate
//
//  Created by Chugtai Ormund on 13/02/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class Calculate {
    var lastOper: String = ""
    var stack = [String]()

    private func isNumber(_ checked: String) -> Bool {
        guard let firstCharacter = checked.first else {
            return false
        }
        if firstCharacter >= "0" && firstCharacter <= "9" {
            return true
        }
        return false
    }
    
    private func  executeOper(oper: String, num1: Double, num2: Double) -> String {
        switch oper {
        case "+":
            return "\(num1 + num2)"
        case "-":
            return "\(num1 - num2)"
        case "x":
            return String(num1 * num2)
        case "÷":
            return String(num1 / num2)
        default:
            return ""
        }
    }

    func addInStack(_ elem: String) {
        if isNumber(elem) && !stack.isEmpty && (stack.last == "x" || stack.last == "÷") {
            let oper = stack.removeLast()
            guard let num1 = Double(stack.removeLast()) else { return }
            guard let num2 = Double(elem) else { return }
            stack.append(executeOper(oper: oper, num1: num1, num2: num2))
        }
        else {
            stack.append(elem)
        }
    }
    
    func result() -> String {
        var countElems = stack.count

        print(stack)
        while countElems > 1 {
            guard let num1 = Double(stack.removeFirst()) else { return ""}
            let oper = stack.removeFirst()
            guard let num2 = Double(stack.removeFirst()) else { return ""}
            stack.insert(executeOper(oper: oper, num1: num1, num2: num2), at: 0)
            countElems -= 2
        }
        return stack.removeFirst()
    }
}

class ViewController: UIViewController {

    var calc = Calculate()
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
        if !calc.lastOper.isEmpty {
            calc.addInStack(calc.lastOper)
            calc.lastOper = ""
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
        if calc.lastOper.isEmpty {
            joinInLabel(number, elementsLabel)
            calc.addInStack(number)
            resultLabel.text = "0"
        }
        else {
            elementsLabel.text?.removeLast(3)
        }
        if !calc.stack.isEmpty {
            joinInLabel(" \(oper[sender.tag]) ", elementsLabel)
            calc.lastOper = oper[sender.tag]
        }
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
        if !calc.stack.isEmpty {
            guard var number = resultLabel.text else { return }
            if number.last == "." {
                number.removeLast()
                resultLabel.text?.removeLast()
            }
            if calc.lastOper.isEmpty {
                joinInLabel(number, elementsLabel)
                calc.addInStack(number)
                resultLabel.text = "0"
            }
            else {
                elementsLabel.text?.removeLast(3)
            }
            joinInLabel(" = ", elementsLabel)
            resultLabel.text = calc.result()
            calc.lastOper = ""
            ac = true
            clear.setTitle("AC", for: .normal)
        }
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
            calc.stack.removeAll()
            calc.lastOper = ""
        }
    }
}

