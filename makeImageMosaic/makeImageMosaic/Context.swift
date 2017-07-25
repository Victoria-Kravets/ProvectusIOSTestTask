//
//  GetContext.swift
//  makeImageMosaic
//
//  Created by Viktoria on 7/3/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import Foundation
import  UIKit
class Context{
    
    func getContext(image: UIImage) -> (CGContext, Array<UInt8> ){
        let width = image.size.width
        let height = image.size.height
        let dataSize = width * height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(width),
                                height: Int(height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)!
        let cgImage = image.cgImage!
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        return (context, pixelData)
    }

}
