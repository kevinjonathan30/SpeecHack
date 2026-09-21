//
//  DetailAnalyticsVoiceView.swift
//  MC2
//
//  Created by Kevin Jonathan on 15/06/21.
//

import SwiftUI
import AVKit

struct DetailAnalyticsVoiceView: View {
    @ObservedObject public var audioPlayer = AudioPlayer()
    var rec:RecordingLog
    @State var imagePlayerName = "play.circle.fill"
    var body: some View {
        ScrollView {
            VStack{
                
                Text(rec.name).font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.top)
                Text(rec.date).font(.caption).foregroundColor(Color(hex: "999999"))
                
                HStack {
                    Button(action: {
                        if imagePlayerName == "play.circle.fill" {
                            audioPlayer.replayButtonOnClick()
                            imagePlayerName = "stop.circle.fill"
                        } else {
                            audioPlayer.stopReplayOnClick()
                            imagePlayerName = "play.circle.fill"
                        }
                    }) {
                        Image(systemName: imagePlayerName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(Color(hex: "0A4293"))
                            .padding()
                    }
                }.frame(alignment: .center)
                Group {
                    HStack{
                        Text("Pace").font(.title2).fontWeight(.bold).padding(.horizontal)
                        Spacer()
                    }
                    
                    VStack{
//                            HStack {
//                                Text("Average Pace").font(.footnote).padding([.horizontal,.top])
//                                Spacer()
//                            }
                        HStack {
                            if rec.mode == 0{
                                if rec.pace < 101 {
                                    Text(String(rec.pace) + " words per minute").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18"))).padding(.horizontal)
                                } else if rec.pace > 149 {
                                    Text(String(rec.pace) + " words per minute").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18"))).padding(.horizontal)
                                } else {
                                    Text(String(rec.pace) + " words per minute").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("07BA09"))).padding(.horizontal)
                                }
                            }
                            if rec.mode == 1{
                                if rec.pace < 121 {
                                    Text(String(rec.pace) + " words per minute").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18"))).padding(.horizontal)
                                } else if rec.pace > 149 {
                                    Text(String(rec.pace) + " words per minute").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18"))).padding(.horizontal)
                                } else {
                                    Text(String(rec.pace) + " words per minute").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("07BA09"))).padding(.horizontal)
                                }
                            }
                            if rec.mode == 2{
                                if rec.pace < 151 {
                                    Text(String(rec.pace) + " wpm").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18"))).padding(.horizontal)
                                } else if rec.pace > 159 {
                                    Text(String(rec.pace) + " wpm").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18"))).padding(.horizontal)
                                } else {
                                    Text(String(rec.pace) + " wpm").font(.title).fontWeight(.semibold).foregroundColor(Color(hex: String("07BA09"))).padding(.horizontal)
                                }
                            }
                            Spacer()
                        }
                        Divider().background(Color(hex: "484848")).frame(width:UIScreen.main.bounds.size.width - 30)
                        
                        HStack {
                            Text("Suggestion").font(.footnote).padding(.horizontal)
                            Spacer()
                        }
                        HStack {
                            Text("GOOD JOB! Your speaking average were \(rec.pace) wpm. When presenting, it’s best to keep your pace between 100 - 150 wpm. A little tips for you, mix up those pace to make a great dynamic! You can also add delay, emphisize, and pause to highlight some of your points!").font(.callout).padding(.horizontal).padding(.top,4).padding(.bottom)
                        }
                    }.frame(width: .infinity, height: .infinity)
                }
                
               
                Group {
                    HStack{
                        Text("Tone").font(.title2).fontWeight(.bold).padding(.horizontal)
                        Spacer()
                    }.padding(.top)
                    
                    VStack{
//                            HStack {
//                                Text("Average Tone").font(.footnote).padding([.horizontal,.top])
//                                Spacer()
//                            }
                        HStack {
                            Text(String(rec.tone)).font(.title).fontWeight(.semibold).foregroundColor(Color(hex:"FBA311")).padding(.horizontal)
                            Spacer()
                        }
                        Divider().background(Color(hex: "484848")).frame(width:UIScreen.main.bounds.size.width - 30)
                        
                        HStack {
                            Text("Suggestion").font(.footnote).padding(.horizontal)
                            Spacer()
                        }
                        HStack {
                            Text("Dynamic tone is really good to keep audience's attention and keep them out of boredom. Nice work, you can keep practicing and explore different tones!").font(.callout).padding(.horizontal).padding(.top,4).padding(.bottom)
                            Spacer()
                        }
                    }.frame(width: .infinity, height: .infinity)
                }
                
                Group {
                    HStack{
                        Text("Filler").font(.title2).fontWeight(.bold).padding(.horizontal)
                        Spacer()
                    }.padding(.top)
                    
                    VStack{
//                            HStack {
//                                Text("Filler Detected").font(.footnote).padding([.horizontal,.top])
//                                Spacer()
//                            }
                        HStack {
                            Text(String(rec.fillers) + " words").font(.title).fontWeight(.semibold).foregroundColor(Color(hex:"FBA311"))
                            Spacer()
                        }
                        Divider().background(Color(hex: "484848")).frame(width:UIScreen.main.bounds.size.width - 30)
                        
                        HStack {
                            Text("Fillers detected").font(.footnote)
                            Spacer()
                        }
                        HStack {
                            ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(fillers) { f in
                                                VStack {
                                                    Text(f.total)
                                                        .font(.title)
                                                    Text(f.word)
                                                        .font(.callout)
                                                }
                                                .padding(20)
                                                .background(Color.white)
                                                .cornerRadius(10)
                                            }
                                        }
                                    }
                        }
                    }.frame(width: .infinity, height: .infinity).padding(.horizontal).padding(.bottom,70)
                }
                
                
                
                
            }.background(Color(hex: "EEEEEE")).frame(width: .infinity, height: .infinity)
            
        }
        
        
        
    }
}

struct DetailAnalyticsVoiceView_Previews: PreviewProvider {
    static var previews: some View {
        DetailAnalyticsVoiceView(rec: RecordingLog(name: "Student Reps Campaign-2", date: "Jun 05 2021 | 09.41 AM", mode: 0, isVideo: true, pace: 110, tone: "Dynamic", fillers: "7"))
    }
}
