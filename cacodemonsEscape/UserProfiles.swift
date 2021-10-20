import Foundation
import UIKit

class Profile: Codable {
    var name: String
    var pic: String
    
    init (name: String, pic: String) {
        self.name = name
        self.pic = pic
    }
}
