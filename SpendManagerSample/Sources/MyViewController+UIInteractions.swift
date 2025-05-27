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
        
        resultsInfo.text = info
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
    
    /// Show the provided transaction
    func formatTransactionForDisplay(_ transaction: SBLTransaction) -> String {
        
        // Transaction status
        var result = "\(transaction.localID): \(transaction.status.description) ("
        
        // Transaction remote ID. Only available when image was uploaded
        if let remoteID = transaction.remoteID {
            result += " remoteId=\(remoteID) "
        }
        
        // Transaction
        if let receiptID = transaction.receiptID {
            result += " receiptID=\(receiptID) "
        }
        
        result += ")\n"
        
        return result
    }
    
    /// Show the transactions in given array
    func showTransactions(_ transactions: [SBLTransaction]) {
        
        var result = "Status at \(Date()):\n"
        
        transactions.forEach { transaction in
            result += formatTransactionForDisplay(transaction)
        }
        
        showInfo(result)
    }
}
