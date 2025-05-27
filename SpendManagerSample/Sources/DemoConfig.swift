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
    /// The value must match the selected environment
    static let accessToken = "TOKENVALUE" // TODO: Replace with the valid user access token before running.
    
    /// Cache identifier. Use different values for different user identities, and different accounts (e.g. personal and bussiness accounts).
    /// See documentation for `SensibillSDK.start`
    static let cacheIdentifier = "demo@example.com"
    
    // MARK: - SDK and Capture Configuration Options
    
    /// Allows to specify if the custom branding should be used for full SDK.
    /// You can adjust the settings in `customSdkBranding` function of `MyViewController+SDKConfiguration` extension
    static let useCustomSdkBranding = false
    
    /// Allows to specify if the Capture experience inside full SDK should use a custom theme.
    /// This option can be used on its own, or in combination with `useCustomSdkBranding`
    /// You can adjust the settings in `customThemeForCaptureInSdk` function of `MyViewController+SDKConfiguration` extension
    static let useCustomThemeForCaptureInSdk = false
    
    /// Allows to specify is Standalone Capture should use custom configuration.
    /// Note that Standalone Capture is not related to SDK configuration.
    /// You can adjust the settings in `customConfiguration` function of `MyViewController+CaptureConfiguration` extension
    static let useStandaloneCaptureCustomConfiguration = false
    
    // MARK: - UI Options
    
    /// Defines the presentation method to use when starting Sensibill UI.  If not provided, the default method specified in the SDK will be used.
    static let uiPresentationMethod: SensibillUICoordinator.PresentationMethod? = nil
    
    /// Defines if the Edit Metadata screen should be displayed after the Capture Flow completion
    static let displayMetadataEditAfterCaptureFlow = false
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
