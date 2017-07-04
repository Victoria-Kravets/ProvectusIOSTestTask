//
//  MainViewController.swift
//  makeImageMosaic
//
//  Created by Viktoria on 7/4/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func displayImage(_ sender: UIButton) {
//        let url = textField.text
//        let viewController = ViewController()
//        viewController.url = url!
        
        
        
    }
    func error(errorMessage: String){
    print(errorMessage)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Show Image" {
            if let vc = segue.destination as? ViewController{
                vc.url = textField.text!
                
            }
        }
        if segue.identifier == "Show example 1" {
            if let vc = segue.destination as? ViewController{
                vc.url = "http://crosti.ru/patterns/00/03/f5/94338116ed/picture.jpg"
                
            }
        }
        if segue.identifier == "Show example 2" {
            if let vc = segue.destination as? ViewController{
                vc.url = "http://ru.wikifur.com/w/images/7/76/%D0%9D%D1%83%2C_%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B8%21_05.avi_000745.219.png"
                
            }
        }
        if segue.identifier == "Show example 3" {
            if let vc = segue.destination as? ViewController{
                vc.url = "http://duck-tales.com/file/galereya/foto-i-kartinki-skrudzh-makdak/DGVsua763vo.jpg"
                
            }
        }
    
    
    }
    

}
