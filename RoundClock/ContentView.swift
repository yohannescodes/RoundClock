//
//  ContentView.swift
//  RoundClock
//
//  Created by Yohannes Haile on 6/1/25.
//

import SwiftUI

struct ContentView: View {
    
    enum Unit: String {
        case sec = "sec"
        case min = "min"
        case hour = "hour"
        case day = "day"
    }
    
    let units: [Unit] = [Unit.sec, Unit.min, Unit.hour, Unit.day]
    
    @State private var selectedInputUnit = Unit.hour
    @State private var selectedOutputUnit = Unit.min
    @State private var inputValue: Double = 1
    
    var outputValue: Double {
        switch(selectedInputUnit, selectedOutputUnit) {
        case (.sec, .sec):
            return Double(inputValue)
        case (.sec, .min):
            return inputValue / 60
        case (.sec, .hour):
            return inputValue / 3600
        case (.sec, .day):
            return inputValue / 86400
        
            
        case (.min, .sec):
            return inputValue * 60
        case (.min, .min):
            return inputValue
        case (.min, .hour):
            return inputValue / 60
        case (.min, .day):
            return inputValue / 1440
            
        case (.hour, .sec):
            return inputValue * 3600
        case (.hour, .min):
            return inputValue * 60
        case (.hour, .hour):
            return inputValue
        case (.hour, .day):
            return inputValue / 24
            
        case (.day, .sec):
            return inputValue * 86400
        case (.day, .min):
            return inputValue * 1440
        case (.day, .hour):
            return inputValue * 24
        case (.day, .day):
            return inputValue
        }
    }
    
    var body: some View {
       NavigationStack {
           Form {
               Section ("Input unit") {
                   Picker("Input unit", selection: $selectedInputUnit) {
                       ForEach(units, id: \.self) {
                           Text($0.rawValue)
                       }
                   }
                   .pickerStyle(.segmented)
               }
               
               Section ("Output unit") {
                   Picker("Output unit", selection: $selectedOutputUnit) {
                       ForEach(units, id: \.self) {
                           Text($0.rawValue)
                       }
                   }
                   .pickerStyle(.segmented)
               }
               
               Section ("Value") {
                   HStack {
                       TextField("Value", value: $inputValue, format: .number)
                       Text("\(selectedInputUnit.rawValue)")
                       Spacer()
                   }
               }
               
               Section ("Result") {
                   Text("\(outputValue) \(selectedOutputUnit.rawValue)")
               }
           }.navigationTitle(Text("Round Clock"))
        }
    }
}

#Preview {
    ContentView()
}
