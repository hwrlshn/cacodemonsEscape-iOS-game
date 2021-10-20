import UIKit

enum DifficultyLvl {
    case easy, medium, hard
    
    var nameDifficulty: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Normal"
        case .hard:
            return "Hard"
        }
    }
    
    var speedTrack: Double {
        switch self {
        case .easy:
            return 4
        case .medium:
            return 3
        case .hard:
            return 2
        }
    }
    
    var speedEnemies: Double {
        switch self {
        case .easy:
            return .random(in: 2...2.5)
        case .medium:
            return .random(in: 1.5...2)
        case .hard:
            return .random(in: 1...1.25)
        }
    }
    
    var countEnemies: Int {
        switch self {
        case .easy:
            return 1
        case .medium:
            return 2
        case .hard:
            return 3
        }
    }
    
    var earnScore: Int {
        switch self {
        case .easy:
            return 7
        case .medium:
            return 13
        case .hard:
            return 16
        }
    }
}

class DifficultyMenu: UIViewController {
    @IBOutlet weak var buttonNormal: UIButton!
    @IBOutlet weak var buttonHardcore: UIButton!
    var currentPlayerText: String?
    @IBOutlet weak var easy: UIButton!
    @IBOutlet weak var normal: UIButton!
    @IBOutlet weak var hardcore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
        easy.setAttributedTitle(
            setStylishText(
                string: "Easy",
                font: "EternalUI-Regular",
                size: 45),
            for: .normal)
        normal.setAttributedTitle(
            setStylishText(
                string: "Normal",
                font: "EternalUI-Regular",
                size: 45),
            for: .normal)
        hardcore.setAttributedTitle(
            setStylishText(
                string: "Hardcore",
                font: "EternalUI-Regular",
                size: 45),
            for: .normal)
    }
    
    @IBAction func actionStartEasy(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "TrackID") as? Track {
            controller.currentPlayerText = currentPlayerText
            controller.difficultySettings = DifficultyLvl.easy
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func actionStartMedium(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "TrackID") as? Track {
            controller.currentPlayerText = currentPlayerText
            controller.difficultySettings = DifficultyLvl.medium
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func actionStartHardcore(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "TrackID") as? Track {
            controller.currentPlayerText = currentPlayerText
            controller.difficultySettings = DifficultyLvl.hard
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

