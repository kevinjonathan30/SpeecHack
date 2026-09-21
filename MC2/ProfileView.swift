//
//  ProfileView.swift
//  MC2
//
//  Created by Angelica Roseanne on 04/06/21.
//

import SwiftUI

struct ProfileView: View {
    @State var name = "Aziz"
    @State var email = "aziz@mail.com"
    @State var edit = 0.0
    @State var profile = 1.0
    @State var isEditing = false
    var body: some View {
        VStack{
            Spacer()
            Image("prof")
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .padding()
                        
            
            Text("Change Photo").font(.title3).foregroundColor(Color(hex: "0A4293")).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).opacity(edit)
            Group{
                Text("Aziz").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text("aziz@mail.com").font(.title2).fontWeight(.semibold)
            }.opacity(profile)
            
            
            
            Group{
               
                
                Form{
                    Section{
                        TextField("Name", text:$name)
                    }
                    
                    Section{
                        TextField("Email", text:$email)
                    }
                }.foregroundColor(.black)
            }.opacity(edit)
            
            if !isEditing{
                Button(action: {
                    print("edit")
                    edit = 1.0
                    profile = 0.0
                    isEditing.toggle()
                },label:{
                    Text("Edit Profile")
                        .frame(width: UIScreen.main.bounds.size.width - 60, height: 45, alignment: .center)
                        .background(Color(hex: "0A4293"))
                        .cornerRadius(29.5)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                })
            }else{
                Button(action: {
                    print("save")
                    edit = 0.0
                    profile = 1.0
                    isEditing.toggle()
                },label:{
                    Text("Done")
                        .frame(width: UIScreen.main.bounds.size.width - 60, height: 45, alignment: .center)
                        .background(Color(hex: "0A4293"))
                        .cornerRadius(29.5)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                })
            }
            
            
            Group {
                Button(action: {
                    print("signOut")
                },label:{
                    Text("Sign Out")
                        .frame(width: UIScreen.main.bounds.size.width - 60, height: 45, alignment: .center)
                        .background(Color(hex: "FF1C00"))
                        .cornerRadius(29.5)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.bottom, 50)
            })
            }.opacity(profile)
            
            
            Spacer()
        }.background(Color(hex: "EEEEEE"))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
