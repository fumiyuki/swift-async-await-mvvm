//
//  WebAPIClient.swift
//  swift-async-await-mvvm
//
//  Created by Fumiyuki Otsuka on 2021/09/08.
//  

import Foundation

final class WebAPIClient {
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }

    func send<R: Request>(request: R) async throws -> R.Response {
        let (data, response) = try await session.data(for: request.buildRequest())
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
                  throw APIError.invalidStatusCode((response as? HTTPURLResponse)?.statusCode)
        }
        
        return try request.decoder.decode(R.Response.self, from: data)
    }
}

