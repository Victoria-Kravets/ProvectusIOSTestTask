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
    let originalImage = UIImage(named: "copy1.png")!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(100.0), width: CGFloat(150.0), height: CGFloat(100.0))
        let cropImage: CGImage? = originalImage.cgImage?.cropping(to: rect)

        let data = pixelData(image: UIImage(cgImage: cropImage!))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pixelData(image: UIImage)  {
        
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
        let vc = UIViewController()
        let makeMosaica = MakeMosaic(viewController: vc, imageView: imageView, barSize: 100)
        let drawBar = makeMosaica.drawRectFrom(fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: width, y: height), color: prevailColor)
        
        //contex
//        let outputCGImage = context?.makeImage()!
//        let outputImage = UIImage(cgImage: outputCGImage!, scale: image.scale, orientation: image.imageOrientation)
        //imageView.image = outputImage
        
    }
    func findPrevailColor(arrayOfColors: Array<Array<UInt8>>) -> UIColor{
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
        var resultColor = UIColor()
        for element in dictionaryOfColor {
            if element.value > (resultColorString?.value)! {
                resultColorString = element
            }
        }
        var arrayOfDigitColor = [Int]()
        var resultStr: String = (resultColorString?.key)!
        var str = ""
        for char in resultStr.characters {
            if char != "+"{
            str.append(String(char))
            }else{
                arrayOfDigitColor.append(Int(str)!)
                str = ""
            }
        }
         arrayOfDigitColor.append(Int(str)!)
        resultColor = UIColor(red: CGFloat(arrayOfDigitColor[0]), green: CGFloat(arrayOfDigitColor[1]), blue: CGFloat(arrayOfDigitColor[2]), alpha: CGFloat(arrayOfDigitColor[3]))
        return resultColor
    }

}
