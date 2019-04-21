//
//  String.swift
//  Symboji
//
//  Created by Сергей Вахрамов on 19/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//

import Foundation


extension String {
    
//    func localized() -> String {
//        return NSLocalizedString(self, comment: "")
//    }
    func localized(language: String = Locale.current.languageCode!, comment: String = "") -> String {

        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        if path == nil {
            return self
        }
        let bundle = Bundle(path: path!)
        if bundle == nil {
            return self
        }
        let localized : String? = NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: comment)
        return localized ?? self
    }
}
