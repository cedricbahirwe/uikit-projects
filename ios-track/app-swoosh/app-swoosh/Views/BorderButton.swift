//
//  BorderButton.swift
//  app-swoosh
//
//  Created by Cédric Bahirwe on 21/05/2021.
//

import UIKit


class BorderButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.white.cgColor
    }

}
