//
//  APlayerView.swift
//  AnonAPITask
//
//  Created by DeNNiO   G on 07.06.2021.
//

import SwiftUI
import AVKit

struct APlayerView: View {
    @State private var audioPlayer:
        AVPlayer?
    @State var soundPath: String
    @State var isOn = false
    var body: some View {
        ZStack {
            Button(action: {
                self.isOn.toggle()
                self.audioPlayer?.play()
            }) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(isOn ? 0 : 1)
            
            Spacer()
            
            Button(action: {
                    self.isOn = false
                    self.audioPlayer?.pause()
            }) {
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(isOn ? 1 : 0)
        }
        .onAppear {
            self.audioPlayer = try? AVPlayer(url: URL(safeString: soundPath))
            self.isOn = true
            self.audioPlayer?.play()
        }
    }
}


struct APlayerView_Previews: PreviewProvider {
    static var previews: some View {
        APlayerView(soundPath: "")
    }
}
