//
//  CustomTFKeyboard.swift
//  Example
//
//  Created by Pranay Patel on 30/05/24.
//

import SwiftUI

struct SetTFKeyboard<Content: View>: UIViewRepresentable {
    
    var keyboardContent: Content
    @State private var hostingController: UIHostingController<Content>?
    
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let textFiledCon = uiView.superview?.superview {
                if let textFiled = textFiledCon.fintTextField {
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
