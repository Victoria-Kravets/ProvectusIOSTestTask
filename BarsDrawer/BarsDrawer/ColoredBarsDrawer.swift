//
//  ColoredBarsDrawer.swift
//  BarsDrawer
//
//  Created by Viktoria on 6/28/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import Foundation
import  UIKit

class ColoredBarsDrawer{
    let _viewController: UIViewController
    let _imageView: UIImageView
    var _barSize: Int = 0
    init(viewController: UIViewController, imageView: UIImageView, barSize: Int){
        _viewController = viewController
        _imageView = imageView
        _barSize = barSize
    }
    func draw(colors: Array<Array<UIColor>>){
        var x = 50
        var y = 50
        for color in colors {
            for element in color {
                let color = element
                
                
                drawRectFrom(fromPoint: CGPoint(x: x, y: y), toPoint: CGPoint(x: _barSize, y: _barSize), color: color)
                x += _barSize
            }
            y += _barSize
            x = 50
        }
        //
    }
    func drawRectFrom(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor) {
        
        UIGraphicsBeginImageContext(_viewController.view.frame.size) // created grafic context and set size = view.frame
        let context = UIGraphicsGetCurrentContext() // reterns reference to the current graphics context
        let rect = CGRect(x: fromPoint.x, y: fromPoint.y, width: toPoint.x, height: toPoint.y) //rect
        _imageView.image?.draw(in: CGRect(x: 0, y: 0, width: _viewController.view.frame.size.width, height: _viewController.view.frame.size.height))// point borders where posible to drawing
        context?.addRects([rect])
        context?.setFillColor(color.cgColor)
        // 4
        context?.fillPath()
        // 5
        _imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
    }
    
    
    
}

