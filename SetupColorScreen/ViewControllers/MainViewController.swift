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
        setupBackgrounColor(from: color)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = color
        settingsVC.delegat = self
    }
}

//MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setColor(from color: Color) {
        self.color = color
        setupBackgrounColor(from: color)
    }
}

//MARK: - Privat metods
extension MainViewController {
    private func setupBackgrounColor(from color: Color) {
        view.backgroundColor = UIColor(
            red: CGFloat(color.red),
            green: CGFloat(color.green),
            blue: CGFloat(color.blue),
            alpha: 1
        )
    }
}
