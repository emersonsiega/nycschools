//
//  SchoolsViewModel.swift
//  NYCSchools
//
//  Created by emersonsiega on 10/08/23.
//

import Foundation
import Combine

class SchoolsViewModel {
    private let apiService: SchoolAPILogic
    
    @Published private(set) var schools: [School] = []
    @Published private(set) var error: DataError? = nil
    
    init(apiService: SchoolAPILogic = SchoolAPI()) {
        self.apiService = apiService
    }
    
    func getSchools() {
        apiService.getSchools { [weak self] result in
            switch result {
            case .success(let schools):
                self?.schools = schools ?? []
            
            case .failure(let error):
                self?.error = error
            }
        }
    }
}
