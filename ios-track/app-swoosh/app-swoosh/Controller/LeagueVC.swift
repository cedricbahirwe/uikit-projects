//
//  LeagueVC.swift
//  app-swoosh
//
//  Created by Cédric Bahirwe on 21/05/2021.
//

import UIKit

class LeagueVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onNextTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segueToSkillVC", sender: self)
    }

}
