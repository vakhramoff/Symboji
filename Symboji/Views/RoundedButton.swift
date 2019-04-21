//
//  RoundedButton.swift
//  Symboji
//
//  Created by Сергей Вахрамов on 14/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}

// MARK: - Private Methods
private extension RoundedButton {
    func commonInit() {
        layer.borderWidth = 3 / UIScreen.main.nativeScale
        layer.borderColor = titleColor(for: .normal)?.cgColor
        layer.cornerRadius = bounds.height / 2
        contentEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    }
}
