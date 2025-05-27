//
//  CustomTokenProvider.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-14.
//


import Sensibill

class CustomTokenProvider: TokenProvider {
    
    /// Demo implementation: returns a token set in DemoConfig
    func provideTokenReplacement(
        userIdentifier: String,
        completion: @escaping (SensibillSDK.Credentials?, (any Error)?) -> Void
    ) {
        let credentials = SensibillSDK.Credentials(accessToken: DemoConfig.accessToken)
        completion(credentials, nil)
    }
}

