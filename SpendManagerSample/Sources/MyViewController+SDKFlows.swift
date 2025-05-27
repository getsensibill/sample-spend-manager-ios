//
//  MyViewController+SDKFlows.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-15.
//

import Sensibill

/// This extension demonstrates implementation of various SDK flows
extension MyViewController {
    
    // MARK: - Full SDK
    
    /// Full SDK demo - start SDK
    func startSDK() {
        
        // Ensure the token was provided
        do {
            try DemoConfig.ensureTokenPlaceholderReplaced()
        } catch {
            self.showInfo(error)
            return
        }
        
        // Initialize token provider
        let tokenProvider = CustomTokenProvider()
        
        let configuration = DemoConfig.useCustomSdkBranding ?
            SensibillSDK.Configuration(environment: DemoConfig.environment, branding: branding) :
            SensibillSDK.Configuration(environment: DemoConfig.environment)
        
        // Start SDK. Variation with call back is used here
        // The async variation is available as well
        SensibillSDK.start(
            userIdentifier: DemoConfig.userIdentifier,
            tokenProvider: tokenProvider,
            configuration: configuration
        ) { result in
            switch result {
                
            case .failure(let error):
                self.showInfo("Error starting Sensibill SDK: \(error.localizedDescription)")
                
            case .success:
                
                // Start interacting with the SDK
                // For example, allow to click "Start Spend Manager" button to start UI
                self.isStarted = true
                self.showInfo("Sensibill SDK started successfully. Click Start Spend Manager button to see the UI")
                self.adjustButtons(
                    fullStartSdkLabel: MyViewController.labelWhenSDKStarted,
                    fullStartSmEnabled: true,
                    fullCaptureFlowEnabled: true,
                    captureLaunchEnabled: false
                )
                
                // Only if planning to use Capture Flow:
                // start observing uploads right after SDK startup, so we don't want to miss any updates
                // once receipts start uploading
                self.startUploadObservation()
            }
        }
    }
    
    /// Full SDK demo - stop SDK
    func stopSDK() {
        
        // Only if planning to use Capture Flow: stop observing uploads
        stopUploadObservation()
        
        // In this example, we won't invalidate the token. In production app, it's best to invalidate it.
        SensibillSDK.stop(invalidateToken: false) { error in
            
            // Locally stop always succeeds
            self.isStarted = false
            self.adjustButtons(
                fullStartSdkLabel: MyViewController.labelWhenSDKStopped,
                fullStartSmEnabled: false,
                fullCaptureFlowEnabled: false,
                captureLaunchEnabled: true
            )
            
            if let error {
                self.showInfo("Error stopping Sensibill SDK: \(error.localizedDescription)")
                return
            }
            
            // Returned to original state, where different demo scenarios are available
            self.showInfo("Sensibill SDK was stopped")
        }
    }

    /// Start Sensibill UI by pushing to navigation controller
    func startUIByPush(navigationIntent: SMUI.UIProvider.NavigationIntent?) {
        
        showInfo("Starting Sensibill UI by push")
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.startUIByPush(navigationIntent: navigationIntent)
            }
            return
        }
        
        // To start by push, navigation controller must be available
        guard let navigationController else {
            showInfo("Cannot start Sensibill UI by push - no navigation controller")
            return
        }
        
        // Receive UI events
        SensibillSDK.shared.smui.delegate = self
        
        // Start Sensibill UI
        // Note that with this method the navigation bar is completely owned by a Navigation Controller / the hosting app
        SensibillSDK.shared.smui.start(
            pushTo: navigationController,
            navigationIntent: navigationIntent,
            animated: DemoConfig.startUIAnimated
        )
    }
    
    /// Start Sensibill UI by modally
    func startUIModal(navigationIntent: SMUI.UIProvider.NavigationIntent?) {
        
        showInfo("Starting Sensibill UI modally")
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.startUIModal(navigationIntent: navigationIntent)
            }
            return
        }
        
        // Receive UI events
        SensibillSDK.shared.smui.delegate = self
        
        guard let modalProperties = DemoConfig.startUIModalProperties else {
            // Start Sensibill UI with default properties
            SensibillSDK.shared.smui.start(
                modalOver: self,
                navigationIntent: navigationIntent,
                animated: DemoConfig.startUIAnimated
            )
            return
        }
        
        // Start Sensibill UI with the provided properties
        SensibillSDK.shared.smui.start(
            modalOver: self,
            navigationIntent: DemoConfig.navigationIntent,
            animated: DemoConfig.startUIAnimated,
            modalProperties: modalProperties
        )
    }

    /// Start Sensibill UI on Edit Metadata screen for Capture Flow
    func startUIOnEditMetadataScreen(_ sourceIds: [String]) {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.startUIOnEditMetadataScreen(sourceIds)
            }
            return
        }
        
        // The startup is the same as before, but we need to provide the `SMUI.UIProvider.NavigationIntent`
        // with the correct page and local IDs
        if DemoConfig.startUIModalInsteadOfPush {
            startUIModal(navigationIntent: .metadataEdit(localIds: sourceIds))
            return
        }
        
        startUIByPush(navigationIntent: .metadataEdit(localIds: sourceIds))
    }
    
    /// Starts capture flow
    func startCaptureFlow() {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.startCaptureFlow()
            }
            return
        }
        
        let coordinator = CaptureFlow.Coordinator(host: self)
        coordinator.delegate = self
        coordinator.start()
        self.captureFlowCoordinator = coordinator
    }
    
    // MARK: - Standalone Capture

    /// Standalone Capture demo - launch capture with default config
    func launchCaptureWithDefaultBranding() {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.launchCaptureWithDefaultBranding()
            }
            return
        }
        
        // NOTE: If no entitlements added, as explained in the docs, the attempt to present captureNavigationController will crash the demo app with exception:
        // This app has crashed because it attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain an NSCameraUsageDescription key with a string value explaining to the user how the app uses this data.
        
        let captureNavigationController = Capture.NavigationController()
        captureNavigationController.modalPresentationStyle = .overFullScreen
        captureNavigationController.captureDelegate = self
        present(captureNavigationController, animated: true, completion: nil)
    }
    
    /// Standalone Capture demo - launch capture with custom config
    func launchCaptureWithCustomBranding() {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.launchCaptureWithCustomBranding()
            }
            return
        }
        
        // Whether to use advanced customization, based on a flag
        let selectedRuntimeSettings = DemoConfig.useAdvancedRuntimeSettingsForCapture ? advancedRuntimeSettings : runtimeSettings

        let captureNavigationController = Capture.NavigationController(settings: selectedRuntimeSettings)
        captureNavigationController.modalPresentationStyle = .fullScreen
        captureNavigationController.captureDelegate = self
        present(captureNavigationController, animated: true, completion: nil)
    }
}
