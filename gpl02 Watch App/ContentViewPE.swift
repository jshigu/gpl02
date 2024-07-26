//
//  ContentView.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/03/25.
//


import SwiftUI

struct ContentViewPE: View {
    var body: some View {
        Text("sym. kg, pound, φ")
            .font(.system(size: 16))
            .frame(width:160, height:16, alignment:.leading)
            .offset(x: 0, y: -10)
        
        VStack {
            List {
                
                Text("0.1号  1.814kg   4lb 0.054mm")
                Text("0.15号 2.043kg 4.5lb 0.066mm")
                Text("0.2号  2.270kg   5lb 0.076mm")
                Text("0.3号  2.722kg   6lb 0.094mm")
                Text("0.4号  3.629kg   8lb 0.108mm")
                Text("0.5号  4.536kg 10lb 0.121mm")
                Text("0.6号  5.443kg 12lb 0.132mm")
                Text("0.6号  5.443kg 12lb 0.132mm")
                Text("0.8号  5.443kg 12lb 0.132mm")
                Text("1号    9.07kg  20lb 0.171mm")
                Text("1.2号 10.90kg  24lb 0.191mm")
                Text("1.5号 13.62kg  30lb 0.209mm")
                Text("1.7号 15.44kg  34lb 0.219mm")
                Text("2号   18.16kg  40lb 0.242mm")
                Text("2.5号 22.70kg  50lb 0.270mm")
                Text("3号   24.97kg  55lb 0.296mm")
                Text("4号   27.24kg  60lb 0.342mm")
                Text("5号   36.32kg  80lb 0.382mm")
                Text("6号   40.86kg  90lb 0.418mm")
                Text("8号   45.40kg 100lb 0.483mm")
                Text("10号  59.02kg 130lb 0.540mm")
                
            }
            .environment(\.defaultMinListRowHeight, 16 )
            
        }
        .padding()
        .background(Color(red: 0.1, green: 0.15, blue: 0.0))
    }
}

#Preview {
  ContentViewPE()
}
