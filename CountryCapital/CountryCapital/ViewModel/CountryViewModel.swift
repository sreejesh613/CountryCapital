//
//  CountryViewModel.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
import SwiftUI

class CountryViewModel: ObservableObject {
    @Published var allCountries: [Country] = []
    @Published var mainCountries: [Country] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var error: CountryFetchError?
    private var hasFetched = false
    let networkService = NetworkService()
    let locationManager = LocationManager()
    
    var filteredCountries: [Country] {
        guard !searchText.isEmpty else { return allCountries }
        return allCountries.filter { $0.name.lowercased().hasPrefix(searchText.lowercased()) }
    }

    struct CountryFetchError: Identifiable {
        var id: UUID = UUID()
        var message: String
        
    }
    
    func handleDetectedCountryCode(_ countryCode: String?) {
        guard let code = countryCode else {
            useFallbackCountry()
            return
        }
        DispatchQueue.main.async {
            if let country = self.allCountries.first(where: { $0.alpha2Code == code }) {
                if !self.mainCountries.contains(where: { $0.alpha2Code == country.alpha2Code }) {
                    self.mainCountries.insert(country, at: 0)
                }
            } else {
                self.useFallbackCountry()
            }
        }
    }

    func detectUserCountry() {
        DispatchQueue.main.async {
            self.locationManager.onCountryDetected = { [weak self] countryName in
                guard let self = self else { return }

                if let country = allCountries.first(where: { $0.alpha2Code == countryName }) {
                    mainCountries.insert(country, at: 0)
                } else {
                    self.useFallbackCountry()
                }
            }
        }
    }
    
    func useFallbackCountry() {
        DispatchQueue.main.async {
            if let fallbackCountry = self.allCountries.first(where: { $0.alpha2Code == "IN" }) {
                self.mainCountries.insert(fallbackCountry, at: 0)
            }
        }
    }

    func getAllCountries() {
        guard !hasFetched else { return }
        hasFetched = true
        isLoading = true

        networkService.fetchCountries { data, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data {
                    self.allCountries = data
                    
                    self.locationManager.onCountryDetected = { [weak self] countryCode in
                        self?.handleDetectedCountryCode(countryCode)
                    }
                    self.detectUserCountry()
                } else {
                    self.error = CountryFetchError(message: error?.localizedDescription ?? "Unknown error")
                }
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
