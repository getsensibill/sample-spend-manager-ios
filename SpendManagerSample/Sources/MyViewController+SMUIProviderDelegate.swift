//
//  MyViewController+SMUIProviderDelegate.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-14.
//

import Sensibill

/// This extension implements `SMUIProviderDelegate`, required for Sensibill UI invocation
extension MyViewController: SMUIProviderDelegate {
    
    func didStart(navigationController: UINavigationController) {
 
        showInfo("Sensibill UI was started by push or was embedded.")
        
        // The provided instance of Sensibill UI navigation controller can be preserved if desired,
        // allowing the app to control its lifecycle
    }
    
    func didStart(viewController: UIViewController) {
        
        // The event is provided when the UI is started by a push
        
        showInfo("Sensibill UI was started by creating a view controller")
        
        // The provided instance of the Sensibill UI root view controller can be preserved if desired,
        // allowing the app to control its lifecycle
    }
    
    func willRestart() {
        showInfo("Sensibill UI will restart")
    }
    
    func willTerminate() {
        showInfo("Sensibill UI will be terminated")
    }
    
    func didTerminate() {
        showInfo("Sensibill UI was terminated")
    }
    
    func willStartCaptureFlow() {
        showInfo("Sensibill UI will start capture flow")
    }
    
    func didStartCaptureFlow() {
        showInfo("Sensibill UI started capture flow")
    }
    
    func didFinishCapture(withImages: Bool) {
        showInfo("Sensibill UI finished capture flow \(withImages ? "with" : "without") images")
    }
}
