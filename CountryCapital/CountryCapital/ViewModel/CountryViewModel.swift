//
//  CountryViewModel.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
import SwiftUI

class CountryViewModel: ObservableObject {
    @Published var allContries: [Country] = []
    @Published var mainCountries: [Country] = []
    @Published var filteredCountries: [Country] = []
    let networkService = NetworkService()
    
    func getAllCountries() {
        networkService.fetchCountries { data, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.allContries = data
            }
        }
    }
    
    func getFilteredCountries(filterParam: String) {
        filteredCountries = allContries.filter { $0.name.lowercased().hasPrefix(filterParam.lowercased()) }
    }
    
    func addCountry(country: Country) {
        guard mainCountries.count < 5 else { return }
        mainCountries.append(country)
    }
}
