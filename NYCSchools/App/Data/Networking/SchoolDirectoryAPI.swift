//
//  SchoolDirectoryAPI.swift
//  NYCSchools
//
//  Created by emersonsiega on 06/08/23.
//

import Foundation
import Alamofire

/// Get schools default response type
typealias SchoolListAPIResponse = (Swift.Result<[School]?, DataError>) -> Void

protocol SchoolAPILogic {
    /// Get schools data from API
    func getSchools(completion: @escaping(SchoolListAPIResponse))
}

class SchoolAPI: SchoolAPILogic {
    private struct Constants {
        static let schoolListUrl =  "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=L1KwLSwm1yz1N7aWqFCF4dLmM"
    }
        
    func getSchools(completion: @escaping(SchoolListAPIResponse)) {
        //retrieveSchoolsUsingStandardServices()
     
        AF.request(Constants.schoolListUrl)
            .validate()
            .responseDecodable(of: [School].self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkingError(error.localizedDescription)))
                case .success(let schools):
                    completion(.success(schools))
                }
            }
    }
    
    private func retrieveSchoolsUsingStandardServices() {
        /*
        // Create url using URLComponents
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "data.cityofnewyork.us"
        urlComponents.path = "resource/s3k6-pzi2.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "$$app_token", value: "L1KwLSwm1yz1N7aWqFCF4dLmM")
        ]

        if let url = urlComponents.url {
          // Do something
        }
        */
        
        if let url = URL(string: Constants.schoolListUrl) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print("Error occured \(error!.localizedDescription)")
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let schools = try decoder.decode([School].self, from: data)
                        print("schools: \(schools)")
                    } catch let error {
                        print("Error during parsing \(error)")
                    }
                }
            }
            
            task.resume()
        }
    }
}
