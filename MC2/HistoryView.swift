//
//  HistoryView.swift
//  MC2
//
//  Created by Angelica Roseanne on 04/06/21.
//

import SwiftUI

struct HistoryView: View {
    
    @State var mode = 0
    
    @State private var showProfileModal = false
    var r = recordingLog
    
    var modes = ["Presentation", "Conversational", "Entertainment"]
    
    var body: some View {
        NavigationView {
                VStack{
                    Picker("mode", selection:$mode){
                        ForEach(0..<modes.count){
                            index in Text(self.modes[index]).tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle()).padding()
                    
                        if mode == 0{
                            ScrollView {
                                ForEach(0..<r.count){
                                    index in
                                    if r[index].mode == 0 {
                                        if r[index].isVideo == true {
                                            NavigationLink(destination: DetailAnalyticsVideoView(rec:r[index]).navigationBarTitle("Analytics").navigationBarTitleDisplayMode(.inline)) {
                                                AnalyticsCardView(result: self.r[index])
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        } else {
                                            NavigationLink(destination: DetailAnalyticsVoiceView(rec:r[index]).navigationBarTitle("Analytics").navigationBarTitleDisplayMode(.inline)) {
                                                AnalyticsCardView(result: self.r[index])
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                        }else if mode == 1 {
                            VStack{
                                Image("em").resizable().aspectRatio(contentMode: .fit).frame(width:140, height:140).padding(.top,150)
                                Text("Your File is Empty").font(.title2).fontWeight(.bold)
                                Text("Your conversational file will appear here").font(.footnote).foregroundColor(Color(hex: "3C3C43")).opacity(0.5)
                                Spacer()
                            }.frame(alignment: .center)
                        }else if mode == 2 {
                            ForEach(0..<r.count){
                                index in
                                if r[index].mode == 2 {
                                    AnalyticsCardView(result: self.r[index])
                                }
                            }
                        }
                        
                    Spacer()
                    
                }
                .background(Color(hex: "EEEEEE"))
                .navigationBarItems(trailing: Button{
                    print("Profile")
                    self.showProfileModal.toggle()
                } label:{
                    Image(systemName: "person.crop.circle")
                        .accentColor(Color(hex: "0A4293"))
                        .font(.largeTitle)
                })
                .navigationBarTitle("Logbook")
                .sheet(isPresented: $showProfileModal) {
                           ProfileView()
                        }
            }
        
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
