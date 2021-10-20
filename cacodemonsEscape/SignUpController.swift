import UIKit

class SignUpController: UIViewController {
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    @IBOutlet weak var pic5: UIImageView!
    @IBOutlet weak var pic6: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicLabel: UILabel!
    
    var playerPic: String?
    var playerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        if let unwrapString = nameLabel.text {
            nameLabel.attributedText = setStylishText(
                string: unwrapString,
                font: "EternalLogo-Bold",
                size: 45
            )
        }
        if let unwrapString = profilePicLabel.text {
            profilePicLabel.attributedText = setStylishText(
                string: unwrapString,
                font: "EternalLogo-Bold",
                size: 45
            )
        }
        signUpButton.setAttributedTitle(
            setStylishText(
                string: "Sign Up",
                font: "EternalUI-Regular",
                size: 45),
            for: .normal)
    }
    
    func saveToDefault() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        if let unwrapPic = playerPic {
            if let unwrapName = playerName {
                let object = Profile(name: unwrapName, pic: unwrapPic)
                if let data = try? encoder.encode(object) {
                    defaults.set(data, forKey: unwrapName+".userProfile")
                }
            }
        }
    }
    
    @IBAction func actionSignUp(_ sender: Any) {
        let alert = UIAlertController(title: "Sign Up", message: "Create profile?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self]isYes in
            self.playerName = self.textField.text
            self.saveToDefault()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "MainMenuID") as? MainMenu {
                navigationController?.popViewController(animated: true)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alert, animated: true)
    }
    
    @IBAction func actionPic1Button(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
            self.pic1.layer.opacity = 1
            self.pic2.layer.opacity = 0.5
            self.pic3.layer.opacity = 0.5
            self.pic4.layer.opacity = 0.5
            self.pic5.layer.opacity = 0.5
            self.pic6.layer.opacity = 0.5
        }, completion: {isFinish in
            self.playerPic = "profilePic1.jpg"
        })
    }
    
    @IBAction func actionPic2Button(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
            self.pic1.layer.opacity = 0.5
            self.pic2.layer.opacity = 1
            self.pic3.layer.opacity = 0.5
            self.pic4.layer.opacity = 0.5
            self.pic5.layer.opacity = 0.5
            self.pic6.layer.opacity = 0.5
        }, completion: {isFinish in
            self.playerPic = "profilePic2.jpg"
        })
    }
    
    @IBAction func actionPic3Button(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
            self.pic1.layer.opacity = 0.5
            self.pic2.layer.opacity = 0.5
            self.pic3.layer.opacity = 1
            self.pic4.layer.opacity = 0.5
            self.pic5.layer.opacity = 0.5
            self.pic6.layer.opacity = 0.5
        }, completion: {isFinish in
            self.playerPic = "profilePic3.jpg"
        })
    }
    
    @IBAction func actionPic4Button(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
            self.pic1.layer.opacity = 0.5
            self.pic2.layer.opacity = 0.5
            self.pic3.layer.opacity = 0.5
            self.pic4.layer.opacity = 1
            self.pic5.layer.opacity = 0.5
            self.pic6.layer.opacity = 0.5
        }, completion: {isFinish in
            self.playerPic = "profilePic4.jpg"
        })
    }
    
    @IBAction func actionPic5Button(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
            self.pic1.layer.opacity = 0.5
            self.pic2.layer.opacity = 0.5
            self.pic3.layer.opacity = 0.5
            self.pic4.layer.opacity = 0.5
            self.pic5.layer.opacity = 1
            self.pic6.layer.opacity = 0.5
        }, completion: {isFinish in
            self.playerPic = "profilePic5.jpg"
        })
    }
    
    @IBAction func actionPic6Button(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCrossDissolve, animations: {
            self.pic1.layer.opacity = 0.5
            self.pic2.layer.opacity = 0.5
            self.pic3.layer.opacity = 0.5
            self.pic4.layer.opacity = 0.5
            self.pic5.layer.opacity = 0.5
            self.pic6.layer.opacity = 1
        }, completion: {isFinish in
            self.playerPic = "profilePic6.jpg"
        })
    }
}
