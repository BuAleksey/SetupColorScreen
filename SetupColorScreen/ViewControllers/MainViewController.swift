//
//  MainViewController.swift
//  SetupColorScreen
//
//  Created by Buba on 11.10.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(from color: Color)
}

class MainViewController: UIViewController {
    
    var color = Color(red: 1, green: 1, blue: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: color.red,
            green: color.green,
            blue: color.blue,
            alpha: 1
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = color
        settingsVC.delegat = self
    }
}

extension MainViewController: SettingsViewControllerDelegate {
    func setColor(from color: Color) {
        self.color = color
        
        view.backgroundColor = UIColor(
            red: color.red,
            green: color.green,
            blue: color.blue,
            alpha: 1
        )
    }
}
