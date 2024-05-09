//
//  File.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/05/09.
//

import Foundation

// MARK: - Search
struct Search: Codable {
    let total, start, display: Int
    var items: [Item]
}

// MARK: - Item
struct Item: Codable, Hashable {
    let title: String
    let link: String
    let image: String
    let lprice, mallName, productId: String

}
