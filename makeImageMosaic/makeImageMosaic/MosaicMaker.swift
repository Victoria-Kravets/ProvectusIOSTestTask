//
//  MakeMosaic.swift
//  makeImageMosaic
//
//  Created by Viktoria on 6/29/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import Foundation
import UIKit

class MosaicMaker {
    var barSize = 0
    private var context: CGContext!

    init(sizeOfBar: Int, image: UIImage) {
        barSize = sizeOfBar
        let getContextObj = Context()
        UIGraphicsBeginImageContext(image.size) // created grafic context and set size = view.frame
        context = getContextObj.getContext(image: image).0
        context = UIGraphicsGetCurrentContext() // reterns reference to the current graphics context

    }
    func draw(colorsRows: Array<Array<Array<UInt8>>>) -> UIImage {
        var x = 0
        var y = 0
        for row in colorsRows {
            for barColor in row {
                let rect = CGRect(x: x, y: y, width: barSize, height: barSize) //rect
                context.addRects([rect])
                let red: CGFloat = CGFloat(Double(barColor[0]) / 255)
                let green: CGFloat = CGFloat(Double(barColor[1]) / 255)
                let blue: CGFloat = CGFloat(Double(barColor[2]) / 255)
                let alpha: CGFloat = CGFloat(Double(barColor[3]) / 255)
                context?.setFillColor(UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor)
                context.fillPath()
                x += barSize
            }
            y += barSize
            x = 0
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

}
