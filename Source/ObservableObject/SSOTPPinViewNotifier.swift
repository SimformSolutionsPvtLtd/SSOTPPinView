//
//  SSOTPPinViewNotifier.swift
//  SSOTPPinView
//
//  Created by Pranay Patel on 03/11/23.
//

import Foundation
import SwiftUI

/// A notifier class for managing and publishing changes to the visual and functional properties of an OTP pin view.
///
/// `SSOTPPinViewNotifier` is an `ObservableObject` that handles properties related to the appearance of the OTP pin view,
/// including line and text properties, custom keyboard settings, and secure text entry options.
class SSOTPPinViewNotifier: ObservableObject {
    
    //MARK: Line Properties
    
    /// The width of the line (or border) around the OTP pin view.
    @Published var lineWidth: CGFloat = 1
    
    /// The color of the line (or border) around the OTP pin view.
    @Published var lineColor: Color = .black
        
    //MARK: Text Properties
    
    /// The color of the text displayed in the OTP pin view.
    @Published var textColor: Color = .black
    
    /// The font used for the text in the OTP pin view.
    @Published var font: Font = .system(size: 15)
    
    /// The font weight used for the text in the OTP pin view.
    @Published var fontWeight: Font.Weight = .regular
    
    /// The width of the stroke or box around each OTP pin character.
    @Published var strokeWidth: CGFloat = 45.0
    
    /// The height of the stroke or box around each OTP pin character.
    @Published var strokeHeight: CGFloat = 45.0
    
    //MARK: Custom Keyboard Properties
    
    /// The background color of the custom keyboard.
    @Published var keyboardBackgroundColor: Color = .white
    
    /// The font color of the keys on the custom keyboard.
    @Published var keyFontColor: Color = .black
    
    /// The color of the stroke or border around the keys on the custom keyboard.
    @Published var keyStrokeColor: Color = .black

    //MARK: Other Properties
    
    /// Indicates whether the OTP code should be displayed securely (e.g., with dots or stars).
    @Published var isSecureTextEntry: Bool = false
    
    /// The type of secure text entry used (dot or star).
    @Published var secureTextType: SecureType = .dot
    
    //MARK: Keyboard Type
    
    /// The type of keyboard to be used for input (e.g., number pad, custom digits).
    @Published var keyboardType: KeyboardType = .customRandomDigits

}
