//
//  ViewController.swift
//  SetupColorScreen
//
//  Created by Buba on 24.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var resultView: UIView!
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.layer.cornerRadius = 20
        resultView.backgroundColor = .gray
    }

    @IBAction func slidersAction() {
        resultView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value / 255),
            green: CGFloat(greenSlider.value / 255),
            blue: CGFloat(blueSlider.value / 255), alpha: 1
        )
        redValueLabel.text = String(format: "%.2f", redSlider.value / 255)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value / 255)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value / 255)
    }
}

