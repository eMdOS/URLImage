import Foundation
import Combine

public extension URLImage {
    final class DataLoader: ObservableObject {
        @Published public private(set) var data: Data = .init()

        let url: URL?
        let session: URLSession
        let queue: DispatchQueue

        public init(url: URL?, session: URLSession = .shared, queue: DispatchQueue = .global()) {
            self.url = url
            self.session = session
            self.queue = queue
        }

        private var disposables: Set<AnyCancellable> = []
    }
}

public extension URLImage.DataLoader {
    func download() {
        guard let url = url else {
            return
        }

        session
            .dataTaskPublisher(for: url)
            .subscribe(on: queue)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { data in
                self.data = data
            })
            .store(in: &disposables)
    }

    func cancel() {
        disposables
            .forEach { $0.cancel() }
    }
}
