//
//  ViewController.swift
//  SetupColorScreen
//
//  Created by Buba on 24.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var resultView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var delegat: SettingsViewControllerDelegate!
    var color: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.layer.cornerRadius = 20
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        setValue(for: redTF, greenTF, blueTF)
        
        resultView.backgroundColor = color
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func slidersActions(_ sender: UISlider) {
        resultView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
        
        switch sender {
        case redSlider:
            setValue(for: redValueLabel)
            setValue(for: redTF)
        case greenSlider:
            setValue(for: greenValueLabel)
            setValue(for: greenTF)
        default:
            setValue(for: blueValueLabel)
            setValue(for: blueTF)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonTapped() {
        delegat.setColor(from: resultView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
}

//MARK: - Private methods
extension SettingsViewController {
    private func setColor() {
        resultView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for sliders: UISlider...) {
        let color = CIColor(color: color ?? .white)
        sliders.forEach { slider in
            switch slider {
            case redSlider:
                redSlider.value = Float(color.red)
            case greenSlider:
                greenSlider.value = Float(color.green)
            default:
                blueSlider.value = Float(color.blue)
            }
        }
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                redValueLabel.text = setStringValue(from: redSlider)
            case greenValueLabel:
                greenValueLabel.text = setStringValue(from: greenSlider)
            default:
                blueValueLabel.text = setStringValue(from: blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                redTF.text = setStringValue(from: redSlider)
            case greenTF:
                greenTF.text = setStringValue(from: greenSlider)
            default:
                blueTF.text = setStringValue(from: blueSlider)
            }
        }
    }
    
    private func setStringValue(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "1.00"
            textField?.becomeFirstResponder()
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else {
            showAlert(title: "Wrong", message: "Please enter correct value")
            return
        }
        guard let floatValue = Float(newValue), (0...1).contains(floatValue) else {
            showAlert(
                title: "Wrong",
                message: "Please enter correct value",
                textField: textField)
            return
        }
        
        switch textField {
        case redTF:
            redSlider.setValue(floatValue, animated: true)
            setValue(for: redValueLabel)
        case greenTF:
            greenSlider.setValue(floatValue, animated: true)
            setValue(for: greenValueLabel)
        default:
            blueSlider.setValue(floatValue, animated: true)
            setValue(for: blueValueLabel)
        }
        
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexed = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        toolBar.items = [flexed, doneButton]
    }
}

