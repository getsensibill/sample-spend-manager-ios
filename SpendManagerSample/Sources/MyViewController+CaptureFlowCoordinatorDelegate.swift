//
//  MyViewController+CaptureFlowCoordinatorDelegate.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-15.
//

import Sensibill

/// This extension implements `CaptureFlowCoordinatorDelegate`, required for Capture Flow invocation
extension MyViewController: CaptureFlowCoordinatorDelegate {
    
    func coordinatorDidFinishCapture(
        _ coordinator: Sensibill.CaptureFlow.Coordinator,
        result: Sensibill.CaptureFlow.ProcessingInfo
    ) {
        showInfo("Capture flow finished. Will monitor uploads for \(result.sourceIds)")
        
        // Release a preserved instance of the coordinator
        self.captureFlowCoordinator = nil
        
        // We can also start Sensibill UI on Edit Metadata screen with the provided transaction
        if DemoConfig.displayMetadataEditAfterCaptureFlow {
            startUIOnEditMetadataScreen(result.sourceIds)
        }
    }

    func coordinatorDidCancelCapture(_ coordinator: CaptureFlow.Coordinator) {
        
        showInfo("Capture flow was cancelled")
        
        // Release a preserved instance of the coordinator
        self.captureFlowCoordinator = nil
        
        // Transaction monitoring is not neccessary
        stopUploadObservation()
    }
}
