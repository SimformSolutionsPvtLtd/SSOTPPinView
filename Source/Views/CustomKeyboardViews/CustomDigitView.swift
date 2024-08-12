//
//  CustomDigitView.swift
//  Example
//
//  Created by Pranay Patel on 31/05/24.
//

import SwiftUI

struct CustomDigitView: View {
    
    @ObservedObject var viewModel: SSOTPPinViewModel
    @ObservedObject var notifier: SSOTPPinViewNotifier

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<3) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { column in
                            let index = row * 3 + column
                            if (index < ((notifier.keyBoardType == .customRandomDigitsType) ? viewModel.remdomDigits.count : viewModel.digits.count)) {
                                Button {
                                    viewModel.otpCode += (notifier.keyBoardType == .customRandomDigitsType) ? "\(viewModel.remdomDigits[index])" : "\(viewModel.digits[index])"
                                } label: {
                                    Text((notifier.keyBoardType == .customRandomDigitsType) ? "\(viewModel.remdomDigits[index])" : "\(viewModel.digits[index])")
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
                            viewModel.otpCode += (notifier.keyBoardType == .customRandomDigitsType) ? "\(viewModel.remdomDigits[9])" : "\(viewModel.digits[9])"
                        } label: {
                            Text((notifier.keyBoardType == .customRandomDigitsType) ? "\(viewModel.remdomDigits[9])" : "\(viewModel.digits[9])")
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
