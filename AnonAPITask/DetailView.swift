//
//  DetailView.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import SwiftUI
import AVKit

extension URL {
    public init(safeString string: String) {
        guard let instance = URL(string: string) else {
            print(string)
            fatalError("Unconstructable URL: \(string)")
        }
        self = instance
    }
}




struct DetailView: View {
    @State private var player : AVPlayer?
    
    var contents: [Content]
    var author: Author
    
        var genderImage: String {
            switch author.gender {
            case Gender.male.rawValue:
                return "mustache.fill"
            case Gender.other.rawValue:
                return "ear.fill"
            case Gender.unset.rawValue:
                return "questionmark.circle.fill"
            default:
                return "tortoise.fill"
            }
        }
    
    
    var body: some View {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(author.name)
                            .font(.system(size: 23, weight: Font.Weight.black, design: Font.Design.rounded))
                        
                        HStack {
                            Text("Gender :")
                            Image(systemName: genderImage)
                                .padding(.trailing, 10)
                            
                            Image(systemName: "suit.heart.fill")
                            Text(":  \(author.statistics.likes)")
                                .padding(.trailing, 10)
                            
                            Image(systemName: "hand.thumbsup.fill")
                            Text(":  \(author.statistics.thanks, specifier: "%g")")
                        }
                        .foregroundColor(.secondary)
                        .font(.system(size: 15, weight: Font.Weight.black, design: Font.Design.rounded))
                    }
                    
                    ForEach(0 ..< contents.count) { index in
                        if let value = contents[index].data.value{
                            Text(value)
                                .font(.system(size: 20, weight: Font.Weight.black, design: Font.Design.rounded))
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 2)
                                        .shadow(radius: 1, x: 3, y: 3)
                                )
                                .padding()
                        }
                    }
            
                    ForEach(0 ..< contents.count) { index in
                        if !(contents[index].data.small?.url.isEmpty ?? true) {
                            if let imageID = contents[index].id, let imagePath = contents[index].data.original?.url {
                                DetailImageView(imageLoader: ImageCacheLoader.shared.loaderFor(id: imageID, url: URL.init(safeString: imagePath)))
                                    .scaledToFit()
                                    .padding()
                            }
                        }
                    }
                        
                    ForEach(0 ..< contents.count) { index in
                        if contents[index].type == MMType.audio.rawValue {
                            if let trackPath = contents[index].data.url {
                                APlayerView(soundPath: trackPath)
                            }
                        }
                    }
                    
                }
        
        ForEach(0 ..< contents.count) { index in
            if !(contents[index].data.url?.isEmpty ?? true) && contents[index].type == MMType.video.rawValue {
                if let videoPath = contents[index].data.url {
                    VideoPlayer(player: AVPlayer(url: URL(safeString: videoPath)))
                        .cornerRadius(20)
                        .padding()
                        .shadow(radius: 1, x: 3, y: 3)
                }
            }
        }
    }
}
          

        
