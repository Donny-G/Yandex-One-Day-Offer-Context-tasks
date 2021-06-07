//
//  AllPagesView.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import SwiftUI

enum ViewType {
    case showAll, mostPopular, mostCommented, createdAt
}

struct AllPagesView: View {
    let type: ViewType
    
    var title: String {
        switch type {
        case .showAll:
            return "All"
        case .mostPopular:
            return "Most Popular"
        case .mostCommented:
            return "Most Commented"
        case .createdAt:
            return "Created At"
        }
    }
    
    @ObservedObject var anoFeed = AnonDataFetcher(url: Endpoint.noFilter.url)
    
    var body: some View {
        NavigationView {
            List(anoFeed.anoItems) { article in
                NavigationLink(destination: DetailView(contents: article.contents, author: article.author)) {
                    SingleItemView(type: article.type, isCommentable: article.isCommentable, hasAdultContent: article.hasAdultContent, language: article.language, createdAt: article.createdAt, isSecret: article.isSecret, isMyFavorite: article.isMyFavorite, name: article.author.name)
                        .onAppear {
                            if !self.anoFeed.endOfList {
                                if self.anoFeed.shouldLoadMore(articleItem: article) {
                                    self.anoFeed.fetchData()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
        }
    }
}

struct AllPagesView_Previews: PreviewProvider {
    static var previews: some View {
        AllPagesView(type: .showAll)
    }
}
