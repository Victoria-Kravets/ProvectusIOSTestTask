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
    
    init(viewController: UIViewController, imageView: UIImageView, barSize: Int, image: UIImage){
            _viewController = viewController
            _imageView = imageView
        
            
            UIGraphicsBeginImageContext(_viewController.view.frame.size) // created grafic context and set size = view.frame
            //context = getContext(image: image)
            context = UIGraphicsGetCurrentContext() // reterns reference to the current graphics context
            _imageView.image?.draw(in: CGRect(x: 0, y: 0, width: _viewController.view.frame.size.width, height: _viewController.view.frame.size.height))// point borders where posible to drawing
            
            _barSize = barSize
        }
    func getContext(image: UIImage) -> CGContext {
        let width = image.size.width
        let height = image.size.height
        let size = width * height
        let dataSize = width * height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(width),
                                height: Int(height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        let cgImage = image.cgImage
        context?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
      

            return context!
    }
    
    func draw(colorsRows: Array<Array<Array<UInt8>>>) -> UIImageView{
        var x = 0
        var y = 0
        var arrayColorOfDigit = [UInt8]()
        arrayColorOfDigit.removeAll()
        for row in colorsRows {
            for barColor in row {
                let rect = CGRect(x: x, y: y, width: 10, height: 10) //rect
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
    
    func drawRectFrom(x: Int, y: Int, width: Int, height: Int, color: Array<UInt8>) {
    
    }

//        func draw(colorsRows: Array<Array<Array<UInt8>>>) -> UIImageView{
//            var x = 0
//            var y = 0
//            var arrayColorOfDigit = [UInt8]()
//            arrayColorOfDigit.removeAll()
//            for row in colorsRows {
//                for barColor in row {
//                    drawRectFrom(x: x, y: y, width: _barSize, height: _barSize, color: barColor)
//                    x += _barSize
//                }
//                y += _barSize
//                x = 0
//            }
//            _imageView.image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return _imageView
//        }
//    
//        func drawRectFrom(x: Int, y: Int, width: Int, height: Int, color: Array<UInt8>) {
//            let rect = CGRect(x: x, y: y, width: width, height: height) //rect
//            context.setFillColor(red: CGFloat(color[0]), green: CGFloat(color[1]), blue: CGFloat(color[2]), alpha: CGFloat(color[3]))
//            context.fill([rect])
//
//        }

}
