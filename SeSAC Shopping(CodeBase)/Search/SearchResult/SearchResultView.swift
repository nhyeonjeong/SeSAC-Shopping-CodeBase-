//
//  SearchResultView.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/05/09.
//

import SwiftUI

struct SearchResultView: View {
    @StateObject var viewModel = SearchResultViewModel()
    
    let searchText: String
    var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.output.searchResult.items, id: \.productId) { item in
                        SearchResultRowView(item: item)
                    }
                }
            }
            .navigationTitle(searchText)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                viewModel.input.viewOnAppear.send((searchText, .sim))
            }
        }
    }
}

#Preview {
    SearchResultView(searchText: "반지")
}
