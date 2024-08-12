//
//  TextField+Extension.swift
//  SSOTPPinViewExample
//
//  Created by Pranay Patel on 04/06/24.
//

import Foundation
import SwiftUI

extension TextField {
    @ViewBuilder
    func inputView<Content: View>(keyboardType: KeyBoardType, @ViewBuilder content: @escaping () -> Content) -> some View {
        switch keyboardType {
        case .numberPadType:
            self
                .keyboardType(.namePhonePad)
        case .defaultType:
            self
                .keyboardType(.default)
        case .customRandomDigitsType, .customNormalDigitsType:
            self
                .background {
                    SetTFKeyboard(keyboardContent: content())
                }
        }
    }
}

extension SecureField {
    @ViewBuilder
    func inputView<Content: View>(keyboardType: KeyBoardType, @ViewBuilder content: @escaping () -> Content) -> some View {
        switch keyboardType {
        case .numberPadType:
            self
                .keyboardType(.numberPad)
        case .defaultType:
            self
                .keyboardType(.default)
        case .customRandomDigitsType, .customNormalDigitsType:
            self
                .background {
                    SetTFKeyboard(keyboardContent: content())
                }
        }
    }
}
