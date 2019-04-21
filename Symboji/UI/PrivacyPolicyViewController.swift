//
//  PrivacyPolicyViewController.swift
//  Symboji
//
//  Created by Сергей Вахрамов on 07/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
    @IBOutlet private weak var privacyPolicyTextView: UITextView!
    @IBOutlet private weak var backButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localize()
        
        privacyPolicyTextView.scrollRangeToVisible(NSMakeRange(0,0))
    }
    
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
}

// MARK: - Localization of PrivacyPolicyViewController
extension PrivacyPolicyViewController {
    private func localize() {
        privacyPolicyTextView.text = "PrivacyPolicy.IsAvailableInEnglish".localized() + privacyPolicyTextView.text
        backButton.setTitle(
            "PrivacyPolicy.Back".localized(),
            for: .normal
        )
    }
    
    
}
