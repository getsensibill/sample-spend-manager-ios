//
//  MyViewController+TransactionObserver.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-15.
//

import Sensibill

/// This extension demonstrates subscribing and monitoring receipt upload
extension MyViewController {
    
    /// Adds itself as a transaction observer for Capture Flow
    func startTransactionObservation() {
        SBDataEvent.sharedManager().addTransactionObserver(self, with: processEvent)
    }
    
    func processEvent(type: SBTransactionEventType, transaction: SBLTransaction?) {
        
        // Only monitor status updates, when transaction is present in monitored array
        guard type == .statusUpdate,
              let transaction else {
            return
        }
        
        // For demo purposes just dispaying it
        showInfo(formatTransactionForDisplay(transaction))
    }
    
    /// Stop monitoring if neccessary
    func stopTransactionObservation() {
        SBDataEvent.sharedManager().clear()
    }
}
