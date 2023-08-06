//
//  SchoolDirectoryAPI.swift
//  NYCSchools
//
//  Created by emersonsiega on 06/08/23.
//

import Foundation

protocol SchoolAPILogic {
    /// Get schools data from API
    func getSchools()
}

class SchoolAPI: SchoolAPILogic {
    private struct Constants {
        static let schoolListUrl =  "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=L1KwLSwm1yz1N7aWqFCF4dLmM"
    }
        
    func getSchools() {
        print("Implement getSchools! \(Constants.schoolListUrl)")
    }
}
