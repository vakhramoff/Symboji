//
//  ViewController.swift
//  Mac Keyboard
//
//  Created by Сергей Вахрамов on 05/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//

import UIKit
import MessageUI

class MainViewController: UIViewController {
    
    @IBOutlet private weak var appDescriptionTextView: UITextView!
    @IBOutlet private weak var addKeyboardInstructionsTextView: UITextView!
    
    @IBOutlet private weak var openSettingsButton: RoundedButton!
    @IBOutlet private weak var contactTheDeveloperButton: UIButton!
    @IBOutlet private weak var showPrivacyPolicyButton: UIButton!
    
    private func showStartScreen() {

        let blackView = UIView()

        blackView.backgroundColor = .black
        blackView.bounds = view.bounds
        blackView.center = view.center
        view.addSubview(blackView)


        let imageView = UIImageView(image: UIImage(named: "Icon"))
        imageView.center = view.center
        imageView.bounds.size = CGSize(width: 200, height: 200)

        view.addSubview(imageView)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                let translationX = CGFloat(0.0)
                let translationY = -(UIScreen.main.bounds.height / 2 + imageView.bounds.height + 10)
                
                imageView.transform = CGAffineTransform(translationX: translationX, y: translationY)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                blackView.alpha = 0.0
            })
        }) { _ in
            self.view.layoutIfNeeded()
            blackView.removeFromSuperview()
            imageView.removeFromSuperview()
        }

    }
    
    @IBAction func openSettingsTapped(_ sender: Any) {
        if let url = URL(string:UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.localize()
        
        view.backgroundColor = .black
        
        showStartScreen()
    }
}


// MARK: - Implementation of MFMailComposeViewControllerDelegate to enable contacting with Developer
extension MainViewController: MFMailComposeViewControllerDelegate {
    
    private func hardwareString() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, nil, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, nil, 0)
        
        var hardware: String = String(cString: hw_machine)
        
        // Check for simulator
        if hardware == "x86_64" || hardware == "i386" {
            if let deviceID = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] {
                hardware = deviceID
            }
        }
        
        return hardware
    }
    
    @IBAction func contactTheDeveloperTapped(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["vakhramoff@xakep.ru"])
            mail.setSubject("MainScreen.ContactTheDeveloper.MailTopic".localized())
            
            mail.setMessageBody(
                String.init(format: "MainScreen.ContactTheDeveloper.MailBodyText".localized(), hardwareString(), UIDevice.current.name, UIDevice.current.systemName, UIDevice.current.systemVersion),
                isHTML: true
            )
            
            self.present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "MainScreen.ContactTheDeveloper.SendMailErrorTitle".localized(), message: "MainScreen.ContactTheDeveloper.SendMailErrorMessage".localized(), preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "OK", style: .default, handler: nil)
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller:MFMailComposeViewController, didFinishWith result:MFMailComposeResult, error:Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Mail sent failure: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Private methods of MainViewController
private extension MainViewController {
    
    func localize() {
        appDescriptionTextView.text = "MainScreen.AppDescription".localized()
        addKeyboardInstructionsTextView.text = "MainScreen.AddKeyboardInstructions".localized()
        
        openSettingsButton.setTitle(
            "MainScreen.OpenSettings".localized(),
            for: .normal
        )
        contactTheDeveloperButton.setTitle(
            "MainScreen.ContactTheDeveloper".localized(),
            for: .normal
        )
        showPrivacyPolicyButton.setTitle(
            "MainScreen.ShowPrivacyPolicy".localized(),
            for: .normal
        )
    }
    
    
}
