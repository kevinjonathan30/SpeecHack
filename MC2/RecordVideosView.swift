//
//  RecordVideoView.swift
//  MC2
//
//  Created by Angelica Roseanne on 07/06/21.
//

import SwiftUI
import AVFoundation

struct RecordVideosView: View {
    
    @State private var cancelDialog = false
    @State private var saveDialog = false
    @State private var fileName = ""
    @State var isRecording = false
    @State var items = []
    @State var text = "File 01"
    @State var result = false
    @ObservedObject public var mic = MicrophoneMonitor(numberOfSamples: 11)
    var cameraView = CameraView()
    
    @SwiftUI.Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        
        ZStack {
            cameraView
            
            VStack{
                HStack{
                    
                    Spacer()
                    Spacer()
                    
                    //timer
                    Text("00:00")
                        .frame(width: 113, height: 40, alignment: .center)
                        .background(Color(hex: "ADADAD"))
                        .cornerRadius(29.5)
                        .foregroundColor(.white)
                        .clipped()
                        .font(.title2)
                        .padding()
                    
                    Spacer()
                    
                    //camera
                    Button(action: {cameraView.switchCamera()}) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(hex: "ADADAD"))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }.padding()
                }
                
                Spacer()
                Spacer()
                
                HStack {
                    Spacer()
                    
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
                                cameraView.stopRecording()
                                mic.finishRecordOnClick()
                            }
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }), secondaryButton: .cancel(Text("Cancel")))
                    })
                    
                    
                    Spacer()
                    
                    Button {
                        if !isRecording {
                            cameraView.startRecording()
                            do{
                                 mic.recordingButtonOnClick()
                            }
                        } else {
                            cameraView.stopRecording()
                            
                            do{
                                mic.finishRecordOnClick()
                            }
                            print("done")
                            self.saveDialog = true
                        }
                        isRecording.toggle()
                    } label: {
                        Image(systemName: isRecording ? "pause.circle" : "largecircle.fill.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                    }
                    
                    
                    Spacer()
                    Button(action: {
                        print("done")
                        self.saveDialog = true
                    },label:{
                        Text("Done")
                            .frame(width: 90, height: 40, alignment: .center)
                            .background(Color(hex: "0A4293"))
                            .cornerRadius(29.5)
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                    }).opacity(0).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }
            
            
            SaveAlert(title: "Save This File As", isShown: $saveDialog, text: $text, onDone: { text in
                self.items.append(fileName)
                result = true
            }).fullScreenCover(isPresented: $result) {
                AnalyticsResultView(wpm: $mic.wpm)
            }
        }
        
    }
    
    
}

struct RecordVideosView_Previews: PreviewProvider {
    static var previews: some View {
        RecordVideosView()
    }
}

struct SaveAlert: View {
    
    let screenSize = UIScreen.main.bounds
    var title: String = ""
    @Binding var isShown: Bool
    @Binding var text: String
    var onDone: (String) -> Void = { _ in }
    var onCancel: () -> Void = { }
    
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text(title)
                .font(.headline)
            Text("This file must be named before go to the next step.")
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack(spacing: 20) {
                Button("Done") {
                    self.isShown = false
                    self.onDone(self.text)
                }
                Button("Cancel") {
                    self.isShown = false
                    self.onCancel()
                }
            }
        }
        .padding()
        .frame(width: screenSize.width * 0.7, height: screenSize.height * 0.3)
        .background(Color(#colorLiteral(red: 0.9268686175, green: 0.9416290522, blue: 0.9456014037, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: isShown ? 0 : screenSize.height)
        .animation(.spring())
    }
}
