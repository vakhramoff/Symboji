//
//  KeyboardFontSize.swift
//  Symboji
//
//  Created by Сергей Вахрамов on 22/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//

import UIKit


enum KeyboardDevice {
    case iphone
    case ipad
}

enum KeyboardOrientation {
    case portrait
    case landscape
}

struct KeyboardSize {
    let regularButtonsFontSize: CGFloat
    let specialButtonsFontSize: CGFloat
    let height: CGFloat
    
    init(for device: KeyboardDevice, in orientation: KeyboardOrientation) {
        switch device {
        case .iphone:
            regularButtonsFontSize = 17
            specialButtonsFontSize = 12
        case .ipad:
            regularButtonsFontSize = 21
            specialButtonsFontSize = 15
        }
        
        switch (device, orientation) {
        case (.iphone, .portrait):
            height = 290
        case (.iphone, .landscape):
            height = 240
        case (.ipad, .portrait):
            height = 360
        case (.ipad, .landscape):
            height = 300
        }
    }
}
