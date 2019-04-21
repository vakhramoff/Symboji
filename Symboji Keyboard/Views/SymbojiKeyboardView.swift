//
//  SymbojiKeyboard.swift
//  Symboji
//
//  Created by Сергей Вахрамов on 13/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//

import UIKit

class SymbojiKeyboardView: UIView {

    @IBOutlet var deleteKeyboardButton: UIButton!
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var spaceKeyboardButton: UIButton!
    
    weak var delegate: KeyboardViewDelegate?
    
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    
    @IBAction func didTapButton(sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.title(for: UIControl.State.normal)
        
        guard let text = title else {
            return
        }
        
        switch text {
        case deleteKeyboardButton.title(for: .normal):
            delegate?.deleteCharacterBeforeCursor()
        case spaceKeyboardButton.title(for: .normal):
            delegate?.insertCharacter(" ")
        default:
            delegate?.insertCharacter(text)
        }
        
        //            proxy.deleteBackward()
        //            proxy.insertText(" ")
        //            self.advanceToNextInputMode()
        //            proxy.insertText(title!)
        
    }
    
    func setNextKeyboardVisible(_ visible: Bool) {
        nextKeyboardButton.isHidden = !visible
    }
    
    func setSize(for device: KeyboardDevice, in orientation: KeyboardOrientation) {
        let keyboardSize = KeyboardSize(for: device, in: orientation)
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: keyboardSize.height)
        self.addConstraint(heightConstraint)
        
        for button in self.allSubViews(type: KeyboardButton.self) {
            if button == nextKeyboardButton || button == deleteKeyboardButton || button == spaceKeyboardButton {
                button.titleLabel?.font = button.titleLabel?.font.withSize(keyboardSize.specialButtonsFontSize)
            } else {
                button.titleLabel?.font = button.titleLabel?.font.withSize(keyboardSize.regularButtonsFontSize)
            }
        }
    }
    
    func setColorScheme(_ colorScheme: KeyboardColorScheme) {
        let colorScheme = KeyboardColors(colorScheme: colorScheme)
        
        backgroundColor = UIColor.clear

        for button in self.allSubViews(type: KeyboardButton.self) {
            if button == nextKeyboardButton || button == deleteKeyboardButton || button == spaceKeyboardButton {
                button.defaultBackgroundColor = colorScheme.buttonHighlightColor
                button.highlightBackgroundColor = colorScheme.buttonBackgroundColor
                button.setTitleColor(colorScheme.specialButtonTextColor, for: [])
                button.tintColor = colorScheme.specialButtonTextColor
                
//                    if button == nextKeyboardButton {
//                        let image = UIImage(named: "Globus")?.withRenderingMode(.alwaysTemplate)
//                        button.setImage(image, for: .normal)
//                        button.setTitle("", for: .normal)
//                    }
            } else {
                button.defaultBackgroundColor = colorScheme.buttonBackgroundColor
                button.highlightBackgroundColor = colorScheme.buttonHighlightColor
                button.setTitleColor(colorScheme.regularButtonTextColor, for: [])
                button.tintColor = colorScheme.regularButtonTextColor
            }
        }
    }

}

// MARK: - Private methods of KeyboardView
extension SymbojiKeyboardView {
    private func localize() {
        nextKeyboardButton.setTitle("NextButton.Title".localized(), for: [])
        spaceKeyboardButton.setTitle("SpaceButton.Title".localized(), for: [])
        deleteKeyboardButton.setTitle("DeleteButton.Title".localized(), for: [])
    }
    
    private func commonInit() {
        setColorScheme(.light)
        setNextKeyboardVisible(false)
        localize()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler))
        deleteKeyboardButton.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc private func longPressHandler(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            timer?.invalidate()
            timer = nil
        }
    }
    
    @objc private func handleTimer(timer: Timer) {
        delegate?.deleteCharacterBeforeCursor()
    }
}
