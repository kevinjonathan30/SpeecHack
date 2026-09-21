//
//  RecordVoiceView.swift
//  MC2
//
//  Created by Kevin Jonathan on 04/06/21.
//

import SwiftUI

struct RecordVoiceView: View {
    @ObservedObject public var mic = MicrophoneMonitor(numberOfSamples: numberOfSamples)
    @Environment(\.presentationMode) private var presentationMode
    
    // 2
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (200 / 25)) // scaled to max at 300 (our height of our bar)
    }
    
    @State private var cancelDialog = false
    @State var barOpacity : Double = 0;
    @State var doneButtonOpacity : Double = 0;
    @State var imagePlayerName : String = "largecircle.fill.circle"
    @State var showSaveAlert = false
    @State private var saveDialog = false
    @State var items = []
    @State var text = "File 01"
    @State var result = false
    @State private var fileName = ""
    
    var body: some View {
        
        NavigationView {
            ZStack{
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: UIScreen.main.bounds.size.width * 0.25, content: {
                VStack  (alignment: .center, spacing: 10, content: {
                    Text("File - 01").font(.title).bold()
                    Text("May 22 2021 | 09.41 AM").foregroundColor(.gray).fontWeight(.semibold).font(.caption)
                })
                HStack(spacing: 3) {
                    // 4
                    ForEach(mic.soundSamples,id: \.self) { level in
                        BarView(value: self.normalizeSoundLevel(level: level))
                    }
                }.frame(width: 50, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).opacity(barOpacity)
                
                HStack(alignment: .center, spacing: UIScreen.main.bounds.size.width * 0.025, content: {
                    Button(action: {
                        self.cancelDialog = true
                    },label:{
                        Text("Cancel")
                            .frame(width: 90, height: 40, alignment: .center)
                            .background(Color(hex: "ADADAD"))
                            .cornerRadius(29.5)
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    })
                    .alert(isPresented: $cancelDialog, content: {
                        Alert(title: Text("Are You Sure?"), message: Text("The file that you’ve been recording won’t be saved."), primaryButton: .default(Text("Remove").foregroundColor(Color.red), action: {
                            if mic.isRecording == true {
                                mic.finishRecordOnClick()
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }), secondaryButton: .cancel(Text("Cancel")))
                    })
                    Button(action: {
                        if imagePlayerName == "largecircle.fill.circle" {
                            doneButtonOpacity = 1;
                            mic.recordingButtonOnClick()
                            barOpacity = 1;
                            imagePlayerName = "pause.circle"
                        } else if imagePlayerName == "pause.circle" {
                            mic.pauseButtonOnClick()
                            imagePlayerName = "play.circle"
                        } else if imagePlayerName == "play.circle" {
                            do {
                                try mic.resumeButtonOnClick()
                            } catch {
                                print("Error")
                            }
                            imagePlayerName = "pause.circle"
                        }
                    }) {
                        Image(systemName: imagePlayerName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding()
                    }
                    Button(action: {
                        if(doneButtonOpacity == 1) {
                            mic.finishRecordOnClick()
                            self.showSaveAlert = true
                            imagePlayerName = "largecircle.fill.circle"
                            self.saveDialog = true
                        }
                    }) {
                        Text("Done")
                            .frame(width: 90, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(Color.init(red: 0, green: 0.2, blue: 0.6))
                            .cornerRadius(29.5)
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    }.opacity(doneButtonOpacity)
                })
            })
                
                SaveAlert(title: "Save This File As", isShown: $saveDialog, text: $text, onDone: { text in
                    self.items.append(fileName)
                    result = true
                }).fullScreenCover(isPresented: $result) {
                    AnalyticsResultView(wpm: $mic.wpm)
                }
            }
        }.navigationBarHidden(true)
    }
}

struct RecordVoiceView_Previews: PreviewProvider {
    static var previews: some View {
        RecordVoiceView()
    }
}

let numberOfSamples: Int = 20

struct BarView: View {
    // 1
    var value: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.init(red: 0, green: 0.2, blue: 0.6))
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 5) / CGFloat(numberOfSamples), height: value)
        }
    }
}


