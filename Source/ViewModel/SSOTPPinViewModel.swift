//
//  SSOTPPinViewModel.swift
//  SSOTPPinView
//
//  Created by Pranay Patel on 03/11/23.
//

import Foundation
import UIKit
import SwiftUI

public enum TextFieldType {
    case  OTP_VIEW_TYPE_NONE, OTP_VIEW_TYPE_UNDERLINE, OTP_VIEW_TYPE_BOX, OTP_VIEW_TYPE_CRICLE
}

public enum KeyBoardType {
    case numberPadType, defaultType, customRandomDigitsType, customNormalDigitsType
}

func getKeyBoard(type: KeyBoardType) -> UIKeyboardType {
    
    switch type {
    case .numberPadType:
        return .numberPad
    case .defaultType:
        return .default
    case .customRandomDigitsType, .customNormalDigitsType:
        return .default
    }
}

public enum SecureType {
    case dot// = "●"
    case star// = "⭑"
}

func getSecureTypeText(type: SecureType) -> String {
    if type == .dot {
        return "●"
    } else {
        return "⭑"
    }
}

class SSOTPPinViewModel: ObservableObject {
    
    public var remdomDigits: [Int] = Array(0..<10).shuffled()
    public var digits: [Int] = Array(1..<10) + [0]
    @Published var otpCode = ""
    @Published var isSecureTextEntry: Bool = false
    @Published var secureTypeText: SecureType = .dot
    
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
    
    func formatOTPCode(_ otpCode: String) -> String {
        return String(repeating: getSecureTypeText(type: secureTypeText), count: otpCode.count)
    }
    
    func limitText(_ upper: Int) {
        if otpCode.count > upper {
            otpCode = String(otpCode.prefix(upper))
        }
    }
    
}
