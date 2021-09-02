//
//  NYTArticleAppTests.swift
//  NYTArticleAppTests
//
//  Created by Aneesh on 01/09/2021.
//

import XCTest
@testable import NYTArticleApp

class NYTArticleAppTests: XCTestCase {
    let apiRequest = HttpRequestHelper()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    //Tested and parsed success
    func testParsResponse() {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "articles", ofType: "json") {
            if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) {
                let decoder = JSONDecoder()
                let jsonData = try? decoder.decode(ArticlesResponse.self, from: data)
                XCTAssertGreaterThan(jsonData!.articles?.count ?? 0, 0, "should have values")
            } else {
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }

}
