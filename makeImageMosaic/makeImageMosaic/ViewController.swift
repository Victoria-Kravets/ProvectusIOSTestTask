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

        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(100.0), width: CGFloat(300.0), height: CGFloat(100.0))
        let cropImage: CGImage? = originalImage.cgImage?.cropping(to: rect)

        let data = pixelData(image: UIImage(cgImage: cropImage!))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pixelData(image: UIImage) -> Array<UIColor> {
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
       
        
        var arrayOfColors = [UIColor]()
        var arrayOfColor = [UInt8]()
        arrayOfColor.removeAll()
        for item in pixelData {
            if arrayOfColors.isEmpty && arrayOfColor.isEmpty{
                arrayOfColor.append(UInt8(item))
            }else{
                if arrayOfColor.count == 4{
                    let color = UIColor(red: CGFloat(arrayOfColor[0]), green: CGFloat(arrayOfColor[1]), blue: CGFloat(arrayOfColor[2]), alpha: CGFloat(arrayOfColor[3]) / 255)
                    arrayOfColors.append(color)
                    arrayOfColor.removeAll()
                    arrayOfColor.append(UInt8(item))
                }
                else{
                    arrayOfColor.append(UInt8(item))
                }
            }
        }
        let color = UIColor(red: CGFloat(arrayOfColor[0]), green: CGFloat(arrayOfColor[1]), blue: CGFloat(arrayOfColor[2]), alpha: CGFloat(arrayOfColor[3]) / 255)
        arrayOfColors.append(color)
        let prevailColor = findPrevailColor(arrayOfColors: arrayOfColors)
        let vc = UIViewController()
        let makeMosaica = MakeMosaic(viewController: vc, imageView: imageView, barSize: 100)
        let drawBar = makeMosaica.drawRectFrom(fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 100, y: 100), color: prevailColor)
        
        //contex
//        let outputCGImage = context?.makeImage()!
//        let outputImage = UIImage(cgImage: outputCGImage!, scale: image.scale, orientation: image.imageOrientation)
        //imageView.image = outputImage
        
       
        //let cgImage = image.cgImage
       // context?.draw(outputCGImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
      return arrayOfColors
    }
    func findPrevailColor(arrayOfColors: Array<UIColor>) -> UIColor{
        var dictionaryOfColor = [UIColor: Int]()
        for color in arrayOfColors {
            if !dictionaryOfColor.isEmpty{
                for element in dictionaryOfColor {
                    if element.key == color{
                        dictionaryOfColor.updateValue(element.value + 1 , forKey: element.key)
                    }
                    else{
                        dictionaryOfColor[color] = 1
                    }
                }
            }else{
                dictionaryOfColor[color] = 1
            }
            
            
        }
        var resultColor = dictionaryOfColor.first
        
        for element in dictionaryOfColor {
            if element.value > (resultColor?.value)! {
                resultColor = element
            }
        }
        
        return (resultColor?.key)!
    }

}
