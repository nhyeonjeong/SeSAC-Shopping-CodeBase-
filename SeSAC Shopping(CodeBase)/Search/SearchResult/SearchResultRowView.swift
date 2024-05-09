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
            AsyncImage(url: URL(string: item.image))
                .clipped()
                .aspectRatio(contentMode: .fill)
                .border(.red)
                .frame(maxWidth: .infinity, maxHeight: 200)
            
            Text(item.mallName)
            Text(item.title)
            Text(item.lprice)
            
        }
    }
}

#Preview {
    SearchResultRowView(item: Item(title: "title", link: "", image: "", lprice: "price", mallName: "mallName", productId: ""))
}
