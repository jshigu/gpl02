//
//  ContentView.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/03/25.
//


import SwiftUI

struct ContentView: View {
  @State private var selectionValue = 1

  var body: some View {
    VStack {
      Text("変換表")
      NavigationStack {
        
        VStack{
          
          NavigationLink {
            ContentViewNylon()
          } label: {
            Text("ナイロン,フロロ")
              .padding()
          }
          
          NavigationLink {
            ContentViewPE()
          } label: {
            Text("PE")
              .padding()
          }
  
          NavigationLink {
            ContentViewOmori()
          } label: {
            Text("おもり")
              .padding()
          }

          
        }
        .padding()
      }
    }
  }
}

#Preview {
    ContentView()
}
