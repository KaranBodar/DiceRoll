//
//  ViewController.swift
//  DiceRoll
//
//  Created by Karan Bodar on 25/04/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //MARK: - IBOutlet -
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var imgDiceImage: UIImageView!
    @IBOutlet weak var diceView: UIView!
    
    //MARK: - Variables -
    
    var imgArr = ["1","2","3","4","5","6"]
    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.blurView.layer.opacity = 0.8
        self.diceView.layer.opacity = 0
    }
    //MARK: - IBAction -
    @IBAction func clickRollDice(_ sender: UIButton) {
        rollDice()
        playSound()
    }
    //MARK: - Finction -
    func rollDice() {
        // Simple animation: rotate + fade out/in
        UIView.animate(withDuration: 0.2, animations: {
            self.imgDiceImage.transform = CGAffineTransform(rotationAngle: .pi)
            self.diceView.transform = CGAffineTransform(rotationAngle: .pi)
            self.imgDiceImage.alpha = 0.0
            self.diceView.alpha = 0.0
        }, completion: { _ in
            // Update dice face
            self.imgArr.shuffle()
            if let firstImg = self.imgArr.first {
                print(firstImg.description)
                self.imgDiceImage.image = UIImage(named: firstImg)
            }
            
            // Animate back
            UIView.animate(withDuration: 0.2) {
                self.imgDiceImage.transform = .identity
                self.diceView.layer.opacity = 1
                self.diceView.transform = .identity
                self.imgDiceImage.alpha = 1.0
                self.diceView.alpha = 1.0
            }
        })
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "DiceRoll", withExtension: ".mp3") else {
            print("File not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Faild to play sound.")
        }
    }
}
