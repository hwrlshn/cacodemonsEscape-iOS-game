import UIKit

func setStylishText(string: String, font: String, size: CGFloat) -> NSMutableAttributedString {
    var attributedFont: UIFont = UIFont.systemFont(ofSize: size)
    if font == "EternalUI-Regular" {
        if let unwrapFont = UIFont(name: "EternalUI-Regular", size: size) {
            attributedFont = unwrapFont
        }
    } else if font == "EternalLogo-Regular" {
        if let unwrapFont = UIFont(name: "EternalLogo-Regular", size: size) {
            attributedFont = unwrapFont
        }
    } else if font == "EternalLogo-Bold" {
        if let unwrapFont = UIFont(name: "EternalLogo-Regular", size: size) {
            attributedFont = unwrapFont
        }
    }
    let string: String = String(string)
    let attributedString = NSMutableAttributedString(string: string)
    attributedString.addAttribute(.font, value: attributedFont, range: NSRange(location: 0, length: string.count))
    return attributedString
}
