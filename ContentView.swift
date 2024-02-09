//
//  ContentView.swift
//  BMICalculator
//
//  Created by user238136 on 2/8/24

import SwiftUI

struct ContentView: View {
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var isMetric: Bool = true
    @State private var message: String = "Submit"
    @State private var bmi: String = "BMI CALCULATOR"

    func calculateBMI() -> String {
        guard let weight = Double(weight), let height = Double(height) else {
            return "Please enter valid numbers for weight and height."
        }

        if isMetric {
            let bmiMetric = weight / (height * height)
            return String(format: "%.2f", bmiMetric)
        } else {
            let weightInPounds = weight * 2.20462
            let heightInInches = height * 39.3701
            let bmiImperial = 703 * (weightInPounds / (heightInInches * heightInInches))
            return String(format: "%.2f", bmiImperial)
        }
    }

    func getBMICategory(bmi: Double) -> String {
        switch bmi {
        case ..<16:
            return "Severe Thinness"
        case 16..<17:
            return "Moderate Thinness"
        case 17..<18.5:
            return "Mild Thinness"
        case 18.5..<25:
            return "Normal"
        case 25..<30:
            return "Overweight"
        case 30..<35:
            return "Obese Class I"
        case 35..<40:
            return "Obese Class II"
        default:
            return "Obese Class III"
        }
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text(bmi)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()

                Toggle(isOn: $isMetric) {
                    Text(isMetric ? "Kg" : "Lb")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .toggleStyle(SwitchToggleStyle(tint: .black))
                .padding()

                VStack(alignment: .leading) {
                    Text("Weight")
                        .foregroundColor(.white)
                        .font(.headline)
                    TextField("Enter Weight", text: $weight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Height")
                        .foregroundColor(.white)
                        .font(.headline)
                    TextField("Enter Height", text: $height)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()

                Button(action: {
                    let calculatedBMI = calculateBMI()
                    self.bmi = "BMI = \(calculatedBMI)"
                    let bmiValue = Double(calculatedBMI) ?? 0.0
                    self.message = getBMICategory(bmi: bmiValue)
                }) {
                    Text(message)
                        .foregroundColor(.blue)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
