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
    
    /// Obtain a `Branding` for Sensibill SDK based on `DemoConfig` setting
    var branding: Branding {
        
        guard DemoConfig.useCustomSdkBranding else {
            // Return a default branding
            return Branding()
        }
        
        let branding = Branding()
        
        // Customize the branding to your needs:
        // This method provides the integrator with the easy way to customize
        // * Colors and fonts, consistently for all elements
        // * Icons and images for each element
        // * Localizaion strings and the way the localizations are obtained
        branding.colors = CustomColors()
        branding.fonts = CustomFonts()
        branding.images = CustomImages()
        
        return branding
    }
}
