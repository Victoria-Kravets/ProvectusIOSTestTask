//
//  MainViewController.swift
//  makeImageMosaic
//
//  Created by Viktoria on 7/4/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import UIKit
import AssetsLibrary.ALAssetsLibrary

class MainViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
    let arrayOfBarSize = [2, 5, 10, 20]
    var sizeOfBar: Int = 2
    var size: Int {
        get {
            return self.sizeOfBar
        }
        set(newValue) {
            self.sizeOfBar = newValue
        }
    }
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var makeMosaicBtn: UIButton!
    @IBOutlet weak var mosaic1Btn: UIButton!
    @IBOutlet weak var mosaic2Btn: UIButton!
    @IBOutlet weak var mosaic3Btn: UIButton!
    @IBOutlet weak var originalImg1Btn: UIButton!
    @IBOutlet weak var originalImg2Btn: UIButton!
    @IBOutlet weak var originalImg3Btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.done
        textField.resignFirstResponder()
        textField.placeholder = "http://i052.radikal.ru/1207/3a/c8d6e700445f.jpg"
        pickerView.delegate = self
        let borderedBtn = BorderedButton()
        borderedBtn.getBorderFoButton(button: makeMosaicBtn)
        borderedBtn.getBorderFoButton(button: mosaic1Btn)
        borderedBtn.getBorderFoButton(button: mosaic2Btn)
        borderedBtn.getBorderFoButton(button: mosaic3Btn)
        borderedBtn.getBorderFoButton(button: originalImg1Btn)
        borderedBtn.getBorderFoButton(button: originalImg2Btn)
        borderedBtn.getBorderFoButton(button: originalImg3Btn)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        textField.text = ""
    }
}
extension MainViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(arrayOfBarSize[row])
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfBarSize.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch arrayOfBarSize[row] {
        case 2:
            size = 2
        case 5:
            size = 5
        case 10:
            size = 10
        case 20:
            size = 20
        default:
            size = 2
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Image" {
            let vc = segue.destination as? ViewController
            vc?.url = textField.text!
            vc?.barSize = size
        }
        if segue.identifier == "Show mosaic 1" {
            let vc = segue.destination as? ViewController
            vc?.url = "http://crosti.ru/patterns/00/03/f5/94338116ed/picture.jpg"
            vc?.barSize = size
        }
        if segue.identifier == "Show mosaic 2" {
            let vc = segue.destination as? ViewController
            vc?.url = "https://www.quizz.biz/uploads/quizz/1001087/1_E7rr7.jpg"
            vc?.barSize = size
        }
        if segue.identifier == "Show mosaic 3" {
            let vc = segue.destination as? ViewController
            vc?.url = "http://duck-tales.com/file/galereya/foto-i-kartinki-skrudzh-makdak/DGVsua763vo.jpg"
            vc?.barSize = size
        }
        if segue.identifier == "Show original image 1" {
            let vc = segue.destination as? ViewController
            vc?.url = "http://crosti.ru/patterns/00/03/f5/94338116ed/picture.jpg"
        }
        if segue.identifier == "Show original image 2" {
            let vc = segue.destination as? ViewController
            vc?.url = "https://www.quizz.biz/uploads/quizz/1001087/1_E7rr7.jpg"
        }
        if segue.identifier == "Show original image 3" {
            let vc = segue.destination as? ViewController
            vc?.url = "http://duck-tales.com/file/galereya/foto-i-kartinki-skrudzh-makdak/DGVsua763vo.jpg"
        }
    }
}
