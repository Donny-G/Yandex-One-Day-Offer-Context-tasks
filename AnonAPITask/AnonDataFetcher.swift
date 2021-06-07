//
//  AnonDataFetcher.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import Foundation
import SwiftUI
import Combine

enum PageStatus {
    case ready (nextCursor: String)
    case loading (cursor: String)
    case done
}

enum MyError: Error {
    case limitError
    case httpError
}

enum Endpoint {
    static let startURL = "https://k8s-stage.apianon.ru/posts/v1/posts"
    case noFilter
    case mostPopular
    case mostCommented
    case createdAt
    
    var url: String {
        switch self {
        case .noFilter:
            return Endpoint.startURL.appending("?after=")
        case .mostCommented:
            return Endpoint.startURL.appending("?orderBy=mostCommented&after=")
        case .createdAt:
            return Endpoint.startURL.appending("?orderBy=createdAt&after=")
        case .mostPopular:
            return Endpoint.startURL.appending("?orderBy=mostPopular&after=")
        }
    }
}

class AnonDataFetcher: ObservableObject {
    @Published var anoItems = [Item]()
    @Published var contents = [Content]()
    @Published var endOfList = false
    
    var prevCursor = ""
    var pageStatus = PageStatus.ready(nextCursor: "")
    var url: String
    
    var cancellable: Set<AnyCancellable> = Set()
    
    init(url: String) {
        self.url = url
        fetchData()
    }
    
    func shouldLoadMore(articleItem : Item) -> Bool{
            
            if let lastId = anoItems.last?.id{
                if articleItem.id == lastId{
                    return true
                }
                else{
                    return false
                }
            }
            
            return false
    }
    
    func fetchData() {
        guard case let .ready(nextCursor) = pageStatus else { return }
        pageStatus = .loading(cursor: nextCursor)
        
        URLSession.shared.dataTaskPublisher(for: URL(string: "\(url)\(nextCursor)")!)
            .tryMap{ output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw MyError.httpError
                }
                return output.data
            }
            .decode(type: AnonStruct.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("completed")
                    break
                case .failure(let error):
                self.pageStatus = .done
                switch  error {
                case MyError.limitError:
                    print("limit error")
                case MyError.httpError:
                    print("http error")
                default:
                    print("some other error")
                    }
                }
                
            }) { response in
               
                if response.data.items.count == 0{
                    self.pageStatus = .done
                } else {
                    self.pageStatus = .ready(nextCursor: response.data.cursor ?? "nil")
                    if response.data.cursor == nil {
                        self.endOfList = true
                    }
                    self.anoItems.append(contentsOf: response.data.items)
                    for content in response.data.items { self.contents.append(contentsOf: content.contents)
                    }
                }
            }
            .store(in: &cancellable)
    }
}



