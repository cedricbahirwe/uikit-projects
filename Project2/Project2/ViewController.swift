//
//  ViewController.swift
//  Project2
//
//  Created by Cédric Bahirwe on 23/02/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var correctAnswer = 0
    var answeredQuestions = 0
    
    var countries = [String]()
    var score = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        askQuestion()

    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)."

        } else {
            title = "Wrong"
            score -= 1
            message = "Wrong! That’s the flag of \(countries[sender.tag])."
        }
        answeredQuestions += 1
        let isfinal = answeredQuestions % 10 == 0
        let ac = UIAlertController(title: title, message: isfinal ? "Your final score is \(score)." : message, preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    func askQuestion(_ alert: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title =  "Your score is: \(score)\t Find: " + countries[correctAnswer].uppercased()

    }
    
}

