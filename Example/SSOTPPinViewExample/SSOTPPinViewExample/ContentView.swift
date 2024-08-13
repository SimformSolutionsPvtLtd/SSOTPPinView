//
//  ContentView.swift
//  SSOTPPinViewExample
//
//  Created by Pranay Patel on 04/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var otp = ""
    
    var body: some View {
        VStack {
            SSOTPPinView(textFieldType: .circle, numberOfCount: 5, keyboardOptions: .customRandomDigits) { newValue in
                self.otp = newValue
                print(otp)
            }
            .isSecureTextEntry(true)
            .secureTextType(.star)
            .textColor(.black)
            .fontWeight(.bold)
            .lineColor(.blue)
            .lineWidth(2)
            // custom keyboard property
            .keyboardBackgroundColor(.red)
            .keyFontColor(.white)
            .keyStrokeColor(.black)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
