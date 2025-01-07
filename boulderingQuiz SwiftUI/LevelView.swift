//
//  LevelView.swift
//  boulderingQuiz SwiftUI
//
//  Created by Kudo Ojiro on 2024/11/19.
//

import SwiftUI

struct LevelView: View {
    @Binding var isActive:Bool
    @Binding var selectCategory:String
    @State var selectLevel:String = "quiz1"
    @State var showQuestionView:Bool = false
    var body: some View {
        VStack {
            Spacer()
            Text("難しさを選択")
                .modifier(LabelModifier())
            Spacer()
            
            VStack (spacing: 40){
                Button {
                    showQuestionView = true
                    selectLevel = "easy"
                } label: {
                    Text("易しい")
                        .modifier(ButtonModifier())
                }
                .font(.system(size: 30))
                Button {
                    showQuestionView = true
                    selectLevel = "difficult"
                } label: {
                    Text("難しい")
                        .modifier(ButtonModifier())
                }
            }
            Spacer()
            HStack{
                Button{
                    isActive = false
                }label: {
                    Text("戻る")
                }
                Spacer()
            }
            .padding()
            .fullScreenCover(isPresented: $showQuestionView) {
                QuestionsView(isActive: $isActive, selectLevel:$selectLevel, selectCategory: $selectCategory)
            }
            
        }
    }//body
}

#Preview {
    @Previewable @State var isActive = false
    @Previewable @State var selectCategory = "basic"
    LevelView(isActive: $isActive, selectCategory: $selectCategory)
}
