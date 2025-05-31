//
//  CountryModel.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
import Foundation

struct Country: Decodable, Identifiable {
    let name: String
    let topLevelDomain: [String]?
    let alpha2Code: String
    let alpha3Code: String
    let capital: String?
    let region: String?
    let subregion: String?
    let population: Int?
    let area: Double?
    let nativeName: String?
    let flag: String?
    let latlng: [Double]?
    let currencies: [Currency]?
    let languages: [Language]?
    let flags: FlagImages?
    
    public let id = UUID()
    
    public init(name: String, topLevelDomain: [String]?, alpha2Code: String, alpha3Code: String, capital: String?, region: String?, subregion: String?, population: Int?, area: Double?, nativeName: String?, flag: String?, latlng: [Double]?, currencies: [Currency]?, languages: [Language]?, flags: FlagImages?) {
        self.name = name
        self.topLevelDomain = topLevelDomain
        self.alpha2Code = alpha2Code
        self.alpha3Code = alpha3Code
        self.capital = capital
        self.region = region
        self.subregion = subregion
        self.population = population
        self.area = area
        self.nativeName = nativeName
        self.flag = flag
        self.latlng = latlng
        self.currencies = currencies
        self.languages = languages
        self.flags = flags
    }
}
struct Currency: Decodable {
    let code: String?
    let name: String?
    let symbol: String?
}
struct Language: Decodable {
    let name: String
    let nativeName: String?
}
struct FlagImages: Decodable {
    var svg: String?
    var png: String?
}
