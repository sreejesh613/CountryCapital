//
//  DetailViewSpec.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
import Quick
import Nimble
import SwiftUI
import ViewInspector
@testable import CountryCapital

class DetailViewSpec: QuickSpec {
    override func spec() {
        var mockCountry: Country!
        var subject: DetailView!
        
        describe("DetailView") {
            beforeEach {
                mockCountry = Country(name: "Argentina", topLevelDomain: [".ar"], alpha2Code: "AR", alpha3Code: "ARG", capital: "Buenos Aires", region: "Americas", subregion: "South America", population: 45376763, area: 2780400, nativeName: "Argentina", flag: "https://flagcdn.com/ar.svg", latlng: [-34, -64], currencies: nil, languages: nil, flags: nil)
                subject = DetailView(country: mockCountry)
            }
            it("Tests the title") {
                let title = try subject.inspect().find(text: "Detail View")
                expect(title).toNot(beNil())
            }
            it("Tests the title") {
                let name = try subject.inspect().find(text: "Argentina")
                expect(name).toNot(beNil())
            }
            it("Tests the capital text") {
                let capital = try subject.inspect().find(text: "Buenos Aires")
                expect(capital).toNot(beNil())
            }
            it("Tests the currency text") {
                let currencyText = try subject.inspect().find(text: "Currency: N/A")
                expect(currencyText).toNot(beNil())
            }
        }
    }
}
