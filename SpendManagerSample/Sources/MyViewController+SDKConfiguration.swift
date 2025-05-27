//
//  MyViewController+SDKConfiguration.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-14.
//

import Sensibill
import UIKit

/// This extension allows to customize the configuration for Full SDK
extension MyViewController {

    /// Brand colors are assumed to be defined elsewhere for the entire app.
    /// The `customSdkBranding` will be using them for Spend Manager and Capture UI
    private enum BrandColors {
        
        static let orange = UIColor(red: 0.91, green: 0.57, blue: 0.30, alpha: 1.0)
        static let bandaid = UIColor(red: 0.87, green: 0.78, blue: 0.70, alpha: 1.0)
        static let wetashfalt = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
        static let teal = UIColor(red: 0.03, green: 0.46, blue: 0.50, alpha: 1.0)
        static let greysky = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
        static let nightsky = UIColor(red: 0.02, green: 0.02, blue: 0.12, alpha: 1.0)
        static let dryashfalt = UIColor(red: 0.69, green: 0.69, blue: 0.66, alpha: 1.0)
        static let mahogany = UIColor(red: 0.15, green: 0.02, blue: 0.00, alpha: 1.0)
        static let orange2 = UIColor(red: 0.96, green: 0.44, blue: 0.16, alpha: 1.0)
        static let cyan = UIColor(red: 0.00, green: 1.00, blue: 1.00, alpha: 1.0)
    }
    
    /// Custom branding colors for full SDK
    func customSdkBranding() {
        
        let configuration = SDKConfiguration.shared

        // Colors
        configuration.colors.primary = BrandColors.orange
        configuration.colors.primaryVariant = BrandColors.bandaid
        configuration.colors.onPrimary = BrandColors.wetashfalt

        configuration.colors.secondary = BrandColors.teal
        configuration.colors.onSecondary = BrandColors.greysky

        configuration.colors.background = BrandColors.nightsky
        configuration.colors.onBackground = BrandColors.dryashfalt

        configuration.colors.surface = .black
        configuration.colors.surfaceVariant = BrandColors.mahogany
        configuration.colors.onSurface = BrandColors.dryashfalt
        configuration.colors.onSurfaceFocus = BrandColors.orange2

        configuration.colors.error = BrandColors.cyan
        configuration.colors.onError = .white
        
        // Changing fonts for Capture and error screens
        configuration.fonts = SDKConfiguration.FontSet(
            regular: UIFont(name: "AmericanTypewriter", size: 14) ?? .systemFont(ofSize: 14),
            bold: UIFont(name: "AmericanTypewriter-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)
        )

        // Changing Web font for sensibill UI
        configuration.sensibillUI.webFonts.regular = SDKConfiguration.SensibillUIFont(
            family: "Lobster, Times, serif",
            url: "https://fonts.googleapis.com/css2?family=Lobster&display=swap"
        )
        
        // Change Capture feature flags
        configuration.capture.features.enableFlash = false
        configuration.capture.features.maxImages = 2
    }
    
    /// Fine-graned custom colors for Capture experience inside full SDK
    func customThemeForCaptureInSdk() {
        let configuration = SDKConfiguration.shared
        
        // Override the default capture background color
        configuration.capture.theme.captureBackgroundColor = BrandColors.nightsky
        
        // Override brand color with Capture-specific colors
        configuration.capture.theme.capturePreviewDoneButtonBackgroundColor = .blue
        configuration.capture.theme.capturePreviewDoneButtonTextColor = .yellow
        
        // Change some view properties, e.g. Capture button appearance
        configuration.capture.theme.autoCaptureButtonCornerRadius = 5
        configuration.capture.theme.autoCaptureButtonTextColor = .green
    }
}
