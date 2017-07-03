//
//  ViewController.swift
//  makeImageMosaic
//
//  Created by Viktoria on 6/29/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import UIKit
import BarsDrawer

class ViewController: UIViewController {
    let originalImage = UIImage(named: "Tom.png")!
    //let originalImage = UIImage(named: "copy2.png")!
    //var contextData: Array<UInt8> = []
    var count = 0
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let arr : Array<Array<Array<UInt8>>> =
//        [
//        [[205, 254, 206, 255], [32, 24, 206, 255],[205, 254, 206, 255],[32, 24, 206, 255]],
//        [[32, 24, 206, 255],[205, 254, 206, 255],[32, 24, 206, 255],[205, 254, 206, 255]],
//        [[205, 254, 206, 255], [32, 24, 206, 255],[205, 254, 206, 255],[32, 24, 206, 255]],
//        [[32, 24, 206, 255],[205, 254, 206, 255],[32, 24, 206, 255],[205, 254, 206, 255]]
//        ]
        let arrayOfColors = getArrayOfColors(image: originalImage)
        //let mostCommonColor = getMostCommonColorAmongBars(arrayOfColors: arrayOfColors)
        let vc = UIViewController()
        let makeMosaica = MakeMosaic(viewController: vc, imageView: imageView, barSize: 10, image: originalImage)
        let drawBar = makeMosaica.draw(colorsRows: arrayOfColors)

        
        
    }
//    func getMostCommonColorAmongBars(arrayOfColors:  Array<Array<Array<UInt8>>>)-> Array<UInt8>{
//        var resultArray = [[UInt8]()]
//        resultArray.removeAll()
//        for color in arrayOfColors {
//            for element in color{
//                resultArray.append(element)
//            }
//            
//        }
//        let mostCommonColor = findPrevailColor(arrayOfColors: resultArray)
//        return mostCommonColor
//    }
    func getArrayOfColors(image: UIImage) -> Array<Array<Array<UInt8>>>{
        let size = image.size
        var height = size.height
        var width = size.width
        var sizePath: CGFloat = 10
        var x: CGFloat = 0
        var y: CGFloat = 0
        var arrayOfOneColor = [[UInt8]()]
        var arrayOfColors = [[[UInt8]()]]
        arrayOfColors.removeAll()
        arrayOfOneColor.removeAll()
        while height > 0 {
            while width > 0 {
                let rect = CGRect(x: x, y: y, width: sizePath, height: sizePath)
                let cropImage: CGImage? = originalImage.cgImage?.cropping(to: rect)
                let contextOfOneBar = getContext(image: UIImage(cgImage: cropImage!))
                let colorData = pixelData(pixelData: contextOfOneBar)
                arrayOfOneColor.append(colorData)
                sizePath = 10
                if width >= 10 {
                    width -= sizePath
                }else{
                    sizePath = width
                    width -= width
                }
                x += sizePath
            }
            arrayOfColors.append(arrayOfOneColor)
            arrayOfOneColor.removeAll()
            sizePath = 10
            if height >= 10 {
                height -= sizePath
            }else{
                sizePath = height
                height -= height
            }
            y += sizePath
            x = 0
            width = size.width
        }
        
      return arrayOfColors
    }
    
    func getContext(image: UIImage) ->Array<UInt8> {
        let width = Int(image.size.width)
        let height = Int(image.size.height)
        let size = width * height
        let dataSize = width * height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * width,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        let cgImage = image.cgImage
        context?.draw(cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        return pixelData
    }
    func pixelData( pixelData: Array<UInt8>) -> Array<UInt8>  {
        
        
        var arrayOfColors = [[UInt8]()]
        var arrayOfColor = [UInt8]()
        arrayOfColor.removeAll()
        arrayOfColors.removeAll()
        for item in pixelData {
            if arrayOfColors.isEmpty && arrayOfColor.isEmpty{
                arrayOfColor.append(UInt8(item))
            }else{
                if arrayOfColor.count == 4{
                    
                    arrayOfColors.append(arrayOfColor)
                    arrayOfColor.removeAll()
                    arrayOfColor.append(UInt8(item))
                }
                else{
                   arrayOfColor.append(UInt8(item))
                }
            }
        }
        arrayOfColors.append(arrayOfColor)
        let prevailColor = findPrevailColor(arrayOfColors: arrayOfColors)
        
        
        
//        let drawer = ColoredBarsDrawer(viewController: vc, imageView: imageView, barSize: 10)
//        let drawBar = drawer.drawRectFrom(fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: width, y: height), color: prevailColor)
        //contex
//        let outputCGImage = context?.makeImage()!
//        let outputImage = UIImage(cgImage: outputCGImage!, scale: image.scale, orientation: image.imageOrientation)
        //imageView.image = outputImage
       return prevailColor
    }
    func findPrevailColor(arrayOfColors: Array<Array<UInt8>>) -> Array<UInt8>{
        var dictionaryOfColor = [String : Int]()
        var arrayOfStringColor = [String]()
        var colorStrValue = ""
        for color in arrayOfColors {
            colorStrValue.append(String(color[0]) + "+")
            colorStrValue.append(String(color[1]) + "+")
            colorStrValue.append(String(color[2]) + "+")
            colorStrValue.append(String(color[3]))
            arrayOfStringColor.append(colorStrValue)
            colorStrValue = ""
        }
        
        
        for color in arrayOfStringColor {
            if !dictionaryOfColor.isEmpty{
                for element in dictionaryOfColor {
                    if element.key == color{
                        dictionaryOfColor.updateValue(element.value + 1 , forKey: element.key)
                    }
                    else{
                        if dictionaryOfColor[color] == nil {
                            dictionaryOfColor[color] = 1
                        }
                    }
                }
            }else{
                dictionaryOfColor[color] = 1
            }
            
            
        }
        var resultColorString = dictionaryOfColor.first
        
        for element in dictionaryOfColor {
            if element.value > (resultColorString?.value)! {
                resultColorString = element
            }
        }
        var arrayOfDigitColor = [UInt8]()
        var resultStr: String = (resultColorString?.key)!
        var str = ""
        for char in resultStr.characters {
            if char != "+"{
            str.append(String(char))
            }else{
                arrayOfDigitColor.append(UInt8(str)!)
                str = ""
            }
        }
         arrayOfDigitColor.append(UInt8(str)!)
//        resultColor = UIColor(red: CGFloat(arrayOfDigitColor[0]), green: CGFloat(arrayOfDigitColor[1]), blue: CGFloat(arrayOfDigitColor[2]), alpha: CGFloat(arrayOfDigitColor[3]))
        count += 1
        return arrayOfDigitColor
    }

}
