//
//  SSOTPPinViewModel.swift
//  SSOTPPinView
//
//  Created by Pranay Patel on 03/11/23.
//

import Foundation
import UIKit
import SwiftUI

/// Represents different types of text field styles.
public enum TextFieldType {
    case none, underline, box, circle
}

/// Represents different types of keyboards.
public enum KeyboardType {
    case numberPad, `default`, customRandomDigits, customNormalDigits
}

/// Maps a custom keyboard type to a standard `UIKeyboardType`.
///
/// - Parameter type: The custom keyboard type to be mapped.
/// - Returns: The corresponding `UIKeyboardType`.
func getKeyboard(type: KeyboardType) -> UIKeyboardType {
    switch type {
    case .numberPad:
        return .numberPad
    case .default:
        return .default
    case .customRandomDigits, .customNormalDigits:
        return .default
    }
}

/// Represents different types of secure text entry.
public enum SecureType {
    case dot// = "●"
    case star// = "⭑"
}

/// Returns the string representation of a secure text type.
///
/// - Parameter type: The secure text type to be converted.
/// - Returns: The string representation of the secure text type.
func getSecureTypeText(type: SecureType) -> String {
    if type == .dot {
        return "●"
    } else {
        return "⭑"
    }
}

/// A view model for managing OTP (One-Time Password) input and formatting.
///
/// `SSOTPPinViewModel` is used to manage OTP code input, format it for display, and handle secure text entry.
class SSOTPPinViewModel: ObservableObject {
    
    // MARK: - Variables
    
    /// A shuffled array of digits 0 through 9.
    public var randomDigits: [Int] = Array(0..<10).shuffled()
    
    /// An array of digits 1 through 9 followed by 0.
    public var digits: [Int] = Array(1..<10) + [0]
    
    /// The current OTP code entered by the user.
    @Published var otpCode = ""
    
    /// Indicates whether the OTP code should be displayed securely (e.g., as dots or stars).
    @Published var isSecureTextEntry: Bool = false
    
    /// The type of secure text entry (dot or star).
    @Published var secureTypeText: SecureType = .dot
    
    /// Returns the OTP pin character at a specified index.
    ///
    /// - Parameter index: The index of the character to retrieve.
    /// - Returns: The OTP pin character at the specified index. If secure text entry is enabled, returns the secure text type.
    func getOTPPin(at index: Int) -> String {
        guard self.otpCode.count > index else {
            return ""
        }
        if isSecureTextEntry {
            return getSecureTypeText(type: secureTypeText)
        } else {
            return String(Array(self.otpCode)[index])
        }
    }
    
    /// Formats the OTP code to display secure text characters.
    ///
    /// - Parameter otpCode: The OTP code to be formatted.
    /// - Returns: A string with the formatted OTP code, represented by secure text characters.
    func formatOTPCode(_ otpCode: String) -> String {
        return String(repeating: getSecureTypeText(type: secureTypeText), count: otpCode.count)
    }
    
    /// Limits the OTP code to a specified number of characters.
    ///
    /// - Parameter upper: The maximum number of characters allowed.
    func limitText(_ upper: Int) {
        if otpCode.count > upper {
            otpCode = String(otpCode.prefix(upper))
        }
    }
    
}
