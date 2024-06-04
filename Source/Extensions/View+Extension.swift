//
//  View+Extension.swift
//  SSOTPPinViewExample
//
//  Created by Pranay Patel on 04/06/24.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    
    var allSubviews: [UIView] {
        return subviews.flatMap { [$0] + $0.subviews }
    }
    
    var fintTextField: UITextField? {
        if let textField = allSubviews.first(where: { view in
            view is UITextField
        }) as? UITextField {
            return textField
        }
        return nil
    }
    
}

public extension View {
    func modify<Content>(@ViewBuilder _ transform: (Self) -> Content) -> Content {
        transform(self)
    }
}
