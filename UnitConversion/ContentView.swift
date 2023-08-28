//
//  ContentView.swift
//  UnitConversion
//
//  Created by Nathan Leach on 8/27/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputTemp = 0.0
    @State private var inputType = "Celsius"
    @State private var outputType = "Celsius"
    @FocusState private var isFocused: Bool
    
    let tempList = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var outputTemp: Double {
        var output = inputTemp
        if inputType == "Celsius" {
            if outputType == "Fahrenheit" {
                return (output * 9/5) + 32
            } else if outputType == "Kelvin" {
                return output + 273.15
            } else {
                return output
            }
        } else if inputType == "Fahrenheit" {
            if outputType == "Celsius" {
                return (output - 32) * 5/9
            } else if outputType == "Kelvin" {
                return (output - 32) * 5/9 + 273.15
            } else {
                return output
            }
        } else if inputType == "Kelvin" {
            if outputType == "Celsius" {
                return output - 273.15
            } else if outputType == "Fahrenheit" {
                return (output - 273.15) * 9/5 + 32
            } else {
                return output
            }
        } else {
            return 1234567
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Input", value: $inputTemp, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                Section {
                    Picker("Temp Units", selection: $inputType){
                        ForEach(tempList, id: \.self){ unit in
                            Text("\(unit)")
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("Temp Units", selection: $outputType){
                        ForEach(tempList, id: \.self){ unit in
                            Text("\(unit)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Text("\(inputTemp, specifier: "%.2f") degrees \(inputType) is \(outputTemp, specifier: "%.2f") degrees \(outputType).")
            }
            .navigationTitle("Simple Unit Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
