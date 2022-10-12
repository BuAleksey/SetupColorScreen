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
    
    var color: Color!
    var delegat: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.layer.cornerRadius = 20
        
        resultView.backgroundColor = UIColor(
            red: CGFloat(color.red),
            green: CGFloat(color.green),
            blue: CGFloat(color.blue),
            alpha: 1
        )
        
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
        
        redValueLabel.text = String(format: "%.2f", color.red)
        greenValueLabel.text = String(format: "%.2f", color.green)
        blueValueLabel.text = String(format: "%.2f", color.blue)
        
        redTF.text = String(format: "%.2f", color.red)
        greenTF.text = String(format: "%.2f", color.green)
        blueTF.text = String(format: "%.2f", color.blue)
        
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
            redValueLabel.text = String(format: "%.2f", redSlider.value)
            color.red = redSlider.value
            redTF.text = String(format: "%.2f", redSlider.value)
        case greenSlider:
            greenValueLabel.text = String(format: "%.2f", greenSlider.value)
            color.green = greenSlider.value
            greenTF.text = String(format: "%.2f", greenSlider.value)
        default:
            blueValueLabel.text = String(format: "%.2f", blueSlider.value)
            color.blue = blueSlider.value
            blueTF.text = String(format: "%.2f", blueSlider.value)
        }
    }
    
    @IBAction func doneButtonTapped() {
        view.endEditing(true)
        delegat.setColor(from: color)
        dismiss(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let floatValue = Float(newValue) else { return }
        if textField == redTF {
            redValueLabel.text = String(format: "%.2f", floatValue)
            redSlider.value = CFloat(floatValue)
            resultView.backgroundColor = UIColor(
                red: CGFloat(floatValue),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1
            )
            color.red = floatValue
        } else if textField == greenTF {
            greenValueLabel.text = String(format: "%.2f", floatValue)
            greenSlider.value = CFloat(floatValue)
            resultView.backgroundColor = UIColor(
                red: CGFloat(redSlider.value),
                green: CGFloat(floatValue),
                blue: CGFloat(blueSlider.value),
                alpha: 1
            )
            color.green = floatValue
        } else {
            blueValueLabel.text = String(format: "%.2f", floatValue)
            blueSlider.value = CFloat(floatValue)
            resultView.backgroundColor = UIColor(
                red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(floatValue),
                alpha: 1
            )
            color.blue = floatValue
        }
    }
    
    // Так и не разобрался(
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(NSMutableAttributedString.endEditing)
        )
        toolBar.items = [doneButton]
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }
    
    private func endEditing() {
        view.endEditing(true)
    }
}

