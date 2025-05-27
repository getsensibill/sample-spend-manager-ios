//
//  DemoConfig.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-14.
//

import Sensibill

enum DemoConfig {
    
    // MARK: - Authentication
    
    /// **Must change**: User Access Token
    /// Note: the value is provided by your Integration Server, or with the static access token obtained by any other method (e.g. provided by Sensibill)
    /// The value must match the selected `environment`
    static let accessToken = "TOKENVALUE" // TODO: Replace with the valid user access token before running.
    
    /// The Sensibil API environment to connect to.
    /// See documentation for `SensibillSDK.start`
    static let environment: SensibillSDK.Environment = .beta
    
    /// Cache identifier. Use different values for different user identities, and different accounts (e.g. personal and bussiness accounts).
    /// See documentation for `SensibillSDK.start`
    static let userIdentifier = "demo@example.com"
    
    // MARK: - SDK and Capture Branding Options
    
    /// Allows to specify if the custom branding should be used for full SDK and Capture.
    /// You can adjust the settings in `branding` property of `MyViewController+Branding` extension
    static let useCustomSdkBranding = false
 
    /// Allows to specify is Standalone Capture should use advanced customization of the specific elements.
    /// You can adjust the settings in `advancedRuntimeSettings` property of `MyViewController+CaptureRuntimeSettings` extension
    static let useAdvancedRuntimeSettingsForCapture = false
    
    // MARK: - UI Options
    
    /// Defines if the UI should be started modally or by a push to navigation controller
    static let startUIModalInsteadOfPush = false
    
    /// Defines whether Sensibill UI should be started on a specific view. If set to `nil`, the default configured in Sensibill SDK will be used.
    static let navigationIntent: SMUI.UIProvider.NavigationIntent? = nil
    
    /// Defines if the UI should be started animated
    static let startUIAnimated = true
    
    /// Allows to define properties when starting UI modally.
    /// By default the `presentationStyle` is set to `.fullScreen`, and `showLeftNavigationItem` is set to `true`
    /// (which means the exit button is displayed on the navigation bar).
    /// You can set the value to `nil` to allow Sensibill UI use default properties.
    static let startUIModalProperties: SMUI.UIProvider.ModalProperties? = .init(
        presentationStyle: .fullScreen,
        showLeftNavigationItem: true
    )
    
    /// Defines if the Edit Metadata screen should be displayed after the Capture Flow completion
    static let displayMetadataEditAfterCaptureFlow = true
}

extension DemoConfig {
    
    static func ensureTokenPlaceholderReplaced() throws {
        if accessToken == "TOKENVALUE" {
            throw DemoConfig.ConfigError.accessTokenPlaceholder
        }
    }
}

extension DemoConfig {
    enum ConfigError: Error {
        case accessTokenPlaceholder
    }
}

extension DemoConfig.ConfigError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .accessTokenPlaceholder:
            return "Please set user access token before running the demo. See DemoConfig for more information"
        }
    }
}
