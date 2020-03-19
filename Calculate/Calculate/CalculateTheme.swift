//
//  CalculateTheme.swift
//  Calculate
//
//  Created by Ildar Usmanov on 11.03.2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

enum Theme: String {
    case light = "light"
    case dark = "dark"
    
    var backgroundColor: UIColor {
        switch self {
            case .light:    return #colorLiteral(red: 0.8205085397, green: 0.9614215493, blue: 0.9415095448, alpha: 1)
            case .dark:     return #colorLiteral(red: 0.153598845, green: 0.1445012391, blue: 0.3744809031, alpha: 1)
        }
    }
    var numbersResultElementColor: UIColor {
        switch self {
            case .light:    return #colorLiteral(red: 0.2316158712, green: 0.2517880797, blue: 0.2426116765, alpha: 1)
            case .dark:     return #colorLiteral(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
        }
    }
    var numberButtonsColor: UIColor {
        switch self {
            case .light:    return #colorLiteral(red: 0.7633176446, green: 0.9146129489, blue: 0.8945806623, alpha: 1)
            case .dark:     return #colorLiteral(red: 0.2615867257, green: 0.2528371513, blue: 0.6259427667, alpha: 1)
        }
    }
    var operButtonsColor: UIColor {
        switch self {
            case .light:    return #colorLiteral(red: 0.3737826943, green: 0.8305796981, blue: 0.7770504951, alpha: 1)
            case .dark:     return #colorLiteral(red: 0.3378633559, green: 0.3274139166, blue: 0.8003453612, alpha: 1)
        }
    }
    var operTitleColor: UIColor {
        switch self {
            case .light:    return #colorLiteral(red: 0.1508665085, green: 0.6136432886, blue: 0.55210042, alpha: 1)
            case .dark:     return backgroundColor
        }
    }
    var resultButtonColor: UIColor {
        switch self {
            case .light:    return #colorLiteral(red: 0.1508665085, green: 0.6136432886, blue: 0.55210042, alpha: 1)
            case .dark:     return #colorLiteral(red: 0.605288744, green: 0.5944219232, blue: 0.9417585731, alpha: 1)
        }
    }
    var equalСolor: UIColor {
        switch self {
            case .light:    return #colorLiteral(red: 0.2316158712, green: 0.2517880797, blue: 0.2426116765, alpha: 1)
            case .dark:     return backgroundColor
        }
    }
    var imageTheme: UIImage? {
        switch self {
            case .light:    return UIImage(named: "SUN")
            case .dark:     return UIImage(named: "MOON")
        }
    }
    @available(iOS 13.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
            case .light:    return UIUserInterfaceStyle.light
            case .dark:     return UIUserInterfaceStyle.dark
        }
    }
}

class CalculateTheme {
    
    var vc: ViewController?
    
    func changeTheme(current style: String) {
        let currentTheme = Theme(rawValue: style)
        switch currentTheme {
            case .dark:
                setTheme(theme: .light)
            case .light:
                setTheme(theme: .dark)
            default:
                return
        }
    }
    
    func setTheme(style: String) {
        guard let theme = Theme(rawValue: style) else { return }
        print(theme)
        setTheme(theme: theme)
    }
    
    private func setTheme(theme: Theme) {
        vc?.background.backgroundColor = theme.backgroundColor
        vc?.resultLabel.textColor = theme.numbersResultElementColor
        vc?.elementsLabel.textColor = theme.numbersResultElementColor
        vc?.resultButton.backgroundColor = theme.resultButtonColor
        vc?.resultButton.setTitleColor(theme.equalСolor, for: .normal)
        vc?.numberButtons.forEach({ (button) in
            button.backgroundColor = theme.numberButtonsColor
            button.setTitleColor(theme.numbersResultElementColor, for: .normal)
        })
        vc?.operButtons.forEach({ (button) in
            button.backgroundColor = theme.operButtonsColor
            button.setTitleColor(theme.operTitleColor, for: .normal)
        })
        vc?.imageTheme.image = theme.imageTheme
        if #available(iOS 13.0, *) {
            vc?.overrideUserInterfaceStyle = theme.userInterfaceStyle
        }
    }
}
