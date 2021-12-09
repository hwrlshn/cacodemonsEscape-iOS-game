import UIKit

class GameOverScreen: UIViewController {
    var score: Int = 0
    var difficultyName: String = ""
    var currentPlayerText: String?
    var currentPlayerPic: String?
    @IBOutlet weak var labelScoreResult: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        saveResult()
    }
    
    func saveResult() {
        let defaults = UserDefaults.standard
        if let unwrapNickname = currentPlayerText {
            defaults.set(score, forKey: unwrapNickname+".userResult."+String(score.hashValue))
        }
    }
    
    func config() {
        if let unwrapString = labelScoreResult.text {
            labelScoreResult.attributedText = setStylishText(
                string: R.string.localizable.gameOverScore(String(score)),
                font: "EternalUI-Regular",
                size: 55
            )
        }
        labelScoreResult.text = String(score)
        returnButton.setAttributedTitle(
            setStylishText(
                string: R.string.localizable.gameOverReturn(),
                font: "EternalUI-Regular",
                size: 45),
            for: .normal)
    }
    
    @IBAction func actionReturn(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
