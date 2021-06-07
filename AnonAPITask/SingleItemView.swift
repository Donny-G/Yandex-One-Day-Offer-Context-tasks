//
//  SingleItemView.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import SwiftUI

struct SingleItemView: View {
    var type: ItemType.RawValue
    var typeImage: String {
        switch type {
        case ItemType.plain.rawValue:
            return "newspaper"
        case ItemType.audioCover.rawValue:
            return "headphones"
        case ItemType.video.rawValue:
            return "video.fill"
        default:
            return "questionmark"
        }
    }
    
    var isCommentable: Bool
    var hasAdultContent: Bool
    var language:Language.RawValue
    
    var createdAt: Int
    var date: String {
        let date = Date.init(timeIntervalSince1970: TimeInterval(createdAt/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    
    var isSecret: Bool
    let isMyFavorite: Bool
    var name: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    Image(systemName: "person.fill")
                    Text(name)
                        .font(.system(size: 20, weight: Font.Weight.black, design: Font.Design.rounded))
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                
                )
                .background(LinearGradient(gradient: Gradient(colors: [ .gray, .white]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
                .shadow(radius: 1, x: 3, y: 3)
                VStack {
                    HStack {
                        VStack {
                            Image(systemName: typeImage)
                                .foregroundColor(.red)
                            Text(language)
                        }
            
                        VStack {
                            Image(systemName: isCommentable ? "plus.bubble" : "xmark.seal.fill")
                            Image(systemName: hasAdultContent ? "18.circle" : "16.circle.fill")
                        }
                        VStack {
                            Image(systemName: isSecret ? "eye.slash.fill" : "eye")
                            Image(systemName: isMyFavorite ? "bookmark.fill" : "bookmark.slash.fill")
                        }
                    }
                    Text(date)
                        .lineLimit(0)
                        .font(.system(size: 10, weight: Font.Weight.medium, design: Font.Design.rounded))
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}


struct SingleItemView_Previews: PreviewProvider {
    static var previews: some View {
        SingleItemView(type: ItemType.plain.rawValue, isCommentable: true, hasAdultContent: true, language: Language.ru.rawValue, createdAt: 1622616297000, isSecret: false, isMyFavorite: false, name: "")
    }
}
