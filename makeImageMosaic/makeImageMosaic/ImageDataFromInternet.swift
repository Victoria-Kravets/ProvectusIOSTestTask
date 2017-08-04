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
import PromiseKit
import AssetsLibrary.ALAssetsLibrary

struct ResponseError: Error {
    var errorMessage: String
}
class ImageDataFromInternet {
    func getImage(urlName: String) -> Promise<Data> {
        return Promise<Data> { fulfill, reject in
            DispatchQueue.global(qos: .utility).async {
                Alamofire.request(urlName)
                    .responseData(queue: DispatchQueue.global(qos: .utility), completionHandler: { response in
                        print(Thread.isMainThread)
                        if let data = response.result.value {
                            fulfill(data)
                        } else {
                            reject(ResponseError(errorMessage: "failure"))
                        }
                    })
            }
        }
    }
}
