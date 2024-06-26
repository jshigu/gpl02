//
//  ContentView.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/03/25.
//


import SwiftUI

struct ContentView: View {
  
  var body: some View {
    VStack {
      NavigationStack {
                Text("釣行に便利")
                  .font(.system(size: 20))
          Form {
              NavigationLink {
                  ContentViewTide()
              } label: {
                  Text("Tide 潮汐")
                      .padding()
              }
 
              NavigationLink {
                  ContentViewNylon()
              } label: {
                  Text("ナイロン,フロロ\n変換表")
                      .padding()
              }
              
              NavigationLink {
                  ContentViewOmori()
              } label: {
                  Text("オモリ変換表")
                      .padding()
              }
              
              NavigationLink {
                  ContentViewPE()
              } label: {
                  Text("PE　変換表")
                      .padding()
              }
          }
        .padding()
        .background(Color(red: 0.1, green: 0.15, blue: 0.0))
      }
    }
  }
}

#Preview {
    ContentView()
}
