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
            SSOTPPinView(textFieldType: .OTP_VIEW_TYPE_BOX, numberOfCount: 5, keyboardOptions: .customRandomDigitsType) { newValue in
                self.otp = newValue
                print(otp)
            }
            .isSecureTextEntry(true)
            .keyFontColor(.blue)
            .keyFontColor(.black)
            .secureTextType(.star)
            .textColor(.red)
            .fontWeight(.bold)
            .lineColor(.red)
            .lineWidth(2)
            // custom keyboard property
            .keyboardBackgroundColor(.white)
            .keyFontColor(.red)
            .keyStrokeColor(.blue)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
