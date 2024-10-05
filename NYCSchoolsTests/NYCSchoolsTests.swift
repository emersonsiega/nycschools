//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by emersonsiega on 06/08/23.
//

import XCTest
@testable import NYCSchools

final class NYCSchoolsTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGettingSchoolsWithMockEmptyResult() throws {
        let expectation = expectation(description: "testing empty mock api")
        
        let mock = MockSchoolAPI()
        mock.loadState = .empty
        
        let sut = SchoolsViewModel(apiService: mock)
        sut.getSchools { schools, error in
            XCTAssertTrue(schools?.isEmpty == true, "Expected schools to be empty, but received some values")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
    
    func testGettingSchoolsWithErrorResult() {
        let expectation = expectation(description: "testing error mock api")
        
        let mock = MockSchoolAPI()
        mock.loadState = .error
        
        let sut = SchoolsViewModel(apiService: mock)
        sut.getSchools { schools, error in
            XCTAssertTrue(schools == nil, "Expected to get no schools and error, but received schools")
            XCTAssertNotNil(error, "Expected tÏo get an error, but received no error")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
    
    func testGettingSchoolsWithSuccessResult() {
        let expectation = expectation(description: "testing success mock api")
        
        let mock = MockSchoolAPI()
        mock.loadState = .loaded
        
        let sut = SchoolsViewModel(apiService: mock)
        sut.getSchools { school, error in
            XCTAssertNil(error, "Expected no errors, bug received some error")
            XCTAssertTrue(school?.isEmpty == false, "Expected to receive schools, but received no schools")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
