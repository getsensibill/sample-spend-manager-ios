//
//  CustomColors.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-16.
//

import Sensibill
import SwiftUI

/// Demonstrates the implementation of `BrandingColorsProvider`
class CustomColors: BrandingColorsProvider {
    
    /// Branding colors could be defined elsewhere, and in any way (e.g. constants, resources)
    private enum BrandingColors {
        
        static let orange = Color(red: 0.91, green: 0.57, blue: 0.30)
        static let bandaid = Color(red: 0.87, green: 0.78, blue: 0.70)
        static let wetashfalt = Color(red: 0.13, green: 0.13, blue: 0.13)
        static let teal = Color(red: 0.03, green: 0.46, blue: 0.50)
        static let greysky = Color(red: 0.93, green: 0.93, blue: 0.93)
        static let nightsky = Color(red: 0.02, green: 0.02, blue: 0.12)
        static let dryashfalt = Color(red: 0.69, green: 0.69, blue: 0.66)
        static let mahogany = Color(red: 0.15, green: 0.02, blue: 0.00)
        static let orange2 = Color(red: 0.96, green: 0.44, blue: 0.16)
        static let cyan = Color(red: 0.00, green: 1.00, blue: 1.00)
    }
    
    // MARK: - Define Branding Colors
    
    var primary: Color { BrandingColors.orange }
    var primaryVariant: Color { BrandingColors.bandaid }
    var onPrimary: Color { BrandingColors.wetashfalt }
    
    var secondary: Color { BrandingColors.teal }
    var onSecondary: Color { BrandingColors.greysky }
    
    var background: Color { BrandingColors.nightsky }
    var onBackground: Color { BrandingColors.dryashfalt }
    
    var surface: Color { .black }
    var surfaceVariant: Color { BrandingColors.mahogany }
    var onSurface: Color { BrandingColors.dryashfalt }
    var onSurfaceFocus: Color { BrandingColors.orange2 }
    
    var error: Color { BrandingColors.cyan }
    
    var captureBackground: Color { .white }
    var onCaptureBackground: Color { .black }
}
