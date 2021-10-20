import UIKit

class MainMenu: UIViewController {
    @IBOutlet weak var burgerMenuX: NSLayoutConstraint!
    @IBOutlet weak var closeBurgerMenuButton: UIButton!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var player1Pic: UIImageView!
    @IBOutlet weak var player1Name: UIButton!
    @IBOutlet weak var player2Pic: UIImageView!
    @IBOutlet weak var player2Name: UIButton!
    @IBOutlet weak var player3Pic: UIImageView!
    @IBOutlet weak var player3Name: UIButton!
    @IBOutlet weak var currentPlayerNickname: UILabel!
    @IBOutlet weak var currentPlayerAvatar: UIImageView!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var leaderboard: UIButton!
    @IBOutlet weak var signUpLine: UIView!
    @IBOutlet weak var developedByLine: UIView!
    @IBOutlet weak var developerLink: UILabel!
    @IBOutlet weak var burgerMenuView: UIView!
    
    var playersDict: [String: Any] = [:]
    var unwrapDict: [String: String] = [:]
    var currentPlayerText: String? = nil
    var currentPlayerPic: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(NSHomeDirectory())
        config()
    }
    
    func config() {
        navigationController?.isNavigationBarHidden = true
        blur.effect = nil
        closeBurgerMenuButton.isHidden = true
        player1Pic.isHidden = true
        player2Pic.isHidden = true
        player3Pic.isHidden = true
        player1Name.isHidden = true
        player2Name.isHidden = true
        player3Name.isHidden = true
        currentPlayerNickname.isHidden = true
        currentPlayerAvatar.isHidden = true
        player1Pic.halfCornerRadius()
        player2Pic.halfCornerRadius()
        player3Pic.halfCornerRadius()
        currentPlayerAvatar.halfCornerRadius()
        signUp.setAttributedTitle(setStylishText(
            string: "Sign Up",
            font: "EternalUI-Regular",
            size: 30), for: .normal)
        if let unwrapString = currentPlayerNickname.text {
            currentPlayerNickname.attributedText = setStylishText(
                string: unwrapString,
                font: "EternalUI-Regular",
                size: 18
            )
        }
        start.setAttributedTitle(setStylishText(
            string: "Start",
            font: "EternalUI-Regular",
            size: 45), for: .normal)
        leaderboard.setAttributedTitle(setStylishText(
            string: "Leaderboard",
            font: "EternalUI-Regular",
            size: 45), for: .normal)
        signUpLine.addShadows(radius: 5, opacity: 0.55)
        developedByLine.addShadows(radius: 5, opacity: 0.55)
        if let unwrapString = developerLink.text {
            developerLink.attributedText = setStylishText(
                string: unwrapString,
                font: "EternalUI-Regular",
                size: 18
            )
        }
        burgerMenuView.addShadows(radius: 25, opacity: 1)
    }
    
    func searchProfiles() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        defaults.dictionaryRepresentation().forEach{ json in
            if json.key.contains(".userProfile") {
                if let object = defaults.value(forKey: json.key) as? Data {
                    if let decodedData = try? decoder.decode(Profile.self, from: object) {
                        playersDict[json.key] = decodedData.pic
                    }
                }
            }
        }
    }
    
    func removeDefaultTag(string: String) -> String {
        let index = string.index(string.endIndex, offsetBy: -12)
        return string.substring(to: index)
    }
    
    func setProfilesUI() {
        unwrapDict = playersDict.compactMapValues{ $0 as? String }
        print(unwrapDict)
        searchProfiles()
        if unwrapDict.count == 0 {
            config()
        } else if unwrapDict.count == 1 {
            let playerOne = Array(unwrapDict)[0]
            player1Pic.isHidden = false
            player1Name.isHidden = false
            player1Pic.image = UIImage(named: playerOne.value)
            player1Name.setAttributedTitle(setStylishText(
                string: removeDefaultTag(string: playerOne.key),
                font: "EternalUI-Regular",
                size: 25), for: .normal)
        } else if unwrapDict.count == 2 {
            player1Pic.isHidden = false
            player1Name.isHidden = false
            player2Pic.isHidden = false
            player2Name.isHidden = false
            let playerOne = Array(unwrapDict)[0]
            let playerTwo = Array(unwrapDict)[1]
            player1Pic.image = UIImage(named: playerOne.value)
            player2Pic.image = UIImage(named: playerTwo.value)
            player1Name.setAttributedTitle(setStylishText(
                string: removeDefaultTag(string: playerOne.key),
                font: "EternalUI-Regular",
                size: 25), for: .normal)
            player2Name.setAttributedTitle(setStylishText(
                string: removeDefaultTag(string: playerTwo.key),
                font: "EternalUI-Regular",
                size: 25), for: .normal)
        } else {
            player1Pic.isHidden = false
            player1Name.isHidden = false
            player2Pic.isHidden = false
            player2Name.isHidden = false
            player3Pic.isHidden = false
            player3Name.isHidden = false
            let playerOne = Array(unwrapDict)[0]
            let playerTwo = Array(unwrapDict)[1]
            let playerThree = Array(unwrapDict)[2]
            player1Pic.image = UIImage(named: playerOne.value)
            player2Pic.image = UIImage(named: playerTwo.value)
            player3Pic.image = UIImage(named: playerThree.value)
            player1Name.setAttributedTitle(setStylishText(
                string: removeDefaultTag(string: playerOne.key),
                font: "EternalUI-Regular",
                size: 25), for: .normal)
            player2Name.setAttributedTitle(setStylishText(
                string: removeDefaultTag(string: playerTwo.key),
                font: "EternalUI-Regular",
                size: 25), for: .normal)
            player3Name.setAttributedTitle(setStylishText(
                string: removeDefaultTag(string: playerThree.key),
                font: "EternalUI-Regular",
                size: 25), for: .normal)
        }
    }
    
    func blurOn() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
            self.blur.isHidden = false
            self.blur.effect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        }, completion: {isFinish in
            self.closeBurgerMenuButton.isHidden = false
        })
    }
    
    func blurOff() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.blur.effect = nil
        }, completion: {isFinish in
            self.closeBurgerMenuButton.isHidden = true
            self.blur.isHidden = true
        })
    }
    
    func openBurgerMenu() {
        searchProfiles()
        setProfilesUI()
        burgerMenuX.constant = -73
        blurOn()
    }
    
    func closeBurgerMenu() {
        searchProfiles()
        setProfilesUI()
        burgerMenuX.constant = -425
        blurOff()
    }
    
    @IBAction func actionBurgerMenu(_ sender: Any) {
        if burgerMenuX.constant == -73 {
            closeBurgerMenu()
        } else {
            openBurgerMenu()
        }
    }
    
    @IBAction func actionCloseBurgerMenu(_ sender: Any) {
        closeBurgerMenu()
    }
    
    @IBAction func actionStart(_ sender: Any) {
        if currentPlayerText == nil {
            let alert = UIAlertController(title: "Warning", message: "Log In to your account to save the race result", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "DifficultyID") as? DifficultyMenu {
                controller.currentPlayerText = currentPlayerText
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    @IBAction func actionLeaderboard(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LeaderboardID")
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if playersDict.count >= 3 {
            let alert = UIAlertController(title: "Warning", message: "The maximum number of players has been reached", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        } else {
            closeBurgerMenu()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SignUpID")
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func actionSwipeRight(_ sender: Any) {
        openBurgerMenu()
    }
    
    @IBAction func actionSwipeLeft(_ sender: Any) {
        closeBurgerMenu()
    }
    
    func getPlayer(profile: Int) {
        currentPlayerText = removeDefaultTag(string: Array(unwrapDict)[profile].key)
        currentPlayerPic = Array(unwrapDict)[profile].value
        currentPlayerNickname.text =  currentPlayerText
        if let unwrapPic: String = currentPlayerPic {
            currentPlayerAvatar.isHidden = false
            currentPlayerAvatar.image = UIImage(named: unwrapPic)
        }
        currentPlayerNickname.isHidden = false
    }
    
    @IBAction func actionPlayerOne(_ sender: Any) {
        getPlayer(profile: 0)
        closeBurgerMenu()
    }
    
    @IBAction func actionPlayerTwo(_ sender: Any) {
        getPlayer(profile: 1)
        closeBurgerMenu()
    }
    
    @IBAction func actionPlayerThree(_ sender: Any) {
        getPlayer(profile: 2)
        closeBurgerMenu()
    }
}

