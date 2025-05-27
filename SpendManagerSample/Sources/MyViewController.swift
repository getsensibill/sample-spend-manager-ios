//
//  MyViewController.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-14.
//

import UIKit
import Sensibill

class MyViewController: UIViewController {
    
    static let labelWhenSDKStopped = "Start Sensibill SDK"
    static let labelWhenSDKStarted = "Stop Sensibill SDK"


    @IBOutlet var fullStartSdk: UIButton!
    @IBOutlet var fullStartSm: UIButton!
    @IBOutlet var fullCaptureFlow: UIButton!
    
    @IBOutlet var captureLaunch: UIButton!
    
    @IBOutlet var resultsInfo: UITextView!
    @IBOutlet var resultsImage: UIImageView!
    
    /// Instance of Sensibill UI
    var sensibillUICoordinator: SensibillUICoordinator?
    
    /// Instance of Capture Flow Coordinator
    var captureFlowCoordinator: CaptureFlowCoordinator?
 
    /// Sets to true when SDK was started. For demo UI, not related to Sensibill SDK integration
    var isStarted = false
    
    @IBAction func onFullStartSdkClick(_ sender: Any) {
        if !isStarted {
            startSDK()
        } else {
            stopSDK()
        }
    }
    
    @IBAction func onFullStartSmClick(_ sender: Any) {
        
        guard let presentationMethod = DemoConfig.uiPresentationMethod else {
            startUIWithDefaultPresentationMethod()
            return
        }
        
        startUIWithProvidedPresentationMethod(presentationMethod)
    }
    
    @IBAction func onFullCaptureFlowClick(_ sender: Any) {
        startCaptureFlow()
    }
    
    @IBAction func onCaptureLaunchClick(_ sender: Any) {
        
        if !DemoConfig.useStandaloneCaptureCustomConfiguration {
            launchCaptureWithDefaultConfiguration()
        } else {
            launchCaptureWithCustomConfiguration()
        }
    }
}
