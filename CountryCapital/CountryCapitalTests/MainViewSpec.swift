//
//  MainViewSpec.swift
//  CountryCapital
//
//  Created by Sreejesh Krishnan on 31/05/25.
//
import Quick
import Nimble
import ViewInspector
@testable import CountryCapital

class MainViewSpec: QuickSpec {
    override func spec() {
        var subject: MainView!
        var viewModel = CountryViewModel()
        describe("Main View") {
            beforeEach {
                subject = MainView(viewModel: viewModel)
            }
            it("Tests NavigationStack") {
                let navStack = try subject.inspect().navigationStack()
                expect(navStack).toNot(beNil())
            }
            it("Tests progressView") {
                viewModel.isLoading = true
                let navStack = try subject.inspect().navigationStack()
            }
            it("Checks List") {
                let list = try subject.inspect().list()
                expect(list).toNot(beNil())
                let section0 = try list.section(0).find(text: "My Countries")
                expect(section0).toNot(beNil())
            }
        }
    }
}
