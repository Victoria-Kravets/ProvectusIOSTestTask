//
//  GetImageFromInternet.swift
//  makeImageMosaic
//
//  Created by Viktoria on 7/3/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import Foundation
import  Alamofire
import  UIKit
class GetImageFromInternet{
   var url = ""
    let utilityQueue = DispatchQueue.global(qos: .utility)
    func getImage(urlName: String, _ completed: @escaping (_ data: Data)->(), _ error: @escaping (_ massage: String)->()){
        var image = UIImage()
        url = urlName
        Alamofire.request(url)
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        completed(data)
                    }
                case .failure:
                    print("failure")
                    let massage = "failure"
                    error(massage)
                }
            }
        
    }
    
}
