import UIKit

class LeaderboardController: UIViewController {
    var resultsDict: [String: Int] = [:]
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        navigationController?.isNavigationBarHidden = true
        searchResults()
        resultsLabel.text = ""
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
        setResultList(array: resultsDict)
        if let unwrapString = resultsLabel.text {
            resultsLabel.attributedText = setStylishText(
                string: unwrapString,
                font: "EternalUI-Regular",
                size: 25
            )
        }
        resultsLabel.addShadows(radius: 15, opacity: 0.45)
    }
    
    func setResultList(array: [String: Int]) {
        if resultsDict.count < 5 {
            resultsLabel.text = "More results needed"
            resultsLabel.textAlignment = .center
        } else {
            for i in 0...4 {
                let key: String = "\(Array(resultsDict).sorted {$0.1 > $1.1}[i].key)"
                let value: String = "\(Array(resultsDict).sorted {$0.1 > $1.1}[i].value)"
                let splittedKey = key.split(separator: ".")[0]
                resultsLabel.text?.append(contentsOf: ">>| " + String(splittedKey)+" — " + value + "\n\n\n")
            }
        }
    }
    
    func searchResults() {
        let defaults = UserDefaults.standard
        defaults.dictionaryRepresentation().forEach { json in
            if json.key.contains(".userResult") {
                if let value = json.value as? Int {
                    resultsDict[json.key] = value
                }
            }
        }
    }
}
