//
//  File.swift
//  Symboji
//
//  Created by Сергей Вахрамов on 19/03/2019.
//  Copyright © 2019 Sergey Vakhramov. All rights reserved.
//


protocol KeyboardViewDelegate: class {
    func insertCharacter(_ newCharacter: String)
    func deleteCharacterBeforeCursor()
}
