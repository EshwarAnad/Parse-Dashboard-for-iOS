//
//  UIColor+Extensions.swift
//  Parse Dashboard for iOS
//
//  Copyright © 2017 Nathan Tannar.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Nathan Tannar on 8/30/17.
//

import UIKit

extension UIColor {
    
    static var primaryColor: UIColor {
        return .darkBlueAccent
    }
    
    static var darkBlueAccent: UIColor {
        return UIColor(r: 25, g: 48, b: 64)
    }
    
    static var darkBlueBackground: UIColor {
        return UIColor(r: 30, g: 59, b: 77)
    }
    
    static var lightBlueAccent: UIColor {
        return UIColor(r: 14, g: 105, b: 160)
    }
    
    static var lightBlueBackground: UIColor {
        return UIColor(r: 21, g: 156, b: 238)
    }
    
    static var logoTint: UIColor {
        return UIColor(r: 37, g: 158, b: 235)
    }
    
    static var darkPurpleBackground: UIColor {
        return UIColor(r: 102, g: 99, b: 122)
    }
    
    static var darkPurpleAccent: UIColor {
        return UIColor(r: 114, g: 111, b: 133)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    func lighter(by percentage: CGFloat = 10.0) -> UIColor {
        return self.adjust(by: abs(percentage)) ?? .white
    }
    
    func darker(by percentage: CGFloat = 10.0) -> UIColor {
        return self.adjust(by: -1 * abs(percentage)) ?? .black
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0;
        if (self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        } else{
            return nil
        }
    }
    
    func withAlpha(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
    func isDarker(than color: UIColor) -> Bool {
        return self.luminance < color.luminance
    }
    
    func isLighter(than color: UIColor) -> Bool {
        return !self.isDarker(than: color)
    }
    
    var ciColor: CIColor {
        return CIColor(color: self)
    }
    var RGBA: [CGFloat] {
        return [ciColor.red, ciColor.green, ciColor.blue, ciColor.alpha]
    }
    
    var luminance: CGFloat {
        
        let RGBA = self.RGBA
        
        func lumHelper(c: CGFloat) -> CGFloat {
            return (c < 0.03928) ? (c/12.92): pow((c+0.055)/1.055, 2.4)
        }
        
        return 0.2126 * lumHelper(c: RGBA[0]) + 0.7152 * lumHelper(c: RGBA[1]) + 0.0722 * lumHelper(c: RGBA[2])
    }
    
    var isDark: Bool {
        return self.luminance < 0.5
    }
    
    var isLight: Bool {
        return !self.isDark
    }
    
    var isBlackOrWhite: Bool {
        let RGBA = self.RGBA
        let isBlack = RGBA[0] < 0.09 && RGBA[1] < 0.09 && RGBA[2] < 0.09
        let isWhite = RGBA[0] > 0.91 && RGBA[1] > 0.91 && RGBA[2] > 0.91
        
        return isBlack || isWhite
    }
}
