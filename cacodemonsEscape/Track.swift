import UIKit

class Track: UIViewController {
    @IBOutlet weak var imageView1Top: NSLayoutConstraint!
    @IBOutlet weak var imageView1Bottom: NSLayoutConstraint!
    @IBOutlet weak var imageView1Vertical: NSLayoutConstraint!
    @IBOutlet weak var imageView2Bottom: NSLayoutConstraint!
    @IBOutlet weak var imageView2Top: NSLayoutConstraint!
    @IBOutlet weak var imageView2Vertical: NSLayoutConstraint!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var healthBar: UIImageView!
    var currentPlayerText: String?
    var currentPlayerPic: String?
    var difficultySettings: DifficultyLvl?
    var timer: Timer?
    var dmgTimer: Timer?
    let player = UIImageView()
    let enemy = UIImageView()
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        loadEnemysArr()
        playTimer()
        damageTimer()
        initPlayer()
        initEnemy()
        player.image = animateIntro()
    }
    
    func config() {
        navigationController?.isNavigationBarHidden = true
        imageView2Bottom.constant += view.frame.maxY
        imageView2Top.constant -= view.frame.maxY
        imageView2Vertical.constant -= view.frame.maxY
        view.layoutIfNeeded()
        
        if let unwrapString = scoreLabel.text {
            scoreLabel.attributedText = setStylishText(
                string: unwrapString,
                font: "EternalLogo-Regular",
                size: 23
            )
        }
        if let unwrapString = scoreLabel.text {
            scoreLabel.attributedText = setStylishText(
                string: unwrapString,
                font: "EternalUI-Regular",
                size: 30
            )
        }
        scoreLabel.addShadows(radius: 5, opacity: 0.55)
        healthBar.addShadows(radius: 5, opacity: 0.55)
    }
    
    func resetAllParameters() {
        health = 3
        cacodemon = []
        dooomguy = []
        difficultySettings = nil
    }
    
    func initPlayer() {
        health = 3
        let width = 100
        player.frame = CGRect(
            x: view.frame.midX - CGFloat(width / 2),
            y: view.frame.maxY - 150,
            width: CGFloat(width),
            height: CGFloat(width))
        view.addSubview(player)
    }
    
    func initEnemy() {
        let width: CGFloat = .random(in: 95...165)
        enemy.image = dooomguy.randomElement()
        enemy.frame = CGRect(
            x: .random(in: view.frame.minX...view.frame.maxX),
            y: -width - 150,
            width: width,
            height: width)
        view.addSubview(enemy)
    }
    
    func playTimer()
    {
        guard let unwrapSpeedTrack = difficultySettings?.speedTrack else {
            return
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: unwrapSpeedTrack, target: self, selector: #selector(scrollScenes), userInfo: nil, repeats: true)
        }
    }
    
    func damageTimer()
    {
        if dmgTimer == nil {
            dmgTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(checkDamage), userInfo: nil, repeats: true)
        }
    }
    
    func calculateScore() {
        if let unwrapEarnScore = difficultySettings?.earnScore {
            score += unwrapEarnScore
        }
        scoreLabel.text = "Score: \(score)"
    }
    
    func healthStatus() {
        let healthPoint = minusHealth()
        switch healthPoint {
        case 2:
            healthBar.image = UIImage(named: "2hearts.png")
        case 1:
            healthBar.image = UIImage(named: "1hearts.png")
        case 0:
            healthBar.image = UIImage(named: "0hearts.png")
            gameOver()
        default:
            print("")
        }
    }
    
    func killTimers() {
        timer?.invalidate()
        dmgTimer?.invalidate()
    }
    
    func gameOver() {
        if let unwrapNameDifficulty = difficultySettings?.nameDifficulty {
            killTimers()
            resetAllParameters()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "GameOverID") as? GameOverScreen {
                controller.currentPlayerText = currentPlayerText
                controller.score = score
                navigationController?.pushViewController(controller, animated: true)
            }
        }
        
    }
    
    @objc func scrollScenes() {
        initEnemy()
        movingRoad()
        movingEnemy()
        damageEnabled = true
    }
    
    func movingRoad() {
        guard let unwrapSpeedTrack = difficultySettings?.speedTrack else {
            return
        }
        player.image = UIImage(named: "demon5.png")
        UIImageView.animate(
            withDuration: unwrapSpeedTrack / 2,
            delay: 0,
            options: .curveLinear,
            animations: {
                self.imageView1Top.constant += self.view.frame.maxY
                self.imageView1Bottom.constant -= self.view.frame.maxY
                self.imageView1Vertical.constant += self.view.frame.maxY
                self.imageView2Bottom.constant -= self.view.frame.maxY
                self.imageView2Top.constant += self.view.frame.maxY
                self.imageView2Vertical.constant += self.view.frame.maxY
                self.view.layoutIfNeeded()
            }, completion: { isFinish in
                self.calculateScore()
                self.imageView1Top.constant -= self.view.frame.height * 2
                self.imageView1Bottom.constant += self.view.frame.height * 2
                self.imageView1Vertical.constant -= self.view.frame.height * 2
                self.view.layoutIfNeeded()
            })
        UIImageView.animate(
            withDuration: unwrapSpeedTrack / 2,
            delay: unwrapSpeedTrack / 2,
            options: .curveLinear,
            animations: {
                self.imageView2Bottom.constant -= self.view.frame.maxY
                self.imageView2Top.constant += self.view.frame.maxY
                self.imageView2Vertical.constant += self.view.frame.maxY
                self.imageView1Top.constant += self.view.frame.height
                self.imageView1Bottom.constant -= self.view.frame.height
                self.imageView1Vertical.constant += self.view.frame.height
                self.view.layoutIfNeeded()
            }, completion: {isFinish in
                self.calculateScore()
                self.imageView2Bottom.constant += self.view.frame.maxY * 2
                self.imageView2Top.constant -= self.view.frame.maxY * 2
                self.imageView2Vertical.constant -= self.view.frame.maxY * 2
                self.view.layoutIfNeeded()
            })
    }
    
    func movingEnemy() {
        guard let unwrapSpeedEnemies = difficultySettings?.speedEnemies else {
            return
        }
        UIImageView.animate(
            withDuration: unwrapSpeedEnemies,
            delay: 0,
            options: .curveLinear,
            animations: {
                self.enemy.frame = CGRect(
                    x: .random(in: self.view.frame.minX...self.view.frame.maxX - 150),
                    y: self.view.frame.maxY + self.enemy.frame.width,
                    width: self.enemy.frame.width,
                    height: self.enemy.frame.height)
            },
            completion: {isFinish in
                self.enemy.frame = CGRect(
                    x: .random(in: self.view.frame.minX...self.view.frame.maxX - 150),
                    y: -175,
                    width: self.enemy.frame.width,
                    height: self.enemy.frame.height)
            })
    }
    
    @IBAction func actionSwipeLeft(_ sender: Any) {
        if player.frame.minX >= view.frame.minX {
            UIImageView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.player.image = UIImage(named: "demon4.png")
                    self.player.frame = CGRect(
                        x: self.player.frame.minX - 90,
                        y: self.view.frame.maxY - 150,
                        width: self.player.frame.width,
                        height: self.player.frame.width)
                }, completion: {isFinish in
                    self.player.image = UIImage(named: "demon5.png")
                })
        }
    }
    
    @IBAction func actionSwipeRight(_ sender: Any) {
        if player.frame.maxX <= view.frame.maxX {
            UIImageView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseIn,
                animations: {
                    self.player.image = UIImage(named: "demon6.png")
                    self.player.frame = CGRect(
                        x: self.player.frame.minX + 90,
                        y: self.view.frame.maxY - 150,
                        width: self.player.frame.width,
                        height: self.player.frame.width)
                }, completion: {isFinish in
                    self.player.image = UIImage(named: "demon5.png")
                })
        }
    }
    
    @objc func checkDamage() {
        guard let unwrapPlayerFrame = player.layer.presentation()?.frame else {
            return
        }
        guard let unwrapEnemyFrame = enemy.layer.presentation()?.frame else {
            return
        }
        if unwrapPlayerFrame.intersects(unwrapEnemyFrame) {
            if damageEnabled == true {
                damageEnabled = false
                enemy.removeFromSuperview()
                damageAnimation()
                healthStatus()
            }
        }
    }
    
    func damageAnimation() {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveLinear,
            animations: {
                self.player.frame = CGRect(
                    x: self.player.frame.origin.x - 15,
                    y: self.player.frame.origin.y,
                    width: self.player.frame.width,
                    height: self.player.frame.width)
                self.view.layoutIfNeeded()
            })
        UIView.animate(
            withDuration: 0.1,
            delay: 0.1,
            options: .curveLinear,
            animations: {
                self.player.frame = CGRect(
                    x: self.player.frame.origin.x + 15,
                    y: self.player.frame.origin.y,
                    width: self.player.frame.width,
                    height: self.player.frame.width)
                self.view.layoutIfNeeded()
            })
        UIView.animate(
            withDuration: 0.1,
            delay: 0.2,
            options: .curveLinear,
            animations: {
                self.player.frame = CGRect(
                    x: self.player.frame.origin.x - 15,
                    y: self.player.frame.origin.y,
                    width: self.player.frame.width,
                    height: self.player.frame.width)
                self.view.layoutIfNeeded()
            })
        UIView.animate(
            withDuration: 0.1,
            delay: 0.3,
            options: .curveLinear,
            animations: {
                self.player.frame = CGRect(
                    x: self.player.frame.origin.x + 15,
                    y: self.player.frame.origin.y,
                    width: self.player.frame.width,
                    height: self.player.frame.width)
                self.view.layoutIfNeeded()
            })
    }
}
