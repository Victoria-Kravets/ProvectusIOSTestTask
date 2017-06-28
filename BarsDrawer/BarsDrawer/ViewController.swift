//
//  ViewController.swift
//  BarsDrawer
//
//  Created by Viktoria on 6/28/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let colors: [[UIColor]] =
        [
            [UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0),UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)],
            [UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0), UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0),UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0)],
            [UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0),UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)],
            [UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0), UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0),UIColor.init(red: 255.0, green: 0.0, blue: 0.0, alpha: 1.0)]
    ]
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = UIViewController()
        let barSize = 100
        let drawer = ColoredBarsDrawer(viewController: viewController, imageView: mainImageView, barSize: barSize)
        drawer.draw(colors: colors)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
//[
//    [(0, 0, 0),
//     (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
//     (1.0, 0, 0)],
//    [(0, 0, 1.0),
//     (51.0 / 255.0, 204.0 / 255.0, 1.0),
//     (102.0 / 255.0, 204.0 / 255.0, 0)],
//    [(102.0 / 255.0, 1.0, 0),
//     (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
//     (1.0, 102.0 / 255.0, 0)],
//    [(165.0 / 255.0, 69.0, 0),
//     (160.0 / 255.0, 85.0 / 255.0, 45.0 / 255.0),
//     (1.0, 102.0 / 255.0, 0)]]

