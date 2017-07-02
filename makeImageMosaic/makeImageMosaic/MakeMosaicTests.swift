//
//  MakeMosaicTests.swift
//  makeImageMosaic
//
//  Created by Viktoria on 7/1/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import XCTest
@testable import makeImageMosaic
class MakeMosaicTests: XCTestCase {
    let vc = ViewController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let arrayOfColors: Array<Array<UInt8>> = [
            [255, 0, 0, 255],
            [0, 0, 0, 255],
            [255, 0, 0, 255],
            [0, 0, 0, 255],
            [255, 0, 0, 255]
        
        ]
        let checkingColor = UIColor(red: CGFloat(255), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(255))
        let resultColor = vc.findPrevailColor(arrayOfColors: arrayOfColors)
        XCTAssertEqual(checkingColor, resultColor)
    }
    func testExampleCheck2() {
        let arrayOfColors: Array<Array<UInt8>> = [
            [255, 0, 0, 255],
            [0, 0, 255, 255],
            [255, 0, 0, 255],
            [0, 0, 0, 255],
            [0, 0, 255, 255],
            [0, 0, 0, 255],
            [0, 0, 0, 255],
            [0, 3, 0, 255],
            [0, 0, 0, 255],
            [255, 0, 0, 255]
            
        ]
        let checkingColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(255))
        let resultColor = vc.findPrevailColor(arrayOfColors: arrayOfColors)
        XCTAssertEqual(checkingColor, resultColor)
    }
    func testExampleCheck3() {
        let arrayOfColors: Array<Array<UInt8>> = [
            [255, 0, 0, 255],
            [0, 0, 255, 255],
            [255, 0, 0, 255],
            [0, 0, 0, 255],
            [0, 0, 255, 255],
            [0, 0, 0, 255],
            [0, 0, 255, 255],
            [0, 3, 0, 255],
            [0, 0, 255, 255],
            [255, 0, 0, 255]
            
        ]
        let checkingColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(255), alpha: CGFloat(255))
        let resultColor = vc.findPrevailColor(arrayOfColors: arrayOfColors)
        XCTAssertEqual(checkingColor, resultColor)
    }
    func testExampleCheck4() {
        let arrayOfColors: Array<Array<UInt8>> = [
            [255, 0, 0, 255],
            [0, 0, 255, 255],
            [255, 0, 0, 255],
            [0, 0, 7, 255],
            [0, 0, 255, 255],
            [0, 0, 0, 255],
            [0, 0, 255, 255],
            [0, 3, 0, 255],
            [0, 0, 0, 255],
            [255, 0, 0, 255]
            
        ]
        let checkingColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(255), alpha: CGFloat(255))
        let resultColor = vc.findPrevailColor(arrayOfColors: arrayOfColors)
        XCTAssertEqual(checkingColor, resultColor)
    }

    
    
    
}
