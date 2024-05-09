//
//  SearchResultViewModel.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/05/09.
//

import Foundation
import Combine

final class SearchResultViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    var page = 1 // page는 1부터 시작
    @Published var output = Output(searchResult: Search(total: 0, start: 0, display: 0, items: []))
    
    init() {
        transform()
    }
    func fetchSearchText(query: String, group: Group) async throws {
        do {
            output.searchResult = try await Network.shared.requestAPI(query: query, sort: group, page: page) //보라색 오류..
        } catch {
            //
        }
    }
}

extension SearchResultViewModel {
    struct Input {
        var viewOnAppear = PassthroughSubject<(String, Group), Never>()
    }
    struct Output {
        var searchResult: Search
    }
    func transform() {
        input.viewOnAppear
            .sink {[weak self] searchText, category in
                guard let self else { return } // 이거 있으니까 잘되는 이유가 뭐임???????
                Task {
                    try? await self.fetchSearchText(query: searchText, group: category)
                }
            }.store(in: &cancellables)
    }
}
