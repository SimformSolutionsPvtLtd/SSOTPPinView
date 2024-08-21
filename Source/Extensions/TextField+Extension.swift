//
//  TextField+Extension.swift
//  SSOTPPinViewExample
//
//  Created by Pranay Patel on 04/06/24.
//

import Foundation
import SwiftUI

// MARK: - TextField Extensions

extension TextField {
    
    /// A method that sets a custom input view for the `TextField` based on the provided keyboard type.
    ///
    /// This method allows you to configure the input view of a `TextField` to use a custom keyboard or a default system keyboard,
    /// depending on the specified `keyboardType`. When using custom keyboards, the provided content view is used as the keyboard view.
    ///
    /// - Parameters:
    ///   - keyboardType: The type of keyboard to be used. This determines whether the standard keyboard or a custom keyboard is displayed.
    ///   - content: A closure that returns the custom keyboard view. This is used when `keyboardType` is `.customRandomDigits` or `.customNormalDigits`.
    ///
    /// - Returns: A modified `TextField` with the specified input view.
    @ViewBuilder
    func inputView<Content: View>(keyboardType: KeyboardType, @ViewBuilder content: @escaping () -> Content) -> some View {
        switch keyboardType {
        case .numberPad:
            self
                .keyboardType(.namePhonePad)
        case .default:
            self
                .keyboardType(.default)
        case .customRandomDigits, .customNormalDigits:
            self
                .background {
                    CustomKeyboard(keyboardContent: content())
                }
        }
    }
}

// MARK: - SecureField Extensions

extension SecureField {
    
    /// A method that sets a custom input view for the `SecureField` based on the provided keyboard type.
    ///
    /// This method allows you to configure the input view of a `SecureField` to use a custom keyboard or a default system keyboard,
    /// depending on the specified `keyboardType`. When using custom keyboards, the provided content view is used as the keyboard view.
    ///
    /// - Parameters:
    ///   - keyboardType: The type of keyboard to be used. This determines whether the standard keyboard or a custom keyboard is displayed.
    ///   - content: A closure that returns the custom keyboard view. This is used when `keyboardType` is `.customRandomDigits` or `.customNormalDigits`.
    ///
    /// - Returns: A modified `SecureField` with the specified input view.
    @ViewBuilder
    func inputView<Content: View>(keyboardType: KeyboardType, @ViewBuilder content: @escaping () -> Content) -> some View {
        switch keyboardType {
        case .numberPad:
            self
                .keyboardType(.numberPad)
        case .default:
            self
                .keyboardType(.default)
        case .customRandomDigits, .customNormalDigits:
            self
                .background {
                    CustomKeyboard(keyboardContent: content())
                }
        }
    }
}
