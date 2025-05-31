//
//  CountryCapitalApp.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//

import SwiftUI

@main
struct CountryCapitalApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: makeViewModel())
        }
    }
}

func makeViewModel() -> CountryViewModel {
    let viewModel = CountryViewModel()
    viewModel.locationManager.onCountryDetected = { countryCode in
        //Closure instantiation
        viewModel.handleDetectedCountryCode(countryCode)
    }
    return viewModel
}
