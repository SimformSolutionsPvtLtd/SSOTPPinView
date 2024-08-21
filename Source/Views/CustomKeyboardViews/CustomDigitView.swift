//
//  CustomDigitView.swift
//  Example
//
//  Created by Pranay Patel on 31/05/24.
//

import SwiftUI

/// A custom keyboard view for OTP input, providing a grid of digit buttons, a delete button, and a secure text toggle.
struct CustomDigitView: View {
    
    //MARK: Observed Object
    /// An observed object that manages and publishes changes to the OTP pin view's data and state.
    ///
    /// - **Default Value:** Must be initialized externally with an instance of `SSOTPPinViewModel`
    ///
    /// This object is responsible for handling the OTP code and related functionality, including secure text entry and code formatting.
    @ObservedObject var viewModel: SSOTPPinViewModel
    
    /// An observed object that manages and publishes changes to the OTP pin view's visual and functional properties.
    ///
    /// This object is used to handle and respond to changes in properties related to the appearance and behavior of the OTP pin view.
    @ObservedObject var notifier: SSOTPPinViewNotifier

    /// The body of the view.
    ///
    /// This computed property arranges the custom keyboard into a `ZStack` and `VStack` layout. It uses a grid of buttons for digits,
    /// with additional rows for the delete button and a toggle for secure text entry. The layout and styles are dynamically adjusted
    /// based on the `viewModel` and `notifier` properties.
    ///
    /// - Returns: A `some View` representing the custom digit keyboard.
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<3) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { column in
                            let index = row * 3 + column
                            if (index < ((notifier.keyboardType == .customRandomDigits) ? viewModel.randomDigits.count : viewModel.digits.count)) {
                                Button {
                                    viewModel.otpCode += (notifier.keyboardType == .customRandomDigits) ? "\(viewModel.randomDigits[index])" : "\(viewModel.digits[index])"
                                } label: {
                                    Text((notifier.keyboardType == .customRandomDigits) ? "\(viewModel.randomDigits[index])" : "\(viewModel.digits[index])")
                                        .foregroundStyle(notifier.keyFontColor)
                                        .frame(maxWidth: .infinity)
                                        .frame(maxHeight: .infinity)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(.plain)
                                .frame(maxHeight: .infinity)
                                .frame(maxWidth: .infinity)
                                .background(notifier.keyboardBackgroundColor)
                                .frame(height: 65)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(notifier.keyStrokeColor, lineWidth: 1)
                                )
                            }
                        }
                    }
                }
                
                HStack(spacing: 0) {
                    HStack {
                        Button {
                            if !viewModel.otpCode.isEmpty {
                                viewModel.otpCode.removeLast()
                            }
                        } label: {
                            Image(systemName: "delete.left")
                                .font(.title)
                                .foregroundStyle(notifier.keyFontColor)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(height: 65)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(notifier.keyboardBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(notifier.keyStrokeColor, lineWidth: 1)
                    )
                    
                    HStack {
                        Button {
                            viewModel.otpCode += (notifier.keyboardType == .customRandomDigits) ? "\(viewModel.randomDigits[9])" : "\(viewModel.digits[9])"
                        } label: {
                            Text((notifier.keyboardType == .customRandomDigits) ? "\(viewModel.randomDigits[9])" : "\(viewModel.digits[9])")
                                .foregroundStyle(notifier.keyFontColor)
                                .frame(maxWidth: .infinity)
                                .frame(maxHeight: .infinity)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(height: 65)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(notifier.keyboardBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(notifier.keyStrokeColor, lineWidth: 1)
                    )
                    
                    HStack {
                        Button {
                            viewModel.isSecureTextEntry = !viewModel.isSecureTextEntry
                        } label: {
                            Image(systemName: viewModel.isSecureTextEntry ?  "eye.slash.fill" : "eye.fill")
                                .font(.title)
                                .foregroundStyle(notifier.keyFontColor)
                        }
                        .buttonStyle(.plain)
                    }
                    .frame(height: 65)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(notifier.keyboardBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(notifier.keyStrokeColor, lineWidth: 1)
                    )
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 260)
    }
}
