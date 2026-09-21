//
//  DetailAnalyticsVideoView.swift
//  MC2
//
//  Created by Angelica Roseanne on 14/06/21.
//

import SwiftUI
import AVKit

struct Filler: Identifiable {
    let id: Int
    let word: String
    let total:String
}

let fillers = [
    Filler(id: 0, word: "Actually", total: "3"),
    Filler(id: 1, word: "Basically", total: "5"),
    Filler(id: 2, word: "Fairly", total: "2"),
    Filler(id: 3, word: "Like", total: "4"),
    Filler(id: 4, word: "Literally", total: "2"),
    Filler(id: 5, word: "Probably", total: "1"),
    Filler(id: 6, word: "Quite", total: "3"),
    Filler(id: 7, word: "So", total: "8"),
    Filler(id: 8, word: "Well", total: "12")
]

let dir = CameraViewController()

struct DetailAnalyticsVideoView: View {
    var rec:RecordingLog
    var body: some View {
            ScrollView {
                VStack{
                    Text(rec.name).font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).padding(.top)
                    Text(rec.date).font(.caption).foregroundColor(Color(hex: "999999"))
                    
                    VideoPlayer(player: AVPlayer(url:  URL(string: dir.getFileURL())!)) {
                    }.aspectRatio(contentMode: .fit).frame(width: 360, height: 480).padding(.horizontal).cornerRadius(10)
                    
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
                        }.frame(width: .infinity, height: .infinity).padding(.horizontal)
                    }
                    Group {
                        HStack{
                            Text("Eye Movement").font(.title2).fontWeight(.bold).padding(.horizontal)
                            Spacer()
                        }.padding(.top,30)
                        
                        VStack{
//                            HStack {
//                                Text("Average Tone").font(.footnote).padding([.horizontal,.top])
//                                Spacer()
//                            }
                            HStack {
                                Text("65 times").font(.title).fontWeight(.semibold).foregroundColor(Color(hex:"FBA311")).padding(.horizontal)
                                Spacer()
                            }
                            Divider().background(Color(hex: "484848")).frame(width:UIScreen.main.bounds.size.width - 30)
                            
                            HStack {
                                Text("Suggestion").font(.footnote).padding(.horizontal)
                                Spacer()
                            }
                            HStack {
                                Text("Your eyes tend to look up 65 times. People will judge you badly if your eyes move a lot. Try to focus on the center!").font(.callout).padding(.horizontal).padding(.top,4).padding(.bottom)
                                Spacer()
                            }.frame(alignment:.leading)
                        }.frame(width: .infinity, height: .infinity)
                    }
                    
                    
                    
                }.background(Color(hex: "EEEEEE")).frame(width: .infinity, height: .infinity)
            }
        
    }
}

struct DetailAnalyticsVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailAnalyticsVideoView(rec: RecordingLog(name: "Student Reps Campaign-2", date: "Jun 05 2021 | 09.41 AM", mode: 0, isVideo: true, pace: 110, tone: "Dynamic", fillers: "7"))
    }
}
