//
//  Theme.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 11.08.21.
//

import UIKit

struct Theme {
    
    enum Font {
        
        enum Weight: String {
            case regular = "Lato-Regular"
            case italic = "Lato-Italic"
            case hairline = "Lato-Hairline"
            case hairlineItalic = "Lato-HairlineItalic"
            case light = "Lato-Light"
            case lightItalic = "Lato-LightItalic"
            case bold = "Lato-Bold"
            case boldItalic = "Lato-BoldItalic"
            case black = "Lato-Black"
            case blackItalic = "Lato-BlackItalic"
        }
        
        static func appFont(ofSize size: CGFloat, weight: Weight) -> UIFont {
            UIFont(name: weight.rawValue, size: size) ?? .systemFont(ofSize: size)
        }
    }

    enum Color {
        static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let gray = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        static let lightGray = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        static let blue = #colorLiteral(red: 0.1843137255, green: 0.2862745098, blue: 0.862745098, alpha: 1)
        static let darkerBlue = #colorLiteral(red: 0.1607843137, green: 0.2509803922, blue: 0.768627451, alpha: 1)
        static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
