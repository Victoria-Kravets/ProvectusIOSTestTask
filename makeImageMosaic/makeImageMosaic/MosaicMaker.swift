//
//  MakeMosaic.swift
//  makeImageMosaic
//
//  Created by Viktoria on 6/29/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import Foundation
import UIKit

class MosaicMaker{
    let _viewController: UIViewController
    let _imageView: UIImageView
    var _barSize = 0
    private var context: CGContext!
    
    init(viewController: UIViewController, imageView: UIImageView, barSize: Int, image: UIImage){
        _viewController = viewController
        _imageView = imageView
        _barSize = barSize
        let getContextObj = Context()
        UIGraphicsBeginImageContext(image.size) // created grafic context and set size = view.frame
        context = getContextObj.getContext(image: image).0
        context = UIGraphicsGetCurrentContext() // reterns reference to the current graphics context
        
    }
    func draw(colorsRows: Array<Array<Array<UInt8>>>) -> UIImageView{
        var x = 0
        var y = 0
        for row in colorsRows {
            for barColor in row {
                let rect = CGRect(x: x, y: y, width: _barSize, height: _barSize) //rect
                context.addRects([rect])
                let red: CGFloat = CGFloat(Double(barColor[0]) / 255)
                let green: CGFloat = CGFloat(Double(barColor[1]) / 255)
                let blue: CGFloat = CGFloat(Double(barColor[2]) / 255)
                let alpha: CGFloat = CGFloat(Double(barColor[3]) / 255)
                context?.setFillColor(UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor)
                context.fillPath()
                x += _barSize
            }
            y += _barSize
            x = 0
        }
        _imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return _imageView
    }
    
}
