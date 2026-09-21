//
//  AnalyticsResultView.swift
//  MC2
//
//  Created by Angelica Roseanne on 10/06/21.
//

import SwiftUI

struct AnalyticsResultView: View {
    @Binding var wpm:Double
    @Environment(\.presentationMode) var presentationMode
    @State var skip = false
    
    @State var pace = 0
    @State var paceMsg = "When presenting, it's best if you are able speak in 100 - 150 wpm. You were speaking in 155 wpm!"
    @State var toneMsg = "When presenting, it's best if you are able speak in 100 - 150 wpm. You were speaking in 155 wpm!"
    @State var label = "Next"
    @State var currentPage = 1
    
    var body: some View {
        ZStack{
            //show pages
             if currentPage == 1{
                if selectedMode.getSelectedIndex() == 0 { ///presentation
                    if wpm < 101 {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "Hmmm....Your speaking average were \(Int(wpm)) wpm. You have to make sure your audience weren’t loosing their focus. A little information for you! When presenting, it’s best to keep your pace between 100 - 150 wpm.", img: "c1")
                    } else if wpm > 149 {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "Ooops! Your speaking average were \(Int(wpm)) wpm. You have to make sure your audience can follow you. When presenting, it’s best to keep your pace between 100 - 150 wpm. Try to add some delays or pauses.", img: "m1")
                    } else {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "GOOD JOB! Your speaking average were \(Int(wpm)) wpm. When presenting, it’s best to keep your pace between 100 - 150 wpm. A little tips for you, mix up those pace to make a great dynamic! you can also add delay, emphisize, and pause to highlight some of your points!", img: "h1")
                    }
                } else if selectedMode.getSelectedIndex() == 1 { ///conversational
                    if wpm < 121 {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "You were speaking \(Int(wpm)) wpm. In a conversation, ideally we speak 120 - 150 wpm. Speak faster!.", img: "c2")
                    } else if wpm > 149 {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "You were speaking \(Int(wpm)) wpm. In a conversation, ideally we speak 120 - 150 wpm. Speak slower!", img: "m2")
                    } else {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "You were speaking \(Int(wpm)) wpm. In a conversation, ideally we speak 120 - 150 wpm. Nice work!", img: "h2")
                    }
                } else if selectedMode.getSelectedIndex() == 2 { ///entertainment
                    if wpm < 151 {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "You were speaking <Number \(Int(wpm)) wpm. When entertaining, it's best if we speak 150 - 160 wpm. Speak faster!", img: "c3")
                    } else if wpm > 159 {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "You were speaking \(Int(wpm)) wpm. When entertaining, it's best if we speak 150 - 160 wpm. Speak slower!", img: "m3")
                    } else {
                        resultView(title: "Your Pace", value: String(Int(wpm)),msg: "You were speaking \(Int(wpm)) wpm. When entertaining, it's best if we speak 150 - 160 wpm. Nice one!", img: "h3")
                    }
                }
             }
             if currentPage == 2{
                if selectedMode.getSelectedIndex() == 0 { ///presentation
                    resultView(title: "Your Filler", value: "7 words, 27 times",msg: "You said fillers in many times. Repeating some filler words is not good. Good job!", img: "h1")
                } else if selectedMode.getSelectedIndex() == 1 { ///conversational
                    resultView(title: "Your Filler", value: "5 words, 15 times",msg: "You said fillers in many times. Repeating some filler words is not good. Good job!", img: "h2")
                } else if selectedMode.getSelectedIndex() == 2 { ///entertainment
                    resultView(title: "Your Filler", value: "9 words, 34 times",msg: "You said fillers in many times. Repeating some filler words is not good. Good job!", img: "h3")
                }
             }
             if currentPage == 3{
                if selectedMode.getSelectedIndex() == 0 { ///presentation
                    resultView(title: "Your Tone", value: "Monotone",msg: "Dynamic tone is really good to keep your audience attention and keep them out of boredom. Nice work, you can keep practicing and explore different tones!", img: "h1")
                } else if selectedMode.getSelectedIndex() == 1 { ///conversational
                    resultView(title: "Your Tone", value: "Dynamic",msg: "Dynamic tone is really good to keep your audience attention and keep them out of boredom. Nice work, you can keep practicing and explore different tones!", img: "h2")
                } else if selectedMode.getSelectedIndex() == 2 { ///entertainment
                    resultView(title: "Your Tone", value: "Dynamic",msg: "Dynamic tone is really good to keep your audience attention and keep them out of boredom. Nice work, you can keep practicing and explore different tones!", img: "h3")
                }
             }
        }.overlay(
            Button(action: {
                withAnimation(.easeInOut){
                    if currentPage < 3{
                        currentPage += 1
                        label = "Next"
                        if currentPage == 3{
                            label = "Done"
                        }
                    }
                    else{
                        skip = true
                        currentPage = 1
                    }
                }
                
            }, label: {
                Text(label)
                    .frame(width: 90, height: 40, alignment: .center)
                    .background(Color(hex: "0A4293"))
                    .cornerRadius(29.5)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            })
            ,alignment: .bottom
            
        ).padding()
        .fullScreenCover(isPresented: $skip) {
            ContentView()
        }
       
    }
}



struct resultView: View{
    
    
    var title: String
    var value:String
    var msg:String
    var img: String
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View{
        VStack{
            
            
            Spacer()
            
            Text(title).font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.top)
            Text(value).font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(Color(hex:"FBA311")).padding()
            
            Text(msg).frame(width: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding().multilineTextAlignment(.center)
            
            Spacer()
            
            Image(img).resizable().aspectRatio(contentMode: .fit
            ).frame(width: 135,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
        }
        
    }
    
}
