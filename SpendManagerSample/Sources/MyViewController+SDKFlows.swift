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
        
        // Certificate pinning is no longer supported
        SDKConfiguration.shared.certificatePinningEnabled = false
        
        // Optional customization
        if DemoConfig.useCustomSdkBranding {
            customSdkBranding()
        }
        
        if DemoConfig.useCustomThemeForCaptureInSdk {
            customThemeForCaptureInSdk()
        }
        
        // Start SDK
        SensibillSDK.start(
            tokenProvider: tokenProvider,
            cacheIdentifier: DemoConfig.cacheIdentifier
        ) { error in

            // Check for an error. If an error is returned, interaction with the SDK will not be possible
            guard case .none = error else {
                self.showInfo("Error starting Sensibill SDK: \(error.localizedDescription)")
                return
            }

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
            // start observing transactions right after SDk startup, so we don't want to miss any updates
            self.startTransactionObservation()
        }
    }
    
    /// Full SDK demo - stop SDK
    func stopSDK() {
        
        // Only if planning to use Capture Flow: stop observing transaction
        stopTransactionObservation()
        
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
            
            guard case .none = error else {
                self.showInfo("Error stopping Sensibill SDK: \(error.localizedDescription)")
                return
            }
            
            // Return to original state, where different demo scenarios are available
            self.showInfo("Sensibill SDK was stopped")
        }
    }
    
    /// Start Sensibill UI with the default presentation method
    func startUIWithDefaultPresentationMethod() {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.startUIWithDefaultPresentationMethod()
            }
            return
        }
        
        // Start coordinator
        let coordinator = SensibillUICoordinator(host: self)
        coordinator.delegate = self
        coordinator.start()
        
        // Preserve its instance to avoid it being deallocated
        self.sensibillUICoordinator = coordinator
    }
    
    /// Start Sensibill UI with the provided presentation method
    func startUIWithProvidedPresentationMethod(_ presentationMethod: SensibillUICoordinator.PresentationMethod) {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.startUIWithProvidedPresentationMethod(presentationMethod)
            }
            return
        }
        
        // Start coordinator
        let coordinator = SensibillUICoordinator(host: self, presentationMethod: presentationMethod)
        coordinator.delegate = self
        coordinator.start()
        
        // Preserve its instance to avoid it being deallocated
        self.sensibillUICoordinator = coordinator
    }
    
    func startUIOnEditMetadataScreen(_ transactions: [SBLTransaction]) {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.startUIOnEditMetadataScreen(transactions)
            }
            return
        }
        
        // Tell the UI to start on Edit Metadata screen, and monitor the provided transactions
        let options = SensibillUICoordinator.StartOptions.Builder()
                    .addEditMetadataIntent(withTransactions: transactions)
                    .build()
        
        // Start the UI
        let coordinator = SensibillUICoordinator(host: self)
        coordinator.delegate = self
        
        // Provide the options created above
        coordinator.start(options: options)
        
        // Preserve its instance to avoid it being deallocated
        self.sensibillUICoordinator = coordinator
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
        
        let coordinator = CaptureFlowCoordinator(host: self)
        coordinator.delegate = self
        coordinator.start()
        self.captureFlowCoordinator = coordinator
    }
    
    // MARK: - Standalone Capture

    /// Standalone Capture demo - launch capture with default config
    func launchCaptureWithDefaultConfiguration() {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.launchCaptureWithDefaultConfiguration()
            }
            return
        }
        
        // NOTE: If no entitlements added, as explained in the docs, the attempt to present captureNavigationController will crash the demo app with exception:
        // This app has crashed because it attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain an NSCameraUsageDescription key with a string value explaining to the user how the app uses this data.
        
        let captureNavigationController = CaptureNavigationController()
        captureNavigationController.modalPresentationStyle = .overFullScreen
        captureNavigationController.captureDelegate = self
        present(captureNavigationController, animated: true, completion: nil)
    }
    
    /// Standalone Capture demo - launch capture with custom config
    func launchCaptureWithCustomConfiguration() {
        
        // This flow must run on main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.launchCaptureWithCustomConfiguration()
            }
            return
        }
        
        let configuration = customConfiguration()
        
        let captureNavigationController = CaptureNavigationController(configuration: configuration)
        captureNavigationController.modalPresentationStyle = .fullScreen
        captureNavigationController.captureDelegate = self
        present(captureNavigationController, animated: true, completion: nil)
    }
}
