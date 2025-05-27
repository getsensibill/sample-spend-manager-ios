//
//  MyViewController+CaptureConfiguration.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-15.
//

import Sensibill

/// This extension allows to customize the configuration for Standalone Capture
extension MyViewController {
    
    func customConfiguration() -> CaptureConfiguration {
        
        // Obtain a default them first
        let defaultTheme = DefaultTheme(overrideBundle: nil)
        
        // Set it as a basis for custom theme
        let captureTheme = CaptureTheme(defaults: defaultTheme)
        
        // Change colors
        captureTheme.captureDocumentTypeButtonTextColor = .green
        captureTheme.capturePreviewTitleColor = .yellow
        
        return CaptureConfigurationBuilder()
                        .add(theme: captureTheme)
                        .build()
    }
}
