//
//  NYTArticleAppTests.swift
//  NYTArticleAppTests
//
//  Created by Aneesh on 01/09/2021.
//

import XCTest
@testable import NYTArticleApp

class NYTArticleAppTests: XCTestCase {
    let articleService = ArticlesService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      //  testParsResponse(period: .Day)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    //Tested and parsed success
    func testGetArticleAPI() {
        let expectation = self.expectation(description: "Testing Articles API get list - period  - Day")
        HttpRequestHelper().request(url: Constant.API.baseURL + Constant.Endpoint.mostpopular + "\(Periods.Day.rawValue).json",method:.GET,params: ["api-key": Constant.API.apiKey], httpHeader: .application_json) { result in
            switch result {
            case .failure(let error):
                XCTFail("Response failed due to \(error.localizedDescription)")
            case .success(let data):
                    do {
                        let model = try JSONDecoder().decode(ArticlesResponse.self, from: data)
                        XCTAssertNotNil(model)
                        expectation.fulfill()
                    } catch {
                        XCTFail(Constant.ErrorMessage.parseError)
                        
                    }
                }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
