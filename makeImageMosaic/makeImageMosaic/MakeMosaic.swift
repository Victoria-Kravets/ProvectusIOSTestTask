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
        open var _barSize: Int = 0
        init(viewController: UIViewController, imageView: UIImageView, barSize: Int){
            _viewController = viewController
            _imageView = imageView
            _barSize = barSize
        }
        func draw(colors: Array<Array<Array<UInt8>>>) -> UIImageView{
            var x = 0
            var y = 0
            var arrayColorOfDigit = [UInt8]()
            arrayColorOfDigit.removeAll()
            for color in colors {
                for element in color {
                    drawRectFrom(fromPoint: CGPoint(x: x, y: y), toPoint: CGPoint(x: _barSize, y: _barSize), color: element)
                    x += _barSize
                }
                y += _barSize
                x = 0
            }
            return _imageView
        }
        func drawRectFrom(fromPoint: CGPoint, toPoint: CGPoint, color: Array<UInt8>) {
            
            UIGraphicsBeginImageContext(_viewController.view.frame.size) // created grafic context and set size = view.frame
            let context = UIGraphicsGetCurrentContext() // reterns reference to the current graphics context
            let rect = CGRect(x: fromPoint.x, y: fromPoint.y, width: toPoint.x, height: toPoint.y) //rect
            _imageView.image?.draw(in: CGRect(x: 0, y: 0, width: _viewController.view.frame.size.width, height: _viewController.view.frame.size.height))// point borders where posible to drawing
            context?.addRects([rect])
            context?.setFillColor(red: CGFloat(color[0]), green: CGFloat(color[1]), blue: CGFloat(color[2]), alpha: CGFloat(color[3]))
            // 4)
            context?.fillPath()
            // 5
            
            _imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            
            
        }
        
        
        
        
        
}
