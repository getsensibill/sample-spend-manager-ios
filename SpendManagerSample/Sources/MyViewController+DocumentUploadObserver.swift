//
//  MyViewController+TransactionObserver.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-15.
//

import Sensibill

/// This extension demonstrates subscribing and monitoring receipt upload
extension MyViewController: DocumentUploadObserver {
    
    /// A key that defines this observer. For example usage of class name is convenient
    var key: String {
        String(describing: self)
    }
    
    /// Adds itself as a document upload observer for Capture Flow
    func startUploadObservation() {
        SensibillSDK.addObserver(self, for: key)
    }
    
    /// The `DocumentUploadObserver` event
    func onDocumentUploadServiceNotification(
        for sourceId: String,
        payload: DocumentUploadStatusInfo
    ) {
        // For demo purposes just dispaying it
        showInfo("\(sourceId): \(payload.description)")
    }
    
    /// Stop monitoring if neccessary
    func stopUploadObservation() {
        SensibillSDK.removeObserver(forKey: key)
    }
}
