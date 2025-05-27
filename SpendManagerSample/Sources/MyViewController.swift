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
    
    var captureFlowCoordinator: CaptureFlow.Coordinator?
    
    /// Sets to true when SDK was started. For demo UI, not related to Sensibill SDK integration
    var isStarted = false
    
    override func viewDidLoad() {
        setAppearance()
    }
    
    @IBAction func onFullStartSdkClick(_ sender: Any) {
        if !isStarted {
            startSDK()
        } else {
            stopSDK()
        }
    }
    
    @IBAction func onFullStartSmClick(_ sender: Any) {
        if DemoConfig.startUIModalInsteadOfPush {
            startUIModal(navigationIntent: DemoConfig.navigationIntent)
            return
        }
        
        startUIByPush(navigationIntent: DemoConfig.navigationIntent)
    }
    
    @IBAction func onFullCaptureFlowClick(_ sender: Any) {
        startCaptureFlow()
    }
    
    @IBAction func onCaptureLaunchClick(_ sender: Any) {
        
        if !DemoConfig.useCustomSdkBranding &&
            !DemoConfig.useAdvancedRuntimeSettingsForCapture {
            launchCaptureWithDefaultBranding()
        } else {
            launchCaptureWithCustomBranding()
        }
    }
}
