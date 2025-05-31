//
//  MainView.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: CountryViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading countries..")
                        .progressViewStyle(.circular)
                } else {
                    List {
                        if !viewModel.mainCountries.isEmpty {
                            Section(header: Text("My Countries")) {
                                ForEach(viewModel.mainCountries) { country in
                                    NavigationLink(destination: DetailView(country: country)) {
                                        VStack(alignment: .leading) {
                                            Text(country.name)
                                            Text("Capital: \(country.capital ?? "N/A")")
                                            Text("Currency: \(country.currencies?.first?.name ?? "N/A")")
                                        }
                                        .contextMenu {
                                            Button("Remove", role: .destructive) {
                                                viewModel.removeFromMainCountries(country: country)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Section(header: Text("All Countries")) {
                            ForEach(viewModel.filteredCountries) { country in
                                HStack {
                                    Text(country.name)
                                    Spacer()
                                    Button {
                                        viewModel.addToMainCountry(country: country)
                                    } label: {
                                        Image(systemName: "plus.circle")
                                    }
                                    .disabled(viewModel.mainCountries.count >= 5)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getAllCountries()
            }
            .alert(item: $viewModel.error) { error in
                Alert(
                    title: Text("Error"),
                    message: Text("\(error.message)"),
                    dismissButton: .default(
                        Text("OK"),
                        action: {
                            viewModel.error = nil
                        }
                    )
                )
            }
        }
        .navigationTitle("Countries")
        .searchable(text: $viewModel.searchText)
    }
}

#Preview {
    MainView(viewModel: CountryViewModel())
}
