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
    
    let id = UUID()
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
