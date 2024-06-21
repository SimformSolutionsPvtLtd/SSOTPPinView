//
//  SSOTPPinViewNotifier.swift
//  SSOTPPinView
//
//  Created by Pranay Patel on 03/11/23.
//

import Foundation
import SwiftUI

class SSOTPPinViewNotifier: ObservableObject {
    
    //MARK: Line Properties
    @Published var lineWidth: CGFloat = 1
    @Published var lineColor: Color = .black
        
    //MARK: Text Properties
    @Published var textColor: Color = .black
    @Published var font: Font = .system(size: 15)
    @Published var fontWeight: Font.Weight = .regular
    @Published var strokeWidth: CGFloat = 45.0
    @Published var strokeHeight: CGFloat = 45.0
    
    //MARK: Custom Keyboard Properites
    @Published var keyboardBackgroundColor: Color = .white
    @Published var keyFontColor: Color = .black
    @Published var keyStrokeColor: Color = .black

    //MARK: Other Properties
    @Published var isSecureTextEntry: Bool = false
    @Published var secureTextType: SecureType = .dot
    
    @Published var keyBoardType: KeyBoardType = .customRandomDigitsType

}
