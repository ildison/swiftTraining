//
//  ViewController.swift
//  UIKitLearn
//
//  Created by Chugtai Ormund on 05/03/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var outletActivityIndecator: UIActivityIndicatorView!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        textView.text = ""
        textView.delegate = self
        
        textView.isHidden = true
//        textView.alpha = 0
        
        textView.font = UIFont(name: "Futura-Medium", size: 17)
        textView.backgroundColor = self.view.backgroundColor
        textView.layer.cornerRadius = 10
        
        stepper.value = 17
        stepper.minimumValue = 10
        stepper.maximumValue = 25
        
        outletActivityIndecator.hidesWhenStopped = true
        outletActivityIndecator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        outletActivityIndecator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents() // старт запрета на какие-либо действия во время загрузки
        
        progressView.setProgress(0, animated: true)

        // отслеживаем появление клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)),
                                               name: Notification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        // отслеживаем скрытие клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView(notification:)),
                                               name: Notification.Name.UIKeyboardWillHide,
                                               object: nil)
        
//        UIView.animate(withDuration: 0, delay: 5, options: .allowAnimatedContent, animations: {
//            self.textView.alpha = 1
//        }) { (finishined) in
//            self.outletActivityIndecator.stopAnimating()
//            self.textView.isHidden = false
//            UIApplication.shared.endIgnoringInteractionEvents()
//        }
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (_) in
            if self.progressView.progress < 1 {
                self.progressView.progress += 0.025
            } else {
                self.outletActivityIndecator.stopAnimating()
                self.textView.isHidden = false
                UIApplication.shared.endIgnoringInteractionEvents()
                self.progressView.isHidden = true
            }
        }
        
    }

    @objc func  updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                 bottom: keyboardFrame.height - bottomConstraint.constant,
                                                  right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        textView.scrollRangeToVisible(textView.selectedRange)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // скрытие клавиатуры по тапу за пределами TextView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true) // скрывает клавиатуру для любого объекта
//        textView.resignFirstResponder() // скрывает клав-ру для конкретного объекта
    }

    @IBAction func sizeFont(_ sender: UIStepper) {
        let font = textView.font?.fontName
        let fontSize = CGFloat(sender.value)
        
        textView.font = UIFont(name: font!, size: fontSize)
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) { // срабатывает при тапе на Text View
        textView.backgroundColor = .white
        textView.textColor = .gray
    }
    
    func textViewDidEndEditing(_ textView: UITextView) { // срабатывает по окончании работы
        textView.backgroundColor = self.view.backgroundColor
        textView.textColor = .black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        countLabel.text = "\(textView.text.count)"
        return textView.text.count + (text.count - range.length) <= 60
    }
}

