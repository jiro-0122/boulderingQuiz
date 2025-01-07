//
//  ContentView.swift
//  boulderingQuiz SwiftUI
//
//  Created by Kudo Ojiro on 2024/11/11.
//

import SwiftUI

struct ContentView: View {
    @State var isActive:Bool = false
    @State var selectCategory:String = "quiz1"
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("ボルダリングクイズ")
                .modifier(LabelModifier())
                
            Spacer()
            VStack (spacing: 30){
                Button {
                    isActive = true
                    selectCategory = "basic"
                } label: {
                    Text("基本")
                        .modifier(ButtonModifier())
                }
                Button {
                    isActive = true
                    selectCategory = "hold"
                } label: {
                    Text("ホールド")
                        .modifier(ButtonModifier())
                }
                
                Button {
                    isActive = true
                    selectCategory = "move"
                } label: {
                    Text("ムーブ")
                        .modifier(ButtonModifier())
                }
                
            }
            Spacer()
            .fullScreenCover(isPresented: $isActive) {
                LevelView(isActive: $isActive, selectCategory: $selectCategory)
            }
        }
        
        
        .padding()
        
    }//body
    
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundStyle(.white)
            .font(.title)
            .frame(width: UIScreen.main.bounds.width*0.6)
            .frame(height: 60)
            .background(Color.primaryColor)
            .fontWeight(.heavy)
            .cornerRadius(10)
    }
}

struct LabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.title)
            .frame(width: UIScreen.main.bounds.width*0.9)
            .background(Color.backgroundColor)
            .foregroundStyle(.white)
            .fontWeight(.heavy)
    }
}




#Preview {
    ContentView()
}
