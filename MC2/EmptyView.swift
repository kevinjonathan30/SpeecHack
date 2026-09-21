//
//  EmptyView.swift
//  MC2
//
//  Created by Angelica Roseanne on 14/06/21.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack{
            Spacer()
            Image("em").resizable().aspectRatio(contentMode: .fit).frame(width:140, height:140)
            Text("Your File is Empty").font(.title2).fontWeight(.bold)
            Text("Your conversational file will appear here").font(.footnote).foregroundColor(Color(hex: "3C3C43")).opacity(0.5)
            Spacer()
        }.frame(width: .infinity, height: .infinity, alignment: .center)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
