import Foundation
import UIKit

var cacodemon: [UIImage] = []
var dooomguy: [UIImage] = []
var animatedImage: UIImage?

func loadEnemysArr() {
    var i = 1
    while i <= 13 {
        if let unwrapPic: UIImage = UIImage(named: "doomguy\(i).png") {
            dooomguy.append(unwrapPic)
        }
        i += 1
    }
}

func animateIntro() -> UIImage {
    var i = 1
    while i <= 7 {
        if let unwrapPic: UIImage = UIImage(named: "demon\(i).png") {
            cacodemon.append(unwrapPic)
        }
        i += 1
    }
    if let unwrapSequence: UIImage = UIImage.animatedImage(with: cacodemon, duration: 1) {
        return unwrapSequence
    }
    return UIImage()
}
