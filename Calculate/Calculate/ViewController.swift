//
//  ViewController.swift
//  Calculate
//
//  Created by Chugtai Ormund on 13/02/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

enum error: Error {
    case Error
}

class Calculate {
    var lastOper: String = ""
    var stack = [String]()

    func isNumber(_ checked: String) -> Bool {
        guard let firstCharacter = checked.first else {
            return false
        }
        return firstCharacter >= "0" && firstCharacter <= "9"
    }
    
    private func  executeOper(oper: String, num1: Double, num2: Double) throws -> String {
        switch oper {
        case "+":
            return "\(num1 + num2)"
        case "-":
            return "\(num1 - num2)"
        case "x":
            return String(num1 * num2)
        case "÷":
            if num2 == 0 { throw error.Error }
            return String(num1 / num2)
        default:
            throw error.Error
        }
    }

    func addInStack(_ elem: String) throws {
        if isNumber(elem) && !stack.isEmpty && (stack.last == "x" || stack.last == "÷") {
            let oper = stack.removeLast()
            guard let num1 = Double(stack.removeLast()) else { return }
            guard let num2 = Double(elem) else { return }
            guard let appended = try? executeOper(oper: oper, num1: num1, num2: num2) else { throw error.Error}
            stack.append(appended)
        }
        else {
            stack.append(elem)
        }
    }
    
    func roundNumer(_ number: String) -> String {
        if !number.contains(".") { return number }
        var revNum = String(number.reversed())
        var lenZero = 0

        for elem in revNum {
            if elem != "0" { break }
            lenZero += 1
        }
        revNum.removeFirst(lenZero + 1)
        return String(revNum.reversed())
    }
    
    func result() -> String {
        var countElems = stack.count

        print(stack)
        while countElems > 1 {
            guard let num1 = Double(stack.removeFirst()) else { return ""}
            let oper = stack.removeFirst()
            guard let num2 = Double(stack.removeFirst()) else { return ""}
            stack.insert(try! executeOper(oper: oper, num1: num1, num2: num2), at: 0)
            countElems -= 2
        }
        return roundNumer(stack.removeFirst())
    }
}

class ViewController: UIViewController {

    var calc = Calculate()
    var ac = true
    var errorStatus = false
    var resultStatus = false
    
    @IBOutlet weak var elementsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var clear: UIButton!
    
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
        if errorStatus == true || resultStatus == true { return }
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
        if errorStatus == true || resultStatus == true { return }
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
        if calc.lastOper.isEmpty {
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
        else {
            elementsLabel.text?.removeLast(3)
        }
    }
    
    @IBAction func opers(_ sender: UIButton) {
        if errorStatus == true { return }
        if resultStatus == true { resultStatus = false }
        let oper = ["+", "-", "x", "÷"]
        checkNumberBeforAppOper()
        if !calc.stack.isEmpty {
            joinInLabel(" \(oper[sender.tag]) ", elementsLabel)
            calc.lastOper = oper[sender.tag]
        }
    }

    @IBAction func plusMinus() {
        if errorStatus == true || resultStatus == true { return }
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
        if errorStatus == true { return }
        if !calc.stack.isEmpty {
            checkNumberBeforAppOper()
            if errorStatus == false {
                joinInLabel(" = ", elementsLabel)
                resultLabel.text = calc.result()
                calc.lastOper = ""
                turnAc(to: true)
                resultStatus = true
            }
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
        }
    }
}

