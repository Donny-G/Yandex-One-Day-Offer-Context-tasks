//
//  ImageFetcher.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import Foundation
import SwiftUI
import Combine

class ImageFetcher: ObservableObject {
    @Published var url: URL?
    @Published var image: UIImage?
    
    init(url: URL?) {
        self.url = url
        $url
            .flatMap { (path) -> AnyPublisher<UIImage?, Never> in
               self.fetchImage(for: url) }
            .assign(to: \.image, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private func fetchImage(for url: URL?) -> AnyPublisher <UIImage?, Never> {
        guard url != nil, image == nil else {
            return Just(nil).eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for: url!)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
    
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}



