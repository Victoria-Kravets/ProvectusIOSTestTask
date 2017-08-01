//
//  BorderedButton.swift
//  makeImageMosaic
//
//  Created by Viktoria on 7/4/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {

    func getBorderFoButton(button: UIButton) {
        button.clipsToBounds = true
        button.layer.borderWidth = 1.0
        button.layer.borderColor = tintColor.cgColor
        button.layer.cornerRadius = 5.0
        button.setTitleColor(tintColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
    }

}
