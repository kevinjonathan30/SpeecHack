//
//  AnalyticsCardView.swift
//  MC2
//
//  Created by Angelica Roseanne on 13/06/21.
//

import SwiftUI

struct AnalyticsCardView: View {
    
    @State var result:RecordingLog
    
    var body: some View {
        
        VStack {
            HStack {
                VStack{
//                    HStack {
                    Text(result.name).font(.body).fontWeight(.semibold).padding(.top)
                    
//                    }
//                    HStack {
//                        Text(result.date).font(.caption2)
//                            .foregroundColor(Color(hex: "999999"))
//                        Spacer()
//                    }
                }
                Spacer()
                
                if result.isVideo == true {
                    VStack{
                        Image(systemName: "camera.fill").resizable().aspectRatio(contentMode: .fit).foregroundColor(.white).frame(width: 15, height: 15)
                    }.frame(width: 28, height: 37, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(hex: "0A4293")).cornerRadius(8, corners: [.bottomLeft, .bottomRight]).padding(.horizontal)
                }else{
                    VStack{
                        Image(systemName: "camera.fill").resizable().aspectRatio(contentMode: .fit).foregroundColor(.white).frame(width: 15, height: 15)
                    }.frame(width: 28, height: 37, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(hex: "0A4293")).cornerRadius(8, corners: [.bottomLeft, .bottomRight]).padding(.horizontal).opacity(0)
                }
                
            }.padding([.top, .leading])
            HStack{
                Spacer()
                Spacer()
                Group {
                    HStack {
                        VStack{
                            Text("Pace").font(.caption).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                            if result.mode == 0{
                                if result.pace < 101 {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18")))
                                } else if result.pace > 149 {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18")))
                                } else {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("07BA09")))
                                }
                            }
                            if result.mode == 1{
                                if result.pace < 121 {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18")))
                                } else if result.pace > 149 {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18")))
                                } else {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("07BA09")))
                                }
                            }
                            if result.mode == 2{
                                if result.pace < 151 {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18")))
                                } else if result.pace > 159 {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("F43D18")))
                                } else {
                                    Text(String(result.pace) + " wpm").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: String("07BA09")))
                                }
                            }
                            
                            Spacer()
                        }.frame(alignment:.leading)
                        Divider().background(Color(hex: "484848")).frame(height:40)
                    }.frame(height: 50)
                }
                Group {
                    HStack {
                        VStack{
                            Text("Tone").font(.caption).fontWeight(.bold)
                            Spacer()
                            Text(result.tone).font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: "FBA311"))
                            Spacer()
                        }
                        Divider().background(Color(hex: "484848")).frame(height:40)
                    }.frame(height: 50)
                }
                Group {
                    HStack {
                        VStack{
                            Text("Filler").font(.caption).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                            Text(result.fillers + "  words").font(.callout).fontWeight(.semibold).foregroundColor(Color(hex: "FBA311"))
                            Spacer()
                        }
                        Spacer()
                    }.frame(height: 50)
                }
//                Group {
//                    VStack {
//
//                        Spacer()
//                        HStack{
//                            Text("09:51").padding(.horizontal)
//                            Button(action: {
//                            }){
//                                Image(systemName: "chevron.right")
//                            }
//                        }.font(.caption)
//                        .foregroundColor(Color(hex: "999999"))
//                        Spacer()
//                    }
//                }.frame(width: 100)
            }.padding(.bottom)
            
            
        }
        .frame(width: UIScreen.main.bounds.size.width - 36, height:100, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
    }
}


struct AnalyticsCardView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsCardView(result:   RecordingLog(name: "Student Reps Campaign-2", date: "Jun 05 2021 | 09.41 AM", mode: 0, isVideo: true, pace: 110, tone: "Dynamic", fillers: "7")).previewLayout(.sizeThatFits)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
