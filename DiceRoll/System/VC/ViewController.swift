//
//  ViewController.swift
//  DiceRoll
//
//  Created by Karan Bodar on 25/04/25.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlet -
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var imgDiceImage: UIImageView!
    //MARK: - Variables -
    var imgArr = ["1","2","3","4","5","6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.blurView.layer.opacity = 0.8
    }
    //MARK: - IBAction -
    @IBAction func clickRollDice(_ sender: UIButton) {
        self.imgArr.shuffle()
        if let firstImg = self.imgArr.first {
            print(firstImg.description)
            self.imgDiceImage.image = UIImage(named: firstImg)
        }
    }

}

