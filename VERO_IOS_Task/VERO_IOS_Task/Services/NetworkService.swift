//
//  NetworkService.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import Foundation
import Combine

class NetworkService: ObservableObject {
    private let baseURL = URL(string: "https://api.baubuddy.de/dev/index.php/v1/tasks/select")!
    internal var accessToken: String?

    func authenticate(username: String, password: String) -> AnyPublisher<Void, Error> {
        let authorizationURL = URL(string: "https://api.baubuddy.de/index.php/login")!
        var request = URLRequest(url: authorizationURL)
        request.httpMethod = "POST"
        request.setValue("Basic QVBJX0V4cGxvcmVyOjEyMzQ1NmlzQUxhbWVQYXNz", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: AuthorizationResponse.self, decoder: JSONDecoder())
            .map { [unowned self] response in
                self.accessToken = response.oauth.access_token
            }
            .eraseToAnyPublisher()
    }

    func fetchTasks() -> AnyPublisher<[Task], Error> {
        guard let accessToken = accessToken else {
            return Fail(error: NetworkError.unauthorized)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: baseURL)
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.unauthorized
                }
                print(data)
                return data
            }
            .decode(type: [Task].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case unauthorized
}
