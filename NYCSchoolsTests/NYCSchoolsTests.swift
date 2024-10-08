//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by emersonsiega on 06/08/23.
//

import XCTest
import Combine
@testable import NYCSchools

final class NYCSchoolsTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    override func setUp() async throws {
        try await super.setUp()
        
        cancellables.removeAll()
    }

    func testGettingSchoolsWithMockEmptyResult() throws {
        let expectation = expectation(description: "testing empty mock api")
        
        let mock = MockSchoolAPI()
        mock.loadState = .empty
        
        let sut = SchoolsViewModel(apiService: mock)
        sut.getSchools()
        
        sut.$schools
            .receive(on: RunLoop.main)
            .sink{ schools in
                XCTAssertTrue(schools.isEmpty == true, "Expected schools to be empty, but received some values")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
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
        sut.getSchools()
                
        sut.$error
            .receive(on: RunLoop.main)
            .sink { error in
                XCTAssertNotNil(error, "Expected to get an error, but received no error")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
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
        sut.getSchools()
        
        sut.$schools
            .receive(on: RunLoop.main)
            .sink{ schools in
                XCTAssertTrue(!schools.isEmpty, "Expected to receive schools, but received no schools")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
}
