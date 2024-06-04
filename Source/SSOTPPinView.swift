//
//  SSOTPPinView.swift
//  SSOTPPinView
//
//  Created by Pranay Patel on 03/11/23.
//

import SwiftUI
import Combine

public struct SSOTPPinView: View {
    
    var completion: ((String) -> Void)
    enum FocusField: Hashable {
        case field
    }
    
    @FocusState private var focusedField: FocusField?
    var type: TextFieldType = .OTP_VIEW_TYPE_UNDERLINE
    var numberOfCount: Int = 6
    var keyboardType: KeyBoardType = .customRandomDigitsType
    @State var isShowingCustomKeyboard = false
    
    //MARK: Observed Object
    @ObservedObject private var notifier = SSOTPPinViewNotifier()
    @ObservedObject var viewModel: SSOTPPinViewModel
    
    public init(textFieldType: TextFieldType, numberOfCount: Int, keyboardOptions: KeyBoardType = .numberPadType, commit: @escaping (String)->() = { _ in }) {
        self.type = textFieldType
        self.numberOfCount = numberOfCount
        self.keyboardType = keyboardOptions
        self.viewModel = SSOTPPinViewModel()
        self.completion = commit
    }
    
    private var ssOTPTextFiled: some View {
        return TextField("", text: $viewModel.otpCode)
            .inputView(keyboardType: keyboardType) {
                CustomDigitView(viewModel: self.viewModel, notifier: notifier)
            }
            .frame(width: 0, height: 0, alignment: .center)
            .font(Font.system(size: 0))
            .accentColor(.blue)
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
                self.notifier.keyBoardType = self.keyboardType
            }
            .padding()
    }
    
    private var ssOTPSecureFieldTextFiled: some View {
        return SecureField("", text: $viewModel.otpCode)
            .inputView(keyboardType: keyboardType) {
                CustomDigitView(viewModel: self.viewModel, notifier: notifier)
            }
            .frame(width: 0, height: 0, alignment: .center)
            .font(Font.system(size: 0))
            .accentColor(.blue)
            .foregroundStyle(.blue)
            .multilineTextAlignment(.center)
            .keyboardType(getKeyBoard(type: self.keyboardType))
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
                self.notifier.keyBoardType = self.keyboardType
            }
            .padding()
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            if notifier.isSecureTextEntry {
                ssOTPSecureFieldTextFiled
            } else {
                ssOTPTextFiled
            }
            
            HStack {
                ForEach(0..<self.numberOfCount, id: \.self) { index in
                    ZStack {
                        Text(viewModel.getOTPPin(at: index))
                            .font(notifier.font)
                            .fontWeight(notifier.fontWeight)
                            .foregroundStyle(notifier.textColor)
                        if type == .OTP_VIEW_TYPE_CRICLE {
                            Circle()
                                .stroke(notifier.lineColor, lineWidth: notifier.lineWidth)
                                .onTapGesture {
                                    if viewModel.otpCode.count == numberOfCount {
                                        self.focusedField = .field
                                    }
                                }
                        } else if type == .OTP_VIEW_TYPE_BOX {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(notifier.lineColor, lineWidth: notifier.lineWidth)
                                .frame(width: notifier.strokeWidth, height: notifier.strokeHeight)
                                .onTapGesture {
                                    if viewModel.otpCode.count == numberOfCount {
                                        self.focusedField = .field
                                    }
                                }
                        } else if type == .OTP_VIEW_TYPE_UNDERLINE {
                            Rectangle()
                                .frame(height: notifier.lineWidth)
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

//MARK: Other Property Funcation
extension SSOTPPinView {
    /// Sets the secure text entry for TextField.
    public func isSecureTextEntry(_ isSecure: Bool) -> Self {
        notifier.isSecureTextEntry = isSecure
        viewModel.isSecureTextEntry = isSecure
        return self
    }
    
    /// Sets the secure text type.
    public func secureTextType(_ type: SecureType) -> Self {
        viewModel.secureTypeText = type
        notifier.secureTextType = type
        return self
    }
}

//MARK: Text Property Funcation
@available(iOS 15.0, *)
extension SSOTPPinView {
    /// Sets the text color.
    public func textColor(_ color: Color) -> Self {
        notifier.textColor = color
        return self
    }

    /// Sets the text font.
    public func textFont(_ font: Font) -> Self {
        notifier.font = font
        return self
    }
    
    /// Sets the text fontWeight.
    public func fontWeight(_ fontWeight: Font.Weight) -> Self {
        notifier.fontWeight = fontWeight
        return self
    }
    
    /// Sets the stroke width.
    public func strokeWidth(_ width: CGFloat) -> Self {
        notifier.strokeWidth = width
        return self
    }
    
    /// Sets the stroke height.
    public func strokeHeight(_ height: CGFloat) -> Self {
        notifier.strokeHeight = height
        return self
    }

}

//MARK: Custom Keyboard Property
@available(iOS 15.0, *)
extension SSOTPPinView {
    
    /// Sets the Custom Keyboard background color
    public func keyboardBackgroundColor(_ color: Color) -> Self {
        notifier.keyboardBackgroundColor = color
        return self
    }
    
    /// Sets the Custom Keyboard digit font color
    public func keyFontColor(_ color: Color) -> Self {
        notifier.keyFontColor = color
        return self
    }
    
    /// Sets the Custom Keyboard key stroke color
    public func keyStrokeColor(_ color: Color) -> Self {
        notifier.keyStrokeColor = color
        return self
    }
    
}

//MARK: Line Property Funcation
@available(iOS 15.0, *)
extension SSOTPPinView {
    /// Sets the line height.
    public func lineWidth(_ width: CGFloat) -> Self {
        notifier.lineWidth = width
        return self
    }
    
    /// Sets the line color.
    public func lineColor(_ color: Color) -> Self {
        notifier.lineColor = color
        return self
    }

}

