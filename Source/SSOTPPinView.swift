//
//  SSOTPPinView.swift
//  SSOTPPinView
//
//  Created by Pranay Patel on 03/11/23.
//

import SwiftUI
import Combine

/// A SwiftUI view that represents a secure OTP (One-Time Password) input field.
///
/// The `SSOTPPinView` provides a customizable OTP input interface that can display either a regular text field or a secure text field,
/// based on the configuration. The view allows for a variety of styles and configurations including text properties, line properties,
/// and custom keyboard settings. It supports dynamic changes and updates to reflect user interactions and settings.
///
/// - **Usage:** Instantiate `SSOTPPinView` and configure it using various properties and methods. The view displays the OTP input field
///   with the specified number of digits and allows customization of appearance and functionality.
public struct SSOTPPinView: View {
    
    // MARK: - Focus Field Enum
    /// An enumeration representing the different focus fields within the OTP input view.
    ///
    /// - field: Represents the primary text field that can be focused.
    enum FocusField: Hashable {
        case field
    }

    // MARK: - Variables
    /// The type of text field to be used for OTP input.
    ///
    /// This variable determines the visual style of the text field, such as underline, box, or circle. Default is `.underline`.
    var type: TextFieldType = .underline

    /// The number of OTP characters required for the input.
    ///
    /// This variable specifies the length of the OTP code that the user is expected to enter. Default is `6`.
    var numberOfCount: Int = 6

    /// The keyboard type used for entering OTP digits.
    ///
    /// This variable defines the type of keyboard to be displayed for OTP input. The default is `.customRandomDigits`.
    var keyboardType: KeyboardType = .customRandomDigits

    /// A closure that is called when the OTP code is updated.
    ///
    /// - Parameter code: The current OTP code entered by the user. This closure allows for custom actions or handling when the OTP code changes.
    ///
    /// This variable is used to provide a callback with the updated OTP code. The default is an empty closure.
    var completion: ((String) -> Void)

    
    //MARK: State Object
        
    /// A state property that tracks the currently focused field in the view.
    ///
    /// - **Default Value:** `nil`
    ///
    /// This property is used to manage and track which field is currently focused.
    @FocusState private var focusedField: FocusField?
    
    //MARK: Observed Object
    
    /// An observed object that manages and publishes changes to the OTP pin view's visual and functional properties.
    ///
    /// - **Default Value:** A new instance of `SSOTPPinViewNotifier`
    ///
    /// This object is used to handle and respond to changes in properties related to the appearance and behavior of the OTP pin view.
    @ObservedObject private var notifier = SSOTPPinViewNotifier()
    
    /// An observed object that manages and publishes changes to the OTP pin view's data and state.
    ///
    /// - **Default Value:** Must be initialized externally with an instance of `SSOTPPinViewModel`
    ///
    /// This object is responsible for handling the OTP code and related functionality, including secure text entry and code formatting.
    @ObservedObject var viewModel: SSOTPPinViewModel
    
    /// Initializes a new instance of the custom text field, typically used for OTP or PIN input.
    ///
    /// - Parameters:
    ///   - textFieldType: The type of the text field, specifying its configuration or style.
    ///   - numberOfCount: The number of characters or digits the text field will allow.
    ///   - keyboardOptions: The type of keyboard to be displayed when the text field is active. Defaults to `.numberPad`.
    ///   - commit: A closure that is called upon the completion of input, receiving the final input string as a parameter. This closure is optional and defaults to an empty closure.
    public init(textFieldType: TextFieldType, numberOfCount: Int, keyboardOptions: KeyboardType = .numberPad, commit: @escaping (String)->() = { _ in }) {
        self.type = textFieldType
        self.numberOfCount = numberOfCount
        self.keyboardType = keyboardOptions
        self.viewModel = SSOTPPinViewModel()
        self.completion = commit
    }
    
