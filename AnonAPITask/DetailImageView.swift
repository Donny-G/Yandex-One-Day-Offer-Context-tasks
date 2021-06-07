//
//  DetailImageView.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import SwiftUI

struct DetailImageView: View {
    @ObservedObject var imageLoader: ImageFetcher
    @State private var animate = false
        
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .cornerRadius(20)
                    .shadow(radius: 2, x: 5, y: 5)
                  
            } else {
                LinearGradient(gradient: Gradient(colors: [.white, .black, .gray]), startPoint: .bottom, endPoint: .top)
                    .cornerRadius(20)
                    .shadow(radius: 2, x: 5, y: 5)
                    .overlay(
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .rotationEffect(Angle(degrees: animate ? 60 : -60))
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                                    self.animate = true
                                }
                        }
                    )
            }
        }
    }
}

struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(imageLoader: ImageFetcher (url: URL(string: "https://dbxatn2gtxtid.cloudfront.net/00/f3/33/QdvWEdTTtUyhiyyvNqwXp_640x481.jpg")))
      
    }
}


