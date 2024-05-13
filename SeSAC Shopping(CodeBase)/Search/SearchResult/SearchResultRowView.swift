//
//  SearchResultRowView.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/05/09.
//

import SwiftUI

struct SearchResultRowView: View {
    let item: Item
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: item.image)) { image in
                switch image {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .clipped()
                case .failure(_):
                    ProgressView()
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            Text(item.mallName)
            Text(item.title)
            Text(item.lprice)
        }
    }
}

#Preview {
    SearchResultRowView(item: Item(title: "title", link: "", image: "", lprice: "price", mallName: "mallName", productId: ""))
}
