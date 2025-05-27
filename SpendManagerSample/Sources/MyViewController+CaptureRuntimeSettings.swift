//
//  MyViewController+CaptureRUntimeSettings.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-15.
//

import Sensibill

/// This extension allows to customize the configuration for Standalone Capture
extension MyViewController {

    /// Obtain `RuntimeSettings` for Capture, based on configured branding.
    /// See `MyViewController+Branding.swift` for `branding` configuration.
    var runtimeSettings: Capture.RuntimeSettings {
        return Capture.RuntimeSettings.receipt(branding: branding)
    }
    
    /// The customization which `Branding` allows (demonstrated in `customRuntimeSettings`) should be sufficient in most case.
    /// But what if we want to change some aspects of a specific element in the way different than defined in branding?
    /// In this case, the advanced customization can be done, as shown here
    var advancedRuntimeSettings: Capture.RuntimeSettings {

        // Obtain runtime settings for receipt with default or custom branding
        let advancedRuntimeSettings = runtimeSettings
        
        // Obtain the default style for the desired element
        let defaultModeNormalTheme = advancedRuntimeSettings.captureScreen.modeNormal
        
        // Create a new element theme, using default style for unchanged properties,
        // and custom values for desired properties
        let customModeNormalTheme = Sensibill.Capture.Theme.PickerOption(
            label: defaultModeNormalTheme.label,
            accessibilityLabel: defaultModeNormalTheme.accessibilityLabel,
            accessibilityLabelSelected: defaultModeNormalTheme.accessibilityLabelSelected,
            accessibilityHint: defaultModeNormalTheme.accessibilityHint,
            fontDefinition: defaultModeNormalTheme.fontDefinition,
            fontDefinitionSelected: defaultModeNormalTheme.fontDefinitionSelected,
            backgroundColor: defaultModeNormalTheme.backgroundColor,
            textColor: .green
        )
        
        // Assign a new theme to a corresponding element
        advancedRuntimeSettings.captureScreen.modeNormal = customModeNormalTheme

        return advancedRuntimeSettings
    }
}
