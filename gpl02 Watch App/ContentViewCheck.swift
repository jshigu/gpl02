//
//  File.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/07/13.
//

//import Foundation
import SwiftUI
import UIKit

struct ContentViewCheck: View {
    //　定義はメインビューで
    //    @State private var selectionStateFlag = [false,false,false,false,false,false,false,false,false,false,false,false]
    //    @State private var selectionValueMono = ["竿", "タモ", "糸,オモリ", "救命胴衣", "浮き", "クーラ", "エサ", "雨具", "レジャマット", "JETBOIL", "扇風機"]
    
    //メインビューから変数配列を受け取る
    @Binding var a: StructA
    
    var body: some View {
        VStack {
            Text("No.  CK   Item")
                .font(.system(size: 16))
                .frame(width:160, height:16, alignment:.leading)
                .offset(x: 0, y: -10)
            List {
                
                ForEach(0 ..< a.selectionValueMono.count, id: \.self) { numVal in
                    HStack{
                        //No.
                        let zeroFillmonth = String(format: "%02d", numVal+1)
                        Text("\(zeroFillmonth) ")
                            .offset(x: 0, y: 0)
                        
                        Toggle(isOn: $a.selectionStateFlag[numVal]) {
                            Text("  \(a.selectionValueMono[numVal])")
                                .font(.system(size: 16))
                                .fontWeight(a.selectionStateFlag[numVal] ? .regular : .heavy)
                                .foregroundColor( a.selectionStateFlag[numVal] ? .white : .white)
                                .padding(.vertical, 12)
                        }
                        .toggleStyle(CheckboxStyle())
                    }
                    .font(.system(size: 16))
                    .frame(width:160, height:15, alignment:.leading)
                    
                }
                //                .frame( height:16)
                
            }
            .environment(\.defaultMinListRowHeight, 20)
            let _ = print("sub ",a.selectionStateFlag)
        }
        .background(Color(red: 0.1, green: 0.15, blue: 0.0))
        
        //        buttonList()
        
    }
    
}

//チェックボックス図形
struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" :
                    "square")
                .foregroundColor(configuration.isOn ? .white : .white)
                .fontWeight(configuration.isOn ? .heavy : .regular)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
            configuration.label
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}



