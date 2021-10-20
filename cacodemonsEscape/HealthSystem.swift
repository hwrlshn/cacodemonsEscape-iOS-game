import Foundation
import UIKit

var health: Int = 3
var damageEnabled: Bool = true

func minusHealth() -> Int {
    health -= 1
    return health
}
