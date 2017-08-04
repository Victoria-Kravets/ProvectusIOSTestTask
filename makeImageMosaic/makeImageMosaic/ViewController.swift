//
//  ViewController.swift
//  makeImageMosaic
//
//  Created by Viktoria on 6/29/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import UIKit
import PromiseKit
class ViewController: UIViewController, UIScrollViewDelegate, UINavigationBarDelegate {
    var url = ""
    let context = Context()
    let downloadedImage = ImageDataFromInternet()
    var image = UIImage()
    var barSize = 0
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.maximumZoomScale = 4.0
            scrollView.minimumZoomScale = 0.05
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activity.startAnimating()
        scrollView.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        func updateUI(data: Data?) {
            if data != nil {
                self.image = UIImage(data: data!)!
                if self.barSize == 0 {
                    self.imageView.image = self.image
                } else {
                    let arrayOfColors = self.getArrayOfColors(image: self.image)
                    let makeMosaica = MosaicMaker(sizeOfBar: self.barSize, image: self.image)
                    let drawBar = makeMosaica.draw(colorsRows: arrayOfColors)
                    self.imageView.image = drawBar
                    self.activity.stopAnimating()
                }
            } else {
                let message = "Sorry...something gone wrong, please enter valid URL and check internet connection"
                self.createAlert(title: "Warning!", massage: message)
                print(Thread.isMainThread)
            }
        }
        downloadedImage.getImage(urlName: url).then { data in
            updateUI(data: data)
            }.catch {_ in
                print("Error")
        }
    }
    func createAlert(title: String, massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertControllerStyle.alert)
        let style = UIAlertActionStyle.default
        alert.addAction(UIAlertAction(title: "OK", style: style, handler: { (_) in self.navigationController?.popViewController(animated: true)}))
        self.present(alert, animated: true, completion: nil)
    }
    func getArrayOfColors(image: UIImage) -> [[[UInt8]]] {
        let size = image.size
        var height = size.height
        var width = size.width
        var sizePath: CGFloat = CGFloat(barSize)
        var x: CGFloat = 0
        var y: CGFloat = 0
        var arrayOfOneColor = [[UInt8]]()
        var arrayOfColors = [[[UInt8]]]()
        while height > 0 {
            while width > 0 {
                let rect = CGRect(x: x, y: y, width: sizePath, height: sizePath)
                let cropImage: CGImage = image.cgImage!.cropping(to: rect)!
                let contextOfOneBar = context.getContext(image: UIImage(cgImage: cropImage))
                let colorData = transformPixelDataToColors(pixelData: contextOfOneBar.1)
                arrayOfOneColor.append(colorData)
                sizePath = CGFloat(barSize)
                if width >= CGFloat(barSize) {
                    width -= sizePath
                } else {
                    sizePath = width
                    width -= width
                }
                x += sizePath
            }
            arrayOfColors.append(arrayOfOneColor)
            arrayOfOneColor.removeAll()
            sizePath = CGFloat(barSize)
            if height >= CGFloat(barSize) {
                height -= sizePath
            } else {
                sizePath = height
                height -= height
            }
            y += sizePath
            x = 0
            width = size.width
        }
        return arrayOfColors
    }
    func transformPixelDataToColors( pixelData: [UInt8]) -> [UInt8] {
        var arrayOfColors = [[UInt8]]()
        var arrayOfColor = [UInt8]()
        for item in pixelData {
            if arrayOfColors.isEmpty && arrayOfColor.isEmpty {
                arrayOfColor.append(UInt8(item))
            } else {
                if arrayOfColor.count == 4 {
                    arrayOfColors.append(arrayOfColor)
                    arrayOfColor.removeAll()
                    arrayOfColor.append(UInt8(item))
                } else {
                    arrayOfColor.append(UInt8(item))
                }
            }
        }
        arrayOfColors.append(arrayOfColor)
        let prevailColor = findPrevailColor(arrayOfColors: arrayOfColors)
        return prevailColor
    }
    func findPrevailColor(arrayOfColors: [[UInt8]]) -> [UInt8] {
        var dictionaryOfColor = [String: Int]()
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
            if !dictionaryOfColor.isEmpty {
                for element in dictionaryOfColor {
                    if element.key == color {
                        dictionaryOfColor.updateValue(element.value + 1, forKey: element.key)
                    } else {
                        if dictionaryOfColor[color] == nil {
                            dictionaryOfColor[color] = 1
                        }
                    }
                }
            } else {
                dictionaryOfColor[color] = 1
            }
        }
        var resultColorString = dictionaryOfColor.first
        for element in dictionaryOfColor {
            while element.value > (resultColorString?.value)! {
                resultColorString = element
            }
        }
        var arrayOfDigitColor = [UInt8]()
        var resultStr: String = (resultColorString?.key)!
        var str = ""
        for char in resultStr.characters {
            if char != "+"{
                str.append(String(char))
            } else {
                arrayOfDigitColor.append(UInt8(str)!)
                str = ""
            }
        }
        arrayOfDigitColor.append(UInt8(str)!)
        return arrayOfDigitColor
    }
}
struct ExecuteError: Error {
    var errorMessage: String
}
