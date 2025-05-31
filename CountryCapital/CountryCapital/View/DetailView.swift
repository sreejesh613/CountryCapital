//
//  DetailView.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//

import SwiftUI

struct DetailView: View {
    var country: Country
    
    var body: some View {
        Text("Detail View")
            .font(.system(size: 20, weight: .semibold))
        Spacer()
        VStack(alignment: .leading) {
            Text("Country: \(country.name)")
                .font(.system(size: 18, weight: .regular))
            Text("Capital: \(country.capital ?? "N/A")")
            Text("Currency: \(country.currencies?.first?.name ?? "N/A")")
            Spacer()
        }
    }
}
