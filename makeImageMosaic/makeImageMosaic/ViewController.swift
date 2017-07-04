//
//  ViewController.swift
//  makeImageMosaic
//
//  Created by Viktoria on 6/29/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import UIKit
import BarsDrawer

class ViewController: UIViewController, UIScrollViewDelegate, UINavigationBarDelegate {
    let originalImage = UIImage(named: "jerry.png")!
//    let urlExemple1 = "http://crosti.ru/patterns/00/03/f5/94338116ed/picture.jpg"
//    let urlExemple2 = "http://batona.net/uploads/posts/2016-01/1451909976_639.jpg"
//    let urlExemple3 = "http://shop.camellia.ua/upload/kamelia_flora/photos/be/c3/1200x1200/abf568f3_57ab004613cc5.jpg"
    var url = ""
    let context = GetContext()
    let downloadedImage = GetImageFromInternet()
    var image = UIImage()
    var barSize = 0
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = imageView.frame.size
            scrollView.maximumZoomScale = 2.0
            scrollView.minimumZoomScale = 0.05
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.startAnimating()
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        
        //fetchImage()
        let successHandler = { (data: Data)-> () in
            if data != nil{
                self.image = UIImage(data: data)!
                let sizz = self.image.size
                let sizzze = self.image.size
                let arrayOfColors = self.getArrayOfColors(image: self.image)
                let vc = UIViewController()
                let makeMosaica = MakeMosaic(viewController: vc, imageView: self.imageView, barSize: self.barSize, image: self.image)
                let drawBar = makeMosaica.draw(colorsRows: arrayOfColors)
                self.activity.stopAnimating()
            }
            
        }
        let errorHandler = { (massage: String)-> () in
            if massage == "failure"{
                let mainVC = MainViewController()
                mainVC.error(errorMessage: "Sorry...something gone wrong, please enter valid URL and check internet connection")
                self.createAlert(title: "Warning!", massage: "Sorry...something gone wrong, please enter valid URL and check internet connection")
                
            }
        }

        print(url)
        downloadedImage.getImage(urlName: url, successHandler, errorHandler)
        
        
    }

    func createAlert(title: String, massage: String){
//        let mainVC = MainViewController()
//        let vc = ViewController()
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)

        }))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
//    func fetchImage(){
//        DispatchQueue.global(qos: .userInitiated).async{
//            let successHandler = { (data: Data)-> () in
//                if data != nil{
//                    self.image = UIImage(data: data)!
//                    let arrayOfColors = self.getArrayOfColors(image: self.image)
//                    let vc = UIViewController()
//                    let makeMosaica = MakeMosaic(viewController: vc, imageView: self.imageView, barSize: 10, image: self.originalImage)
//                    let drawBar = makeMosaica.draw(colorsRows: arrayOfColors)
//                }
//                
//            }
//            let errorHandler = { (massage: String)-> () in
//                if massage == "error"{
//                    let mainVC = MainViewController()
//                    mainVC.error(errorMessage: "Sorry...something gone wrong, please enter valid URL and check internet connection")
//                    
//                }
//            }
//            
//            print(self.url)
//            self.downloadedImage.getImage(urlName: self.url, successHandler, errorHandler)
//            
//            DispatchQueue.main.async{
//                self.navigationItem.title = "Hello"
//                self.imageView.backgroundColor = UIColor.gray
//                
//            }
//        }
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//       fetchImage()
//
//    }
    
    func getMostCommonColorAmongBars(arrayOfColors:  Array<Array<Array<UInt8>>>)-> Array<UInt8>{
        var resultArray = [[UInt8]()]
        resultArray.removeAll()
        for color in arrayOfColors {
            for element in color{
                resultArray.append(element)
            }
            
        }
        let mostCommonColor = findPrevailColor(arrayOfColors: resultArray)
        return mostCommonColor
    }
    func getArrayOfColors(image: UIImage) -> Array<Array<Array<UInt8>>>{
        let size = image.size
        var height = size.height
        var width = size.width
        var sizePath: CGFloat = CGFloat(barSize)
        var x: CGFloat = 0
        var y: CGFloat = 0
        var arrayOfOneColor = [[UInt8]()]
        var arrayOfColors = [[[UInt8]()]]
        arrayOfColors.removeAll()
        arrayOfOneColor.removeAll()
        while height > 0 {
            while width > 0 {
                let rect = CGRect(x: x, y: y, width: sizePath, height: sizePath)
                let cropImage: CGImage? = image.cgImage?.cropping(to: rect)
                let contextOfOneBar = context.getContext(image: UIImage(cgImage: cropImage!))
                let colorData = pixelData(pixelData: contextOfOneBar.1 as! Array<UInt8>)
                arrayOfOneColor.append(colorData)
                sizePath = CGFloat(barSize)
                if width >= CGFloat(barSize) {
                    width -= sizePath
                }else{
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

        return arrayOfDigitColor
    }

}
