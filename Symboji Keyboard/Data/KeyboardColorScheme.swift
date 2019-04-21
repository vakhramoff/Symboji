//
//  File.swift
//  Symboji
//
//  Created by Сергей Вахрамов on 12/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//

import UIKit

enum KeyboardColorScheme {
    case light
    case dark
}

struct KeyboardColors {
    let regularButtonTextColor: UIColor
    let specialButtonTextColor: UIColor
    let buttonBackgroundColor: UIColor
    let buttonHighlightColor: UIColor
    
    init(colorScheme: KeyboardColorScheme) {
        switch colorScheme {
        case .light:
            regularButtonTextColor = .black
            buttonBackgroundColor = .white
            buttonHighlightColor = UIColor(red: 174/255, green: 179/255, blue: 190/255, alpha: 1.0)
            specialButtonTextColor = .black
        case .dark:
            regularButtonTextColor = .orange
            buttonBackgroundColor = UIColor(white: 80/255, alpha: 1.0)
            buttonHighlightColor = UIColor(white: 105/255, alpha: 1.0)
            specialButtonTextColor = .white
        }
    }
}
