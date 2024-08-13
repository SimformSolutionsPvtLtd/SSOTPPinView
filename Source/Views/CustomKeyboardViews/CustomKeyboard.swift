//
//  CustomKeyboard.swift
//  Example
//
//  Created by Pranay Patel on 30/05/24.
//

import SwiftUI

/// A view that integrates a custom SwiftUI view as an input view for a `UITextField`.
///
/// `CustomKeyboard` conforms to `UIViewRepresentable` and provides a way to embed a SwiftUI view (`Content`)
/// into the input view of a `UITextField`. This is useful for custom keyboards or input views that require
/// more complex layouts than the default system keyboards.
///
/// - Parameter Content: The type of the SwiftUI view that will be used as the custom keyboard.
///
/// ## Usage
/// To use `CustomKeyboard`, create an instance with a SwiftUI view that you want to display as the keyboard.
/// Pass this instance to a `TextField` or `SecureField` using the `inputView` method.
///
/// Example:
/// ```swift
/// TextField("Enter OTP", text: $otpCode)
///     .inputView(keyboardType: .customRandomDigits) {
///         CustomKeyboard(keyboardContent: CustomKeyboardView())
///     }
/// ```
///
struct CustomKeyboard<Content: View>: UIViewRepresentable {
    
    // MARK: - Variables
    
    /// The custom SwiftUI view to be used as the keyboard content.
    ///
    /// This view will be displayed as the input view for the `UITextField` or `SecureField`.
    var keyboardContent: Content
    
    /// A hosting controller that manages the SwiftUI view.
    ///
    /// This is used to embed the SwiftUI view into the UIKit view hierarchy.
    @State private var hostingController: UIHostingController<Content>?
    
    /// Creates and returns a new instance of `UIView`.
    ///
    /// This method is called by SwiftUI when creating the `UIView` that will be used to host the custom keyboard.
    ///
    /// - Parameter context: The context in which the view is created.
    /// - Returns: An empty `UIView` that will serve as a container for the custom keyboard view.
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    /// Updates the `UIView` with the current state of the SwiftUI view.
    ///
    /// This method is called whenever the SwiftUI view or its properties change. It ensures that the custom keyboard
    /// is correctly updated and assigned to the `UITextField` or `SecureField`.
    ///
    /// - Parameters:
    ///   - uiView: The `UIView` instance to be updated.
    ///   - context: The context in which the update is performed.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let textFiledCon = uiView.superview?.superview {
                if let textFiled = textFiledCon.findTextField {
                    if textFiled.inputView == nil {
                        hostingController = UIHostingController(rootView: keyboardContent)
                        hostingController?.view.frame = .init(origin: .zero, size: hostingController?.view.intrinsicContentSize ?? .zero)
                        textFiled.inputView = hostingController?.view
                    } else {
                        hostingController?.rootView = keyboardContent
                    }
                }
            }
        }
    }
}
