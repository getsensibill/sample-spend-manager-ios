//
//  MyViewController+SensibillUICoordinatorDelegate.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-14.
//

import Sensibill

/// This extension implements `SensibillUICoordinatorDelegate`, required for Sensibill UI invocation
extension MyViewController: SensibillUICoordinatorDelegate {
    
    func coordinatorWillTerminateWebUI(_ coordinator: SensibillUICoordinator) {
        showInfo("Sensibill UI is terminated")
        self.sensibillUICoordinator = nil
    }
}
