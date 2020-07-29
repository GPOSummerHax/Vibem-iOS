//
//  Character+Extensions.swift
//  Vibem
//
//  Created by Hanzheng Li on 7/28/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

extension Character {
    private var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    private var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
    
//    let emojiDict: [String: Character] = 
}
