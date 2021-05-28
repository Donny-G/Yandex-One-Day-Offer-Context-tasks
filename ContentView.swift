//
//  ContentView.swift
//  yandex
//
//  Created by DeNNiO   G on 26.05.2021.
//

//B. Let's Try: SwiftUI solution

import SwiftUI

struct ContentView: View {
    @State private var textField = ""
    @State private var animationOn = false
    @State private var color = Color.black
    
    private let hourDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            return formatter
        }()
    private let minutesDateFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "mm"
            return formatter
        }()
    
    var body: some View {
      
        ZStack {
            Rectangle()
                .fill(Color(red: 0.961, green: 0.957, blue: 0.949))
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(Date(), formatter: hourDateFormat)
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .foregroundColor(Color.black)
                    
                    Text(":")
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .foregroundColor(Color.white)
                        .colorMultiply(self.color)
                 
                    Text(Date(), formatter: minutesDateFormat)
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .foregroundColor(Color.black)
                }
            
                ZStack(alignment: .leading) {
                    TextField("", text: $textField)
                        .frame(height: 40)
                        .textFieldStyle(PlainTextFieldStyle())
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                    Text("Y")
                        .font(.system(size: 24))
                        .fontWeight(.light)
                        .foregroundColor(.red)
                        .offset(x: 15)
                }
            }
        }
        .frame(width: 150, height: 150)
        
        Button("Start") {
            withAnimation(Animation.easeOut(duration: 1).repeatForever()) {
                self.color = Color.red
            }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
