//
//  Network.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/05/09.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noResponse
    case invalidResponse
}
final class Network {
    static let shared = Network()
    
    private init() { }
    func requestAPI(query: String, sort: Group, page: Int) async throws -> Search {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=30&sort=\(sort.getNameString())&start=\((page-1) * 30 + 1)") else {
            throw APIError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        urlRequest.addValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else {
            throw APIError.noResponse
        }
        guard response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        let decodedData = try JSONDecoder().decode(Search.self, from: data)
        print(decodedData)
        return decodedData
    }
}
