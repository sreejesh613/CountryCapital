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
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var error: CountryFetchError?
    private var hasFetched = false
    let networkService = NetworkService()
    
    var filteredCountries: [Country] {
        guard !searchText.isEmpty else { return allContries }
        return allContries.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
    }
    
    struct CountryFetchError: Identifiable {
        var id: UUID = UUID()
        var message: String
        
    }
    
    func getAllCountries() {
        guard !hasFetched else { return }
        hasFetched = true

        isLoading = true
        networkService.fetchCountries { data, error in
            if let error = error {
                print("Error: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.error = CountryFetchError(message: error.localizedDescription)
                }
                return
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self.isLoading = false
                self.allContries = data
            }
        }
    }
    
    func addToMainCountry(country: Country) {
        guard mainCountries.count < 5 else { return }
        mainCountries.append(country)
    }
    
    func removeFromMainCountries(country: Country) {
        guard let index = mainCountries.firstIndex(where: { $0.name == country.name }) else { return }
        mainCountries.remove(at: index)
    }
}
