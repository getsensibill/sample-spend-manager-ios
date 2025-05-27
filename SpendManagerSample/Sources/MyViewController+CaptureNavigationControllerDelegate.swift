//
//  MyViewController+CaptureNavigationControllerDelegate.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-14.
//

import Sensibill

/// This extension implements `CaptureNavigationControllerDelegate`, required for Standalone Capture invocation
extension MyViewController: CaptureNavigationControllerDelegate {
    
    func captureNavigationController(_ controller: CaptureNavigationController, didFinishCapture result: CaptureResult) {
        
        // Check if any images were captured
        guard let firstImage = result.images.first else {
            showInfo("User ddidn't capture any images, or an error occurred")
            return
        }

        // For this demo, we will just display the first image
        showImage(firstImage)
    }
}
