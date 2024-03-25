//
//  ContentView.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/03/25.
//


import SwiftUI

struct ContentViewPE: View {
  @State private var selectionValue = 1

    var body: some View {
      Text("号数　ポンド　kg 太さ")
      VStack {
        List {
          Text("0.25号  1.0 lb\n0.45kg 0.083mm")
          Text("0.3 号  1.2 lb\n0.54kg 0.090mm")
          Text("0.25号  1.0 lb\n0.45kg 0.083mm")
          Text("0.3 号  1.2 lb\n0.54kg 0.090mm")
          Text("0.4 号  1.6 lb\n0.73kg 0.104mm")
          Text("0.6 号  2.4 lb\n1.09kg 0.128mm")
          Text("0.8 号  3.0 lb\n1.36kg 0.148mm")
          Text("1.0 号  4.0 lb\n1.81kg 0.165mm")
          Text("1.2 号  4.8 lb\n2.17kg 0.185mm")
          Text("1.5 号  6.0 lb\n2.72kg 0.205mm")
          Text("1.75号  7.0 lb\n3.18kg 0.220mm")
          Text("2.0 号  8.0 lb\n3.63kg 0.235mm")
          Text("2.25号  9.0 lb\n4.08kg 0.248mm")
          Text("2.5 号   10 lb\n4.54kg 0.260mm")
          Text("2.75号   11 lb\n4.99kg 0.274mm")
          Text("3.0 号   12 lb\n5.44kg 0.285mm")
          Text("3.5 号   14 lb\n6.35kg 0.310mm")
          Text("4.0 号   16 lb\n7.26kg 0.330mm")
          Text("5.0 号   20 lb\n9.07kg 0.370mm")
          Text("6.0 号   22 lb\n9.98kg 0.405mm")
          Text("7.0 号   25 lb\n11.3kg 0.435mm")
          Text("8.0 号   28 lb\n12.7kg 0.470mm")
          Text("10  号   35 lb\n15.9kg 0.520mm")


        }

          
        }
        .padding()

    }
}

#Preview {
  ContentViewPE()
}
