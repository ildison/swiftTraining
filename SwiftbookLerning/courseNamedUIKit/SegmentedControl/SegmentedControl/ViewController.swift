//
//  ViewController.swift
//  SegmentedControl
//
//  Created by Chugtai Ormund on 04/03/2020.
//  Copyright © 2020 Chugtai Ormund. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var uiElements = ["UISegmentedControl", "UILabel", "UISlider", "UITextField", "UIDatePicker", "UIButton"]
    
    var selectedElements: String?

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var done: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.value = 1
        
        label.text = String(slider.value)
        label.font = label.font.withSize(35)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: true)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .black
        
        datePicker.locale = Locale(identifier: "ru_RU")
        
        choiceUIElement()
        creatToolBar()
    }
    
    func  hideAllElements() {
        segmentedControl.isHidden = true
        label.isHidden = true
        slider.isHidden = true
        datePicker.isHidden = true
        done.isHidden = true
    }
    
    func choiceUIElement() {
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        textField.inputView = elementPicker
        
        // Costamization
        elementPicker.backgroundColor = .brown
    }
    
    @IBAction func choiceSegment(_ sender: UISegmentedControl) {
        label.isHidden = false
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            label.text = "The first segment is selected"
            label.textColor = .red
        case 1:
            label.text = "The secend segment is selected"
            label.textColor = .blue
        case 2:
            label.text = "The third segment is selected"
            label.textColor = .green
        default:
            print("error")
        }
    }
    
    func creatToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
        // Castomization
        toolBar.tintColor = .red
        toolBar.barTintColor = .brown
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        label.text = String(slider.value)
        let backgroundColor = self.view.backgroundColor
        self.view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }

    @IBAction func donePressed() {
        guard textField.text?.isEmpty == false else { return }
        
        if let _ = Double(textField.text!) {
            let alert = UIAlertController(title: "Wrong format", message: "Pleas enter your name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            label.text = textField.text
            textField.text = nil
        }
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormator = DateFormatter()
        
        dateFormator.dateStyle = .full
        dateFormator.locale = Locale(identifier: "ru_RU")
        let dateValue = dateFormator.string(from: sender.date)
        label.text = dateValue
    }

    @IBAction func switchAction(_ sender: UISwitch) {
        segmentedControl.isHidden = !segmentedControl.isHidden
        label.isHidden = !label.isHidden
        slider.isHidden = !slider.isHidden
        textField.isHidden = !textField.isHidden
        datePicker.isHidden = !datePicker.isHidden
        done.isHidden = !done.isHidden
        
        if sender.isOn {
            switchLabel.text = "Show all elements"
        } else {
            switchLabel.text = "Hide all elements"
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return uiElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return uiElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedElements = uiElements[row]
        textField.text = selectedElements
        
        hideAllElements()
//        ["UISegmentedControl", "UILabel", "UISlider", "UITextField", "UIDatePicker", "UIButton"]
        switch row {
        case 0:
            segmentedControl.isHidden = false
        case 1:
            label.isHidden = false
        case 2:
            slider.isHidden = false
        case 4:
            datePicker.isHidden = false
        case 5:
            done.isHidden = false
        default: break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerViewLabel = UILabel()
        
        if let currentLabel = view as? UILabel {
            pickerViewLabel = currentLabel
        } else {
            pickerViewLabel = UILabel()
        }
        
        pickerViewLabel.text = uiElements[row]
        pickerViewLabel.textAlignment = .center
        pickerViewLabel.font = pickerViewLabel.font.withSize(23)
        
        return pickerViewLabel
    }
    
}
