//
//  MyViewController+UIInteractions.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-15.
//

import Foundation
import Sensibill
import UIKit

/// This extension provides functions for Demo UI, not related to Sensibill SDK integration
extension MyViewController {
    
    /// Set the colors of the UI, based on selected branding
    func setAppearance() {
        
        // Own colors
        self.view.backgroundColor = UIColor(branding.colors.surface)
        self.view.tintColor = UIColor(branding.colors.primary)
        
        // Navigation bar
        UIBarButtonItem.appearance().tintColor = UIColor(branding.colors.onPrimary)
    }
    
    func adjustButtons(fullStartSdkLabel: String? = nil, fullStartSmEnabled: Bool? = nil, fullCaptureFlowEnabled: Bool? = nil, captureLaunchEnabled: Bool? = nil) {
        
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.adjustButtons(fullStartSdkLabel: fullStartSdkLabel, fullStartSmEnabled: fullStartSmEnabled, fullCaptureFlowEnabled: fullCaptureFlowEnabled, captureLaunchEnabled: captureLaunchEnabled)
            }
            return
        }
        
        if let fullStartSdkLabel {
            fullStartSdk.setTitle(fullStartSdkLabel, for: .normal)
        }
        
        if let fullStartSmEnabled {
            fullStartSm.isEnabled = fullStartSmEnabled
        }
        
        if let fullCaptureFlowEnabled {
            fullCaptureFlow.isEnabled = fullCaptureFlowEnabled
        }
        
        if let captureLaunchEnabled {
            captureLaunch.isEnabled = captureLaunchEnabled
        }
    }
    
    func showInfo(_ error: Error) {
        showInfo(error.localizedDescription)
    }
    
    func showInfo(_ info: String) {
        
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.showInfo(info)
            }
            return
        }
        
        resultsImage.isHidden = true
        resultsInfo.isHidden = false
        
        let previousText = resultsInfo.text ?? ""
        resultsInfo.text = "\(info)\n\(previousText)"
    }
    
    func showImage(_ image: Data) {
        
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.showImage(image)
            }
            return
        }
        
        resultsInfo.isHidden = true
        resultsImage.isHidden = false
        
        resultsImage.image = UIImage(data: image)
    }
}
