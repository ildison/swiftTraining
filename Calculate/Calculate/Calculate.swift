//
//  Calculate.swift
//  Calculate
//
//  Created by Ildar Usmanov on 06.04.2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import Foundation

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
        return (firstCharacter >= "0" && firstCharacter <= "9") || firstCharacter == "-"
    }
    
    private func  executeOper(oper: String, num1: Float, num2: Float) throws -> String {
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
    
    func isPercent(_ num: String) -> Bool {
        return num.last == "%"
    }
    
    func searchPercent(value: Float, from number: String) -> Float {
        guard let num = Float(number.filter({$0 != "%"})) else { return 0 }
        return num / 100 * value
    }
    
    func getNumber(_ number:String) -> Float {
        if isPercent(number) {
            return searchPercent(value: 1, from: number)
        }
        else {
            guard let num = Float(number) else { return 0 }
            return num
        }
    }

    func addInStack(_ elem: String) throws {
        if isNumber(elem) && !stack.isEmpty && (stack.last == "x" || stack.last == "÷") {
            let oper = stack.removeLast()
            let num1 = getNumber(stack.removeLast())
            let num2 = getNumber(elem)
            guard let appended = try? executeOper(oper: oper, num1: num1, num2: num2) else {
                throw error.Error}
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
            lenZero += 1
            if elem != "0" { break }
        }
        if lenZero > 1 {
            revNum.removeFirst(lenZero)
        }
        return String(revNum.reversed())
    }
    
    func result() -> String {
        var countElems = stack.count

        while countElems > 1 {
            let num1 = getNumber(stack.removeFirst())
            let oper = stack.removeFirst()
            let num2: Float
            if isPercent(stack.last ?? "0") {
                num2 = searchPercent(value: num1, from: stack.removeFirst())
            }
            else {
                num2 = getNumber(stack.removeFirst())
            }
            stack.insert(try! executeOper(oper: oper, num1: num1, num2: num2), at: 0)
            countElems -= 2
        }
        return roundNumer(String(getNumber(stack.removeFirst())))
    }
}
