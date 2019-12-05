import SwiftUI

#if canImport(AppKit)
typealias AppImage = NSImage

extension Image {
    init(image: AppImage) {
        self.init(nsImage: image)
    }
}
#else // UIKit
typealias AppImage = UIImage

extension Image {
    init(image: AppImage) {
        self.init(uiImage: image)
    }
}
#endif

public struct URLImage: View {
    let placeholder: Image
    let contentMode: ContentMode

    @ObservedObject private var dataLoader: DataLoader

    public init(url: URL?, placeholder: Image, contentMode: ContentMode = .fit) {
        self.dataLoader = DataLoader(url: url)
        self.placeholder = placeholder
        self.contentMode = contentMode
    }

    public var body: some View {
        if !dataLoader.data.isEmpty, let image = AppImage(data: dataLoader.data) {
            return Image(image: image)
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .onAppear(perform: {})
                .onDisappear(perform: {})
        } else {
            return placeholder
                .resizable()
                .aspectRatio(contentMode: contentMode)
                .onAppear(perform: dataLoader.load)
                .onDisappear(perform: dataLoader.cancel)
        }
    }
}
