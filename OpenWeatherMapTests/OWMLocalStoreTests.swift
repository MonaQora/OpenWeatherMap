//
//  OWMLocalStoreTests.swift
//  OpenWeatherMapTests
//
//  Created by Mona Qora on 12/27/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import XCTest
@testable import OpenWeatherMap

class OWMLocalStoreTests: XCTestCase {

    private var testModel: TestModel!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testModel = TestModel.init(fName: "Mona", sName: "Qora", number: 00201226110260, identefier: 27288)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        testModel = nil
    }

    func testStoreDataFailWrongModel() {
        let expectation = XCTestExpectation(description: "Fail load data, wrong model type passed")

        let key = "test2"
        LocalStore.storeDataLocally(key: key, dataModel: testModel)
        let storedData: TestModelFail? = LocalStore.loadDataStored(key: key)
        expectation.fulfill()

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNil(storedData)
        
        LocalStore.deleteStoredData(key: key)
    }
    
    func testStoreDataSucess() {
        let expectation = XCTestExpectation(description: "Sucess load data")

        let key = "test2"
        LocalStore.storeDataLocally(key: key, dataModel: testModel)
        let storedData: TestModel = LocalStore.loadDataStored(key: key)!
        expectation.fulfill()

        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(storedData)
        XCTAssertEqual(storedData.fName, "Mona")
        XCTAssertEqual(storedData.sName, "Qora")
        XCTAssertEqual(storedData.number, 00201226110260)
        XCTAssertEqual(storedData.identefier, 27288)

        LocalStore.deleteStoredData(key: key)
    }
    
}

//Mock struct for testing
private struct TestModel:Codable {
    let fName:String
    let sName:String
    let number:Int
    let identefier:Int
}

private struct TestModelFail:Codable {
    let firstName:String
    let familyName:String
    let number:Int
    let identefier:Int
}
