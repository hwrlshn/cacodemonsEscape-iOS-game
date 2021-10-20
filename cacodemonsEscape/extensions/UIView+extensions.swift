import UIKit

extension UIView {
    
    func halfCornerRadius() {
        layer.cornerRadius = frame.height / 2
    }
    
    func addShadows(radius: CGFloat, opacity: Float) {
        layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = opacity
            layer.shadowOffset = .zero
            layer.shadowRadius = radius
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
    }
}
