//
//  MainRecordView.swift
//  MC2
//
//  Created by Angelica Roseanne on 04/06/21.
//

import SwiftUI

struct MainRecordView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    @State var video = false
    @State var voice = false
    
    @State private var showProfileModal = false
    
    var body: some View {
        
        NavigationView {
            VStack{
                HStack{
                    VStack {
                        HStack {
                            Text("Presentation").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        HStack {
                            Text("Business Presentation, School Presentation, etc.").font(.subheadline).foregroundColor(Color(hex:"3C3C43"))
                            Spacer()
                        }
                    }.padding().frame(alignment:.leading)
                    Spacer()
                    Image("presentation").resizable().aspectRatio(contentMode: .fit
                    ).frame(height: 96,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.trailing,20)
                }
                .frame(width: UIScreen.main.bounds.size.width - 36, height:187, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top)
                .onTapGesture {
                    self.showingActionSheet = true
                    selectedMode.setSelectedIndex(index: 0)
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Select Recording Type"), buttons: [
                        .default(Text("Record with Video")) {
                            self.video = true
                        },
                        .default(Text("Record without Video")) {
                            self.voice = true
                        },
                        .cancel()
                    ])
                    
                }
                
                .fullScreenCover(isPresented: $video, onDismiss:
                                    nil
                                 , content: {
                                    RecordVideosView().navigationBarHidden(true)
                                 })
                .fullScreenCover(isPresented: $voice, onDismiss:
                                    nil
                                 , content: {
                                    RecordVoiceView()
                                 })
                //Conversational
                HStack{
                    VStack{
                        HStack {
                            Text("Conversational").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        HStack {
                            Text("Interview, Job Interview, Pitch Selling, etc.").font(.subheadline).foregroundColor(Color(hex:"3C3C43"))
                            Spacer()
                        }
                    }.padding()
                    Spacer()
                    Image("convo").resizable().aspectRatio(contentMode: .fit
                    ).frame(height: 96,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
                }
                .frame(width: UIScreen.main.bounds.size.width - 36, height:187, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .onTapGesture {
                    self.showingActionSheet = true
                    selectedMode.setSelectedIndex(index: 1)
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Select Recording Type"), buttons: [
                        .default(Text("Record with Video")) {},
                        .default(Text("Record without Video")) {},
                        .cancel()
                    ])
                }
                
                //Entertainment
                HStack{
                    VStack {
                        HStack {
                            Text("Entertainment").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                        HStack {
                            Text("Radio Host, Television Talk Show, etc.").font(.subheadline).foregroundColor(Color(hex:"3C3C43"))
                            Spacer()
                        }
                    }.padding()
                    Spacer()
                    Image("enter").resizable().aspectRatio(contentMode: .fit
                    ).frame(height: 96,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding(.trailing,20)
                }
                .frame(width: UIScreen.main.bounds.size.width - 36, height:187, alignment: .leading)
                .background(Color.white)
                .cornerRadius(10)
                .onTapGesture {
                    self.showingActionSheet = true
                    selectedMode.setSelectedIndex(index: 2)
                }
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Select Recording Type"), buttons: [
                        .default(Text("Record with Video")) {},
                        .default(Text("Record without Video")) {},
                        .cancel()
                    ])
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
            .navigationBarTitle("Record")
            .sheet(isPresented: $showProfileModal) {
                       ProfileView()
                    }

        }
    }
}

struct MainRecordView_Previews: PreviewProvider {
    static var previews: some View {
        MainRecordView()
    }
}
