//
//  MyViewController+CaptureFlowCoordinatorDelegate.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-15.
//

import Sensibill

/// This extension implements `CaptureFlowCoordinatorDelegate`, required for Capture Flow invocation
extension MyViewController: CaptureFlowCoordinatorDelegate {

    func coordinatorDidFinishCapture(_ coordinator: CaptureFlowCoordinator, transactions: [SBLTransaction]) {
        
        showInfo("Capture flow finished. Starting to monitor uploads")
        
        // Release a preserved instance of the coordinator
        self.captureFlowCoordinator = nil
        
        // For demo, report the transactions we obtained
        showTransactions(transactions)
        
        // We can also start Sensibill UI on Edit Metadata screen with the provided transaction
        if DemoConfig.displayMetadataEditAfterCaptureFlow {
            startUIOnEditMetadataScreen(transactions)
        }
    }
    
    func coordinatorDidCancelCapture(_ coordinator: CaptureFlowCoordinator) {
        
        showInfo("Capture flow was cancelled")
        
        // Release a preserved instance of the coordinator
        self.captureFlowCoordinator = nil
        
        // Transaction monitoring is not neccessary
        stopTransactionObservation()
    }
}
