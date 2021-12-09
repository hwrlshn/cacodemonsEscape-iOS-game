import UIKit

class LeaderboardController: UIViewController {
    var resultsDict: [String: Int] = [:]
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResults()
        config()
    }
    
    func config() {
        configController()
        configTableView()
    }
    
    func configController() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
    }
    
    func configTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = .clear
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

extension LeaderboardController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if resultsDict.count >= 5 {
            print(resultsDict.keys.count)

            let cell = tableview.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
            cell.backgroundColor = UIColor.clear
            let key: String = "\(Array(resultsDict).sorted {$0.1 > $1.1}[indexPath.row].key)"
            let value: String = "\(Array(resultsDict).sorted {$0.1 > $1.1}[indexPath.row].value)"
            let splittedKey = key.split(separator: ".")[0]
            cell.textLabel?.text = String(splittedKey)
            cell.detailTextLabel?.text = value
            return cell
        }
        return UITableViewCell()
    }
}
