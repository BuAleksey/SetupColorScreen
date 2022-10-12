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
    
    var color: Color!
    var delegat: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.layer.cornerRadius = 20
        
        resultView.backgroundColor = UIColor(
            red: color.red,
            green: color.green,
            blue: color.blue,
            alpha: 1
        )
        
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
        
        redValueLabel.text = String(format: "%.2f", color.red)
        greenValueLabel.text = String(format: "%.2f", color.green)
        blueValueLabel.text = String(format: "%.2f", color.blue)
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
            color.red = CGFloat(redSlider.value)
        case greenSlider:
            greenValueLabel.text = String(format: "%.2f", greenSlider.value)
            color.green = CGFloat(greenSlider.value)
        default:
            blueValueLabel.text = String(format: "%.2f", blueSlider.value)
            color.blue = CGFloat(blueSlider.value)
        }
    }
    
    @IBAction func doneButtonTapped() {
        delegat.setColor(from: color)
        dismiss(animated: true)
    }
}
