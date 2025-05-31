//
//  NetworkService.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
import Foundation

class NetworkService {
    func fetchCountries(completion: @escaping (_ data: [Country]?, _ error: NSError?) -> Void) {
        let url = URL(string: "https://restcountries.com/v2/all")!
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(([Country].self), from: data)
                    completion(decodedData, nil)
                } catch let error as NSError {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