    /// A computed property that returns a custom `TextField` view designed for OTP (One-Time Password) input.
    ///
    /// This view is highly customized with the following features:
    /// - Binds the text input to `viewModel.otpCode`.
    /// - Uses a custom input view (`CustomDigitView`) to replace the standard keyboard.
    /// - Restricts the text input to a specified number of characters using `viewModel.limitText(numberOfCount)`.
    /// - Automatically focuses the text field on initialization.
    /// - Customizes the appearance and behavior of the text field, including setting the tint and text alignment.
    /// - Supports both iOS 17.0 and earlier versions for responding to changes in `viewModel.otpCode`.
    ///
    /// The view also ensures that the text field receives focus shortly after appearing on the screen,
    /// and it interacts with the `notifier` to set the appropriate keyboard type.
    ///
    /// - Note: This property uses a combination of the `.modify`, `.onAppear`, `.task`, and `.onReceive` modifiers to achieve its custom behavior.
    private var otpTextFiled: some View {
        return TextField("", text: $viewModel.otpCode)
            .inputView(keyboardType: keyboardType) {
                CustomDigitView(viewModel: self.viewModel, notifier: notifier)
            }
            .frame(width: 0, height: 0, alignment: .center)
            .font(Font.system(size: 0))
            .tint(.blue)
            .foregroundStyle(.blue)
            .multilineTextAlignment(.center)
            .onReceive(Just(viewModel.otpCode)) { _ in viewModel.limitText(numberOfCount)}
            .focused($focusedField, equals: .field)
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.focusedField = .field
                }
            }
            .modify {
                if #available(iOS 17.0, *) {
                    $0.onChange(of: viewModel.otpCode, { oldValue, newValue in
                        completion(newValue)
                    })
                } else {
                    $0.onChange(of: viewModel.otpCode, perform: { newValue in
                        completion(newValue)
                    })
                }
            }
            .onAppear {
                self.notifier.keyboardType = self.keyboardType
            }
            .padding()
    }
    
    /// A computed property that returns a custom `SecureField` view designed for secure OTP (One-Time Password) input.
    ///
    /// This view provides the following features:
    /// - Binds the secure text input to `viewModel.otpCode`, ensuring that the OTP is hidden as it's entered.
    /// - Uses a custom input view (`CustomDigitView`) instead of the standard keyboard for entering the OTP.
    /// - Restricts the input to a specified number of characters, utilizing `viewModel.limitText(self.numberOfCount)`.
    /// - Automatically focuses the text field when it appears and dismisses the keyboard upon reaching the required number of characters.
    /// - Supports custom keyboard types, with dynamic behavior based on the iOS version for handling text changes in `viewModel.otpCode`.
    ///
    /// The view also manages the keyboard type through the `notifier`, ensuring that it aligns with the provided `keyboardType`.
    /// Additionally, the text field automatically gains focus shortly after appearing on the screen, and it interacts with the `completion` closure
    /// to handle the final OTP input.
    ///
    /// - Note: The property uses `.modify`, `.onAppear`, `.task`, and `.onReceive` modifiers to achieve its functionality, and it adapts based on iOS version to handle changes in the OTP input.
    private var otpSecureTextField: some View {
        return SecureField("", text: $viewModel.otpCode)
            .inputView(keyboardType: keyboardType) {
                CustomDigitView(viewModel: self.viewModel, notifier: notifier)
            }
            .frame(width: 0, height: 0, alignment: .center)
            .font(Font.system(size: 0))
            .tint(.blue)
            .foregroundStyle(.blue)
            .multilineTextAlignment(.center)
            .keyboardType(getKeyboard(type: self.keyboardType))
            .onReceive(Just(viewModel.otpCode)) { _ in viewModel.limitText(self.numberOfCount)}
            .focused($focusedField, equals: .field)
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.focusedField = .field
                }
            }
            .modify {
                if #available(iOS 17.0, *) {
                    $0.onChange(of: viewModel.otpCode, { oldValue, newValue in
                        completion(newValue)
                        if viewModel.otpCode.count == numberOfCount {
                            focusedField = nil
                        }
                    })
                } else {
                    $0.onChange(of: viewModel.otpCode, perform: { newValue in
                        completion(newValue)
                        if viewModel.otpCode.count == numberOfCount {
                            focusedField = nil
                        }
                    })
                }
            }
            .onAppear {
                self.notifier.keyboardType = self.keyboardType
            }
            .padding()
    }
    
    /// The main view of the OTP (One-Time Password) input field, rendered using a combination of `ZStack` and `HStack` views.
    ///
    /// This view dynamically switches between a secure or standard OTP input field based on the `notifier.isSecureTextEntry` property.
    /// It also supports different styles for displaying the OTP characters, such as plain text, circles, boxes, or underlines,
    /// depending on the value of the `type` property.
    ///
    /// - When `notifier.isSecureTextEntry` is true, the view displays a secure OTP input field (`otpSecureTextField`).
    /// - When `notifier.isSecureTextEntry` is false, the view displays a standard OTP input field (`otpTextFiled`).
    /// - If the `type` property is `.none`, the view displays the OTP characters directly as text.
    /// - If the `type` is `.circle`, `.box`, or `.underline`, the view arranges the OTP characters in a horizontal stack with the chosen style.
    ///
    /// The view also handles tap gestures on the displayed OTP characters or input field, automatically focusing the input field
    /// when the user interacts with it and the OTP code is complete.
    ///
    /// - Components:
    ///   - `ZStack`: Aligns the secure/standard text fields with the styled OTP characters.
    ///   - `HStack`: Arranges the OTP characters horizontally when a specific style (`circle`, `box`, `underline`) is chosen.
    ///   - `Text`: Displays each character of the OTP with the configured font, weight, and color.
    ///   - `Circle`, `RoundedRectangle`, `Rectangle`: Visual elements used to style the OTP input according to the `type`.
    ///
    /// - Gesture Handling:
    ///   - The view includes tap gesture recognizers that focus the input field when the OTP code reaches the specified `numberOfCount`.
    ///
    /// - Note: The `body` property combines different SwiftUI views and modifiers to create a highly customizable OTP input field.
    public var body: some View {
        ZStack(alignment: .center) {
            if notifier.isSecureTextEntry {
                otpSecureTextField
            } else {
                otpTextFiled
            }
            if type == .none {
                Text(viewModel.isSecureTextEntry ? viewModel.formatOTPCode(viewModel.otpCode) : viewModel.otpCode)
                    .fontWeight(notifier.fontWeight)
                    .font(notifier.font)
                    .foregroundStyle(notifier.textColor)
                    .frame(width: notifier.strokeWidth, height: notifier.strokeHeight)
                    .lineLimit(1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(notifier.lineColor, lineWidth: notifier.lineWidth)
                    )
                    .onTapGesture {
                        if viewModel.otpCode.count == numberOfCount {
                            self.focusedField = .field
                        }
                    }
            } else {
                HStack {
                    ForEach(0..<self.numberOfCount, id: \.self) { index in
                        ZStack {
                            Text(viewModel.getOTPPin(at: index))
                                .font(notifier.font)
                                .fontWeight(notifier.fontWeight)
                                .foregroundStyle(notifier.textColor)
                                .onTapGesture {
                                    if viewModel.otpCode.count == numberOfCount {
                                        self.focusedField = .field
                                    }
                                }
                            if type == .circle {
                                Circle()
                                    .stroke(notifier.lineColor, lineWidth: notifier.lineWidth)
                                    .frame(width: notifier.strokeWidth, height: notifier.strokeHeight)
                                    .onTapGesture {
                                        if viewModel.otpCode.count == numberOfCount {
                                            self.focusedField = .field
                                        }
                                    }
                            } else if type == .box {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(notifier.lineColor, lineWidth: notifier.lineWidth)
                                    .frame(width: notifier.strokeWidth, height: notifier.strokeHeight)
                                    .onTapGesture {
                                        if viewModel.otpCode.count == numberOfCount {
                                            self.focusedField = .field
                                        }
                                    }
                            } else if type == .underline {
                                Rectangle()
                                    .frame(height: notifier.lineWidth)
                                    .frame(width: notifier.strokeWidth)
                                    .foregroundStyle(notifier.lineColor)
                                    .padding(.trailing, 5)
                                    .padding(.leading, 5)
                                    .padding(.top, notifier.strokeHeight)
                                    .onTapGesture {
                                        if viewModel.otpCode.count == numberOfCount {
                                            self.focusedField = .field
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Other Property Functions
extension SSOTPPinView {
    /// Configures whether the text field should use secure text entry (i.e., hide the input text).
    ///
    /// - Parameter isSecure: A Boolean value indicating whether the text field should obscure the text input.
    /// - Returns: The `SSOTPPinView` instance with updated secure text entry settings.
    public func isSecureTextEntry(_ isSecure: Bool) -> Self {
        notifier.isSecureTextEntry = isSecure
        viewModel.isSecureTextEntry = isSecure
        return self
    }
    
    /// Configures the type of secure text to be used.
    ///
    /// - Parameter type: The type of secure text (`SecureType`) to be used in the text field.
    /// - Returns: The `SSOTPPinView` instance with the updated secure text type.
    public func secureTextType(_ type: SecureType) -> Self {
        viewModel.secureTypeText = type
        notifier.secureTextType = type
        return self
    }
}

// MARK: - Text Property Functions
@available(iOS 15.0, *)
extension SSOTPPinView {
    /// Sets the color of the text displayed in the OTP input field.
    ///
    /// - Parameter color: The color to apply to the text.
    /// - Returns: The `SSOTPPinView` instance with the updated text color.
    public func textColor(_ color: Color) -> Self {
        notifier.textColor = color
        return self
    }

    /// Sets the font of the text displayed in the OTP input field.
    ///
    /// - Parameter font: The font to apply to the text.
    /// - Returns: The `SSOTPPinView` instance with the updated text font.
    public func textFont(_ font: Font) -> Self {
        notifier.font = font
        return self
    }
    
    /// Sets the weight of the font used in the OTP input field.
    ///
    /// - Parameter fontWeight: The weight to apply to the font.
    /// - Returns: The `SSOTPPinView` instance with the updated font weight.
    public func fontWeight(_ fontWeight: Font.Weight) -> Self {
        notifier.fontWeight = fontWeight
        return self
    }
    
    /// Sets the width of the stroke used around the text field.
    ///
    /// - Parameter width: The width of the stroke.
    /// - Returns: The `SSOTPPinView` instance with the updated stroke width.
    public func strokeWidth(_ width: CGFloat) -> Self {
        notifier.strokeWidth = width
        return self
    }
    
    /// Sets the height of the stroke used around the text field.
    ///
    /// - Parameter height: The height of the stroke.
    /// - Returns: The `SSOTPPinView` instance with the updated stroke height.
    public func strokeHeight(_ height: CGFloat) -> Self {
        notifier.strokeHeight = height
        return self
    }

}

// MARK: - Custom Keyboard Properties
@available(iOS 15.0, *)
extension SSOTPPinView {
    /// Sets the background color of the custom keyboard.
    ///
    /// - Parameter color: The background color for the keyboard.
    /// - Returns: The `SSOTPPinView` instance with the updated keyboard background color.
    public func keyboardBackgroundColor(_ color: Color) -> Self {
        notifier.keyboardBackgroundColor = color
        return self
    }
    
    /// Sets the font color of the digits on the custom keyboard.
    ///
    /// - Parameter color: The font color for the keyboard digits.
    /// - Returns: The `SSOTPPinView` instance with the updated digit font color.
    public func keyFontColor(_ color: Color) -> Self {
        notifier.keyFontColor = color
        return self
    }
    
    /// Sets the stroke color of the keys on the custom keyboard.
    ///
    /// - Parameter color: The stroke color for the keyboard keys.
    /// - Returns: The `SSOTPPinView` instance with the updated key stroke color.
    public func keyStrokeColor(_ color: Color) -> Self {
        notifier.keyStrokeColor = color
        return self
    }
    
}

// MARK: - Line Property Functions
@available(iOS 15.0, *)
extension SSOTPPinView {
    /// Sets the width of the line used to underline or surround the OTP input fields.
    ///
    /// - Parameter width: The width of the line.
    /// - Returns: The `SSOTPPinView` instance with the updated line width.
    public func lineWidth(_ width: CGFloat) -> Self {
        notifier.lineWidth = width
        return self
    }
    
    /// Sets the color of the line used to underline or surround the OTP input fields.
    ///
    /// - Parameter color: The color of the line.
    /// - Returns: The `SSOTPPinView` instance with the updated line color.
    public func lineColor(_ color: Color) -> Self {
        notifier.lineColor = color
        return self
    }

}
