//
//  ContentView.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/03/25.
//


import SwiftUI

struct ContentViewOmori: View {

    var body: some View {
      Text("sym.　g, oz")
      VStack {
        List {
          Text("8 G   0.07g  ")
          Text("7 G   0.09g  ")
          Text("6 G   0.12g  ")
          Text("5 G   0.16g  ")
          Text("4 G   0.20g  ")
          Text("3 G   0.25g  ")
          Text("0.5 B 0.27g  ")
          Text("2 G   0.31g  ")
          Text("0.1号 0.375g  1/64 oz")
          Text("1 G   0.4g  ")
          Text("1 B   0.55g  ")
          Text("2 B   0.75g  ")
          Text("0.2号 0.75g  1/32 oz")
          Text("3 B   0.95g  ")
          Text("0.3号 1.13g  ")
          Text("4 B   1.2g  ")
          Text("0.4号 1.5g  ")
          Text("5 B   1.85g  ")
          Text("0.5号 1.875g  1/16 oz")
          Text("0.6号 2.25g  ")
          Text("0.7号 2.625g  ")
          Text("0.8号 3g  ")
          Text("0.9号 3.375g  ")
          Text("1号   3.75g  1/8 oz")
          Text("1.5号 5.625g  ")
          Text("2号   7.5g  1/4 oz")
          Text("3号  11.25g  3/8 oz")
          Text("4号  15g  1/2 oz")
          Text("5号  18.75g  5/8 oz")
          Text("6号  22.5g  3/4 oz")
          Text("7号  26.25g  1  oz")
          Text("8号  30g  ")
          Text("10号 37.5g  ")
          Text("11号 41.25g  1-1/2 oz")
          Text("12号 45g  ")
          Text("15号 56.25g  2 oz")
          Text("20号 75g  ")
          Text("23号 86.25g  3 oz")
          Text("24号 90g  ")
          Text("28号 105g  ")
          Text("30号 112.5g  4 oz")
          Text("40号 150g  ")
          Text("50号 187.5g  ")
          Text("60号 225g  8 oz")
          Text("80号 300g  10 oz")
          Text("100号 375g  12 oz")
        }
        .environment(\.defaultMinListRowHeight, 16 )

        
      }
      .padding()
      .background(Color(red: 0.1, green: 0.15, blue: 0.0))

    }
}

#Preview {
  ContentViewOmori()
}
