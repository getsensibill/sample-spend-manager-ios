//
//  CustomTokenProvider.swift
//  SpendManagerSample
//
//  Created by Kiril Strax on 2025-05-14.
//


import Sensibill

class CustomTokenProvider: TokenProvider {

    /// Demo implementation: returns a token set in DemoConfig
    func provideTokenReplacement(completion: @escaping (Credentials?, Error?) -> ()) {
        let credentials = Credentials.init(accessToken: DemoConfig.accessToken)
        completion(credentials, nil)
    }
}

