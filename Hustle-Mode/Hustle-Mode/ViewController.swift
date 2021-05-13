//
//  ViewController.swift
//  Hustle-Mode
//
//  Created by Cédric Bahirwe on 12/05/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var darkBlueBG: UIImageView!
    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var cloudHolder: UIView!
    @IBOutlet weak var rocket: UIImageView!
    @IBOutlet weak var hustleLbl: UILabel!
    @IBOutlet weak var onLbl: UILabel!
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path  = Bundle.main.path(forResource: "hustle-on", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch let error as NSError {
            print("THE ERROR IS",error.description)
        }
    }

    @IBAction func powerBtnPressed(_ sender: UIButton) {
        cloudHolder.isHidden = false
        darkBlueBG.isHidden = true
        powerBtn.isHidden = true
        
        player.play()
        UIView.animate(withDuration: 2.3) {
            self.rocket.frame = CGRect(x: 0, y: 20, width: 375, height: 650)
        } completion: { (finished) in
            self.hustleLbl.isHidden = false
            self.onLbl.isHidden = false
        }

    }
    
}

