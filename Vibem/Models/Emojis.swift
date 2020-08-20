//
//  Emojis.swift
//  Vibem
//
//  Created by Hanzheng Li on 8/19/20.
//  Copyright © 2020 GPOSummerHacks. All rights reserved.
//

import Foundation
import UIKit
import UIColor_Hex_Swift

class EmojiObject: Hashable, CustomStringConvertible {
    
    let emoji: Character
    let backgroundColor: UIColor
    
    var description: String {
        get {
            return String(emoji)
        }
    }
    
    init(of emoji: Character, backgroundColorHex: String) {
        self.emoji = emoji.isEmoji ? emoji : "🤡"
        self.backgroundColor = UIColor(backgroundColorHex)
    }
    
    init(of emoji: Character, backgroundColor: UIColor) {
        self.emoji = emoji.isEmoji ? emoji : "🤡"
        self.backgroundColor = backgroundColor
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(emoji)
        hasher.combine(backgroundColor)
    }
    
    static func == (lhs: EmojiObject, rhs: EmojiObject) -> Bool {
        return lhs.emoji == rhs.emoji && lhs.backgroundColor == rhs.backgroundColor
    }
}

class Emojis {
    
    static var selected = Set<EmojiObject>() {
        didSet {
            print(selected)
        }
    }
    
    static let objects: [EmojiObject] = [
        EmojiObject(of: "😗", backgroundColorHex: "#FFD94EFF"),
        EmojiObject(of: "🎉", backgroundColorHex: "#DDDF8BFF"),
        EmojiObject(of: "🔮", backgroundColorHex: "#F7C0FAFF"),
        EmojiObject(of: "🔥", backgroundColorHex: "#FFA40DFF"),
        EmojiObject(of: "😔", backgroundColorHex: "#DE7AD4FF"),
        EmojiObject(of: "😈", backgroundColorHex: "#DEA1EBFF"),
        EmojiObject(of: "🤡", backgroundColorHex: "#E77B6DFF"),
        EmojiObject(of: "😇", backgroundColorHex: "#5BAAFFFF"),
        EmojiObject(of: "😎", backgroundColorHex: "#DFC729FF"),
        EmojiObject(of: "😱", backgroundColorHex: "#CCD5FBFF"),
        EmojiObject(of: "😴", backgroundColorHex: "#CDD0D5FF"),
        EmojiObject(of: "😻", backgroundColorHex: "#FFF68DFF"),
        EmojiObject(of: "👑", backgroundColorHex: "#EDA8D0FF"),
        EmojiObject(of: "🙈", backgroundColorHex: "#E7DABCFF"),
        EmojiObject(of: "🌿", backgroundColorHex: "#87D333FF"),
        EmojiObject(of: "😡", backgroundColorHex: "#FECA69FF"),
        EmojiObject(of: "🙌", backgroundColorHex: "#74E980FF"),
        EmojiObject(of: "🙄", backgroundColorHex: "#FFCC91FF"),
        EmojiObject(of: "✌️", backgroundColorHex: "#D3E4FDFF"),
        EmojiObject(of: "😒", backgroundColorHex: "#FDF5CAFF"),
        EmojiObject(of: "😜", backgroundColorHex: "#FFEA3AFF"),
        EmojiObject(of: "😣", backgroundColorHex: "#EF97E6FF"),
        EmojiObject(of: "😭", backgroundColorHex: "#C0C0C0FF"),
        EmojiObject(of: "☀️", backgroundColorHex: "#FFFB99FF"),
        EmojiObject(of: "🤓", backgroundColorHex: "#B5D0DFFF"),
    ]
    
    static func description(for emoji: Character) -> String? {
        if objects.contains(where: { return $0.emoji == emoji }) {
            return "DAMN ryan got a cute ass"
        } else {
            return nil
        }
    }
}
