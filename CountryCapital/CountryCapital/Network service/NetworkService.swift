//
//  NetworkService.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
import Foundation

class NetworkService {
    func fetchCountries(completion: @escaping (_ data: [Country]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://restcountries.com/v2/all") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error
            {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "No Data", code: 0, userInfo: nil))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(([Country].self), from: data)
                completion(decodedData, nil)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
}
