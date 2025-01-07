//
//  scoreView.swift
//  boulderingQuiz SwiftUI
//
//  Created by Kudo Ojiro on 2024/11/11.
//

import SwiftUI

struct ScoreView: View {
    @Binding var isActive:Bool
    @Binding var correctCount:Int
    
    var body: some View {
        Spacer()
        if correctCount == 10 {
            Text("満点です！")
                .modifier(LabelModifier())
        } else {
            Text("あなたのスコアは\(correctCount)点です")
                .modifier(LabelModifier())
        }
        Spacer()
        Button {
            isActive = false
        } label: {
            Text("戻る")
                .modifier(ButtonModifier())
        }
        Spacer()
        Spacer()
            
    }
}

#Preview {
    @Previewable @State var isActive = false
    @Previewable @State var correctCount = 3
    ScoreView(isActive: $isActive, correctCount: $correctCount)
}
