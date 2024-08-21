//
//  View+Extension.swift
//  SSOTPPinViewExample
//
//  Created by Pranay Patel on 04/06/24.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - UIView Extensions

extension UIView {
    
    /// A computed property that returns a flattened array of all subviews of the view.
    ///
    /// This property recursively collects all subviews within the view hierarchy,
    /// including subviews of subviews, into a single array.
    ///
    /// - Returns: An array of all `UIView` instances within the view hierarchy.
    var allSubviews: [UIView] {
        return subviews.flatMap { [$0] + $0.subviews }
    }
    
    /// A computed property that searches for the first `UITextField` in the view hierarchy.
    ///
    /// This property looks through all subviews of the view, including nested subviews,
    /// to find the first instance of `UITextField`. If a `UITextField` is found, it is returned;
    /// otherwise, `nil` is returned.
    ///
    /// - Returns: The first `UITextField` found in the view hierarchy, or `nil` if none is found.
    var findTextField: UITextField? {
        if let textField = allSubviews.first(where: { view in
            view is UITextField
        }) as? UITextField {
            return textField
        }
        return nil
    }
    
}

// MARK: - View Extensions

public extension View {
    
    /// A method that applies a transformation to a `View` and returns the transformed content.
    ///
    /// This method allows you to modify a view by applying a transformation closure,
    /// which returns a new view as its result. It uses a `ViewBuilder` to build the content.
    ///
    /// - Parameter transform: A closure that takes the current view and returns a new view.
    /// - Returns: The result of the transformation closure, which is the modified view.
    func modify<Content>(@ViewBuilder _ transform: (Self) -> Content) -> Content {
        transform(self)
    }
}
