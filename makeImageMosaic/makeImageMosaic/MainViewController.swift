//
//  MainViewController.swift
//  makeImageMosaic
//
//  Created by Viktoria on 7/4/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {
    let arrayOfBarSize = [2, 5, 10, 20]
    var size = 2
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.returnKeyType = UIReturnKeyType.done
        textField.resignFirstResponder()
        pickerView.delegate = self
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Show Image" {
            if let vc = segue.destination as? ViewController{
                vc.url = textField.text!
                vc.barSize = size
                
            }
        }
        if segue.identifier == "Show example 1" {
            if let vc = segue.destination as? ViewController{
                vc.url = "http://crosti.ru/patterns/00/03/f5/94338116ed/picture.jpg"
                vc.barSize = size
                
            }
        }
        if segue.identifier == "Show example 2" {
            if let vc = segue.destination as? ViewController{
                vc.url = "http://ru.wikifur.com/w/images/7/76/%D0%9D%D1%83%2C_%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B8%21_05.avi_000745.219.png"
               vc.barSize = size
                
            }
        }
        if segue.identifier == "Show example 3" {
            if let vc = segue.destination as? ViewController{
                vc.url = "http://duck-tales.com/file/galereya/foto-i-kartinki-skrudzh-makdak/DGVsua763vo.jpg"
                vc.barSize = size
                
            }
        }
    }
    
}
