//
//  AuthorizationModel.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import Foundation
struct AuthorizationResponse: Decodable {
    let oauth: OAuthResponse
}

struct OAuthResponse: Decodable {
    let access_token: String
}
