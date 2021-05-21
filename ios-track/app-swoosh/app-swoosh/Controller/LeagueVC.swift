//
//  LeagueVC.swift
//  app-swoosh
//
//  Created by Cédric Bahirwe on 21/05/2021.
//

import UIKit

class LeagueVC: UIViewController {

    var player: Player!
    @IBOutlet weak var nextBtn: BorderButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.isEnabled = false
        player = Player()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSkillVC" {
            if let vc = segue.destination as? SkillVC {
                vc.player = player
            }
        }
    }
    
    @IBAction func onNextTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToSkillVC", sender: self)
    }

    @IBAction func onMensTapped(_ sender: UIButton) {
        setLeague(to: "Mens")
    }
    
    @IBAction func onWomensTapped(_ sender: UIButton) {
        setLeague(to: "Womens")
    }
    
    @IBAction func onCoedTapped(_ sender: UIButton) {
        setLeague(to: "Coed")
    }
    
    func setLeague(to leagueType: String) {
        player.desiredleague = leagueType
        nextBtn.isEnabled = true
    }
}
