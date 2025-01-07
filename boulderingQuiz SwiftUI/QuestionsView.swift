//
//  Questions.swift
//  boulderingQuiz SwiftUI
//
//  Created by Kudo Ojiro on 2024/11/11.
//

import SwiftUI
import Foundation


struct QuestionsView: View {
    
    //遷移関係
    @Binding var isActive:Bool
    @State var isShowScoreView:Bool = false
    
    //正誤関係
    @State var isShowAnswer = false
    @State var isShowJudgeImage = false
    @State var buttonBool = false
    
    //judge image
    @State var judgeImageName = "circlebadge"
    @State var judgeImageColor = Color.red
    
    //クイズ関係
    @Binding var selectLevel:String
    @Binding var selectCategory:String
    @State var quizCount = 0
    @State var correctCount = 0
    @State var shuffledCSVArray:[String] = []
    @State var quizArray: [String]  = []
    @State var shuffledQuizArray:[String] = []
    
    @State var csvArray = loadCSV(fileName: "basic-easy")
    
    
    
    
    var body: some View {
        
        ZStack {
            VStack {
                
                quizHeader
                quizQuestion
                Spacer()
                answerOptions
                Spacer().frame(height: 50)
                navigationButton
            }
            .padding()
            .onAppear {
                initializeQuiz()
            }
            .onChange(of: quizCount) {
                updateQuiz()
            }
            
            .fullScreenCover(isPresented: $isShowScoreView) {
                ScoreView(isActive: $isActive, correctCount: $correctCount)
            }
            
            VStack{
                Spacer().frame(height: 150)
                if isShowJudgeImage {
                    judgeImageOverlay
                }
                Spacer()
                if isShowAnswer {
                    answerFeedback
                }
                
            }

        }
    }
    
}

extension QuestionsView {
    private var quizHeader: some View{
        Text("第\(quizCount+1)問")
            .padding()
            .font(.title)
            .frame(width: UIScreen.main.bounds.width*0.8)
            .background(Color.primaryColor)
            .foregroundStyle(.white)
            .fontWeight(.heavy)
    }
    
    private var quizQuestion: some View {
        Text(quizArray.isEmpty ? "問題を読み込んでいます..." : quizArray[0])
            .font(.title)
            .padding()
    }
    
    private var answerOptions: some View {
        VStack (spacing: 20) {
            ForEach(0..<4, id: \.self) { num in
                Button {
                    handleAnswer(selectedAnswer: shuffledQuizArray[num])
                } label: {
                    Text(quizArray.count > num + 1 ? shuffledQuizArray[num] : "")
                        .frame(width: UIScreen.main.bounds.width*0.8)
                        .frame(height: 54)
                        .background(Color.backgroundColor)
                        .foregroundColor(.white)
                        .font(.title2)
                        .cornerRadius(30)
                }
                .disabled(buttonBool)
            }
        }
    }
    
    private var navigationButton: some View {
        HStack{
            Button{
                isActive = false
            }label: {
                Text("戻る")
            }
            Spacer()
        }
    }
    
    private var judgeImageOverlay: some View {
        Image(systemName: judgeImageName)
            .foregroundStyle(judgeImageColor)
            .font(.system(size: 300, weight: .medium))
    }
    
    private var answerFeedback: some View {
        VStack{
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.subColor)
                    .frame(width: UIScreen.main.bounds.width*0.7)
                    .frame(height: 200)
                    .cornerRadius(20)
                VStack {
                    Text("A：\(quizArray[5])")
                        .font(.title2)
                    Button {
                        proceedToNextQuestion()
                    } label: {
                        Text("次へ")
                            .padding()
                            .foregroundStyle(.white)
                            .frame(height: 50)
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.width*0.4)
                            .background(Color.secondaryColor)
                            .cornerRadius(25)
                    }
                }
            }
            Spacer()
        }
    }
    
}

extension QuestionsView {
    
    private func initializeQuiz() {
        csvArray = loadCSV(fileName: selectCategory+"-"+selectLevel)
        if csvArray.isEmpty {
            print("CSVファイルが空です。")
            return
        }
        shuffledCSVArray = csvArray.shuffled()
        updateQuiz()
    }
    
    private func updateQuiz() {
        quizArray = createQuizArray(n: quizCount)
        shuffledQuizArray = Array(quizArray[1...4]).shuffled()
    }
    
    private func createQuizArray(n:Int) -> [String] {
        shuffledCSVArray[n].components(separatedBy: ",")
    }
    
    private func handleAnswer(selectedAnswer: String) {
        isShowJudgeImage = true
        isShowAnswer = true
        buttonBool = true
        if selectedAnswer == quizArray[5] {
            judgeImageName = "circlebadge"
            judgeImageColor = .red
            correctCount += 1
        } else {
            judgeImageName = "multiply"
            judgeImageColor = Color.blue
        }
    }
    
    private func proceedToNextQuestion() {
        if quizCount == 9 {
            isShowScoreView = true
        } else {
            self.isShowAnswer = false
            isShowJudgeImage = false
            buttonBool = false
            quizCount += 1
        }
    }
}

func loadCSV(fileName: String) -> [String] {
    var csvArray: [String] = []
    guard let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv") else {
        print("エラー: \(fileName).csvが見つかりませんでした。")
        return []
    }
    do {
        let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
        let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
        csvArray = lineChange.components(separatedBy: "\n")
        csvArray.removeLast()
    } catch {
        print("エラー")
    }
    return csvArray
}


#Preview {
    @Previewable @State var isActive = false
    @Previewable @State var selectLevel = ""
    @Previewable @State var selectCategory = ""
    QuestionsView(isActive: $isActive, selectLevel: $selectLevel, selectCategory: $selectCategory)
}
