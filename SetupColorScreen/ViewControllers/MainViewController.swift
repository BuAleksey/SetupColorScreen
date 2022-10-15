//
//  MainViewController.swift
//  SetupColorScreen
//
//  Created by Buba on 11.10.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(from color: UIColor)
}

class MainViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegat = self
    }
}

//MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setColor(from color: UIColor) {
        view.backgroundColor = color
    }
}
