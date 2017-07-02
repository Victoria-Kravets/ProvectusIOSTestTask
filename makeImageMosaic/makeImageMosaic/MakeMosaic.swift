//
//  MakeMosaic.swift
//  makeImageMosaic
//
//  Created by Viktoria on 6/29/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import Foundation
import UIKit

class MakeMosaic{
        open let _viewController: UIViewController
        open let _imageView: UIImageView
        open var _barSize = 0
        private var context: CGContext!
    
        init(viewController: UIViewController, imageView: UIImageView, barSize: Int){
            _viewController = viewController
            _imageView = imageView
            _imageView.image?.draw(in: CGRect(x: 0, y: 0, width: _viewController.view.frame.size.width, height: _viewController.view.frame.size.height))// point borders where posible to drawing
            
            UIGraphicsBeginImageContext(_viewController.view.frame.size) // created grafic context and set size = view.frame
            context = UIGraphicsGetCurrentContext() // reterns reference to the current graphics context
            
            _barSize = barSize
        }
        func draw(colorsRows: Array<Array<Array<UInt8>>>) -> UIImageView{
            var x = 0
            var y = 0
            var arrayColorOfDigit = [UInt8]()
            arrayColorOfDigit.removeAll()
            for row in colorsRows {
                for barColor in row {
                    drawRectFrom(x: x, y: y, width: _barSize, height: _barSize, color: barColor)
                    x += _barSize
                }
                y += _barSize
                x = 0
            }
            _imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return _imageView
        }
    
        func drawRectFrom(x: Int, y: Int, width: Int, height: Int, color: Array<UInt8>) {
            let rect = CGRect(x: x, y: y, width: width, height: height) //rect
            context.setFillColor(red: CGFloat(color[0]), green: CGFloat(color[1]), blue: CGFloat(color[2]), alpha: CGFloat(color[3]))
            context.fill([rect])

        }

}
