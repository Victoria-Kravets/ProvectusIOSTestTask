//
//  makeImageMosaicTests.swift
//  makeImageMosaicTests
//
//  Created by Viktoria on 6/29/17.
//  Copyright © 2017 Viktoria. All rights reserved.
//

import XCTest
@testable import makeImageMosaic

class MakeImageMosaicTests: XCTestCase {
    let viewController = ViewController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let arrayOfColors: [[UInt8]] = [
            [255, 0, 0, 255],
            [0, 0, 0, 255],
            [255, 0, 0, 255],
            [0, 0, 0, 255],
            [255, 0, 0, 255]

        ]
        let checkingColor: [UInt8] = [255, 0, 0, 255]
        let resultColor = viewController.findPrevailColor(arrayOfColors: arrayOfColors)
        XCTAssertEqual(checkingColor, resultColor)
    }
    func testExampleCheck2() {
        let arrayOfColors: [[UInt8]] = [
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
        let checkingColor: [UInt8] = [0, 0, 0, 255]
        let resultColor = viewController.findPrevailColor(arrayOfColors: arrayOfColors)
        XCTAssertEqual(checkingColor, resultColor)
    }
    func testExampleCheck3() {
        let arrayOfColors: [[UInt8]] = [
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
        let checkingColor: [UInt8] = [0, 0, 255, 255]
        let resultColor = viewController.findPrevailColor(arrayOfColors: arrayOfColors)
        XCTAssertEqual(checkingColor, resultColor)
    }
    func testExampleCheck4() {
        let arrayOfColors: [[UInt8]] = [
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
        let checkingColor: [UInt8] = [0, 0, 255, 255]
        let resultColor = viewController.findPrevailColor(arrayOfColors: arrayOfColors)
        XCTAssertEqual(checkingColor, resultColor)
    }

}
