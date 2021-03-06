//
//  ColoredBarsDrawer.swift
//  BarsDrawer
//
//  Created by Viktoria on 6/28/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import Foundation
import  UIKit

public class ColoredBarsDrawer{
    public let _viewController: UIViewController
    public let _imageView: UIImageView
    public var _barSize: Int = 0
    public init(viewController: UIViewController, imageView: UIImageView, barSize: Int){
        _viewController = viewController
        _imageView = imageView
        _barSize = barSize
    }
    public func draw(colors: Array<Array<UIColor>>) -> UIImageView{
        var x = 0
        var y = 0
        for color in colors {
            for element in color {
                let color = element
                
                
                drawRectFrom(fromPoint: CGPoint(x: x, y: y), toPoint: CGPoint(x: _barSize, y: _barSize), color: color)
                x += _barSize
            }
            y += _barSize
            x = 0
        }
        return _imageView
    }
    public func drawRectFrom(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor) {
        
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
//    func draw(colors: Array<Array<UIColor>>, width: Int, height: Int) -> UIImageView{
//        var x = 0
//        var y = 0
//        var widthCurrent = width
//        while height > 0{
//            while width > 0 {
//                for color in colors {
//                    for element in color {
//                        let color = element
//                        
//                        
//                        drawRectFrom(fromPoint: CGPoint(x: x, y: y), toPoint: CGPoint(x: _barSize, y: _barSize), color: color)
//                        x += _barSize
//                    }
//                    y += _barSize
//                    x = 0
//                }
//                widthCurrent -= 1
//            }
//            widthCurrent = width
//        }
//        return _imageView
//
//    }

    
    
    
}

