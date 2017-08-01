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
class ImageDataFromInternet {
    func getImage(urlName: String, onComplete: @escaping (_ data: Data)->Void, onError: @escaping (_ massage: String)->Void) {
        Alamofire.request(urlName)
            .responseData(queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        onComplete(data)
                    }
                case .failure:
                    let massage = "failure"
                    onError(massage)
                }
            })

    }
}
