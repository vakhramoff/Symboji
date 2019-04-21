//
//  KeyboardViewController.swift
//  Mac Symbols Keyboard
//
//  Created by Сергей Вахрамов on 05/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var symbojiKeyboardView: SymbojiKeyboardView!
    var colorScheme: KeyboardColorScheme = .light
    
    
    override func viewWillAppear(_ animated: Bool) {
        symbojiKeyboardView.setNextKeyboardVisible(needsInputModeSwitchKey)
        
        let device: KeyboardDevice, orientation: KeyboardOrientation
        UIDevice.current.userInterfaceIdiom == .pad ? (device = .ipad) : (device = .iphone)
        UIDevice.current.orientation == .portrait ? (orientation = .portrait) : (orientation = .landscape)
        symbojiKeyboardView.setSize(for: device, in: orientation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SymbojiKeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        symbojiKeyboardView = objects.first as? SymbojiKeyboardView
        symbojiKeyboardView.delegate = self
        
        view.addSubview(symbojiKeyboardView)
        
        symbojiKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let inputView = inputView else { return }
         
        NSLayoutConstraint.activate(
            [
            symbojiKeyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
            symbojiKeyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            symbojiKeyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
            symbojiKeyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
            ]
        )

        symbojiKeyboardView.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        
        if textDocumentProxy.keyboardAppearance == .dark {
            colorScheme = .dark
        }
        
        symbojiKeyboardView.setColorScheme(colorScheme)
    }

}


// MARK: - Implementation of SymbojiKeyboardViewDelegate to enable keyboard actions like writing characters and deleting symbols
extension KeyboardViewController: KeyboardViewDelegate {
    func insertCharacter(_ newCharacter: String) {
        let proxy = self.textDocumentProxy
        proxy.insertText(newCharacter)
    }
    
    func deleteCharacterBeforeCursor() {
        let proxy = self.textDocumentProxy
        proxy.deleteBackward()
    }
    
    
}
