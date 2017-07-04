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
    
    
    }
    

}
