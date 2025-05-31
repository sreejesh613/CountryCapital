//
//  CountryViewModelSpec.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
@testable import CountryCapital
import Foundation
import Nimble
import Quick
import SwiftUI

class CountryViewModelSpec: QuickSpec {
    
    override func spec() {
        var subject: CountryViewModel?
        var mockCountry: Country!
        
        describe("CountryViewModel") {
            beforeEach {
                subject = CountryViewModel()
                mockCountry = Country(name: "Argentina", topLevelDomain: [".ar"], alpha2Code: "AR", alpha3Code: "ARG", capital: "Buenos Aires", region: "Americas", subregion: "South America", population: 45376763, area: 2780400, nativeName: "Argentina", flag: "https://flagcdn.com/ar.svg", latlng: [-34, -64], currencies: nil, languages: nil, flags: nil)
            }

            it("Add to Main countries") {
                subject?.addToMainCountry(country: mockCountry)
                expect(subject?.mainCountries.count).to(equal(1))
                expect(subject?.mainCountries.first?.name).to(equal("Argentina"))
            }
            it("Remove from main countries") {
                subject?.mainCountries = [mockCountry]
                subject?.removeFromMainCountries(country: mockCountry)
                expect(subject?.mainCountries.count).to(equal(0))
            }
            it("Use fallback country India") {
                subject?.allCountries = [mockCountry]
                subject?.useFallbackCountry()
                expect(subject?.mainCountries.first?.alpha2Code).to(equal("IN"))
            }
            it("Test Handle detected country code") {
                subject?.allCountries = [mockCountry]
                subject?.handleDetectedCountryCode("IN")
                expect(subject?.mainCountries.first?.name).to(equal("India"))
            }
            it("Tests filtered countries") {
                subject?.allCountries = [mockCountry]
                subject?.searchText = "Ar"
                expect(subject?.filteredCountries.count).to(equal(1))
            }
        }
    }
}
