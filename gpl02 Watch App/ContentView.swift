//
//  ContentView.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/03/25.
//


import SwiftUI

struct StructA {
    var selectionStateFlag = [false,false,false,false,false,false,false,false,false,false,false,false]
    var selectionValueMono = ["fishing rod", "Net", "Line&Weight", "Life vest", "Float", "Cooler-box", "Bait", "Rain gear", "Picnic mat", "JETBOIL", "electric fan"]
}

struct ContentView: View {
    //「釣行チェック」ボタンの初期表示内容
    @State var viewCheckDayTime: String = "  Pre-Fishing CK"
    //スタート
    @State var isShowAlert = false
    @State var doui:Bool = false
    
    @State var structA = StructA()
    
    
    var body: some View {
        
        if doui == false {
            Button {
                isShowAlert = true
            } label: {
                Text("Before useing")
            }
            .alert( "We cannot be held responsible in any way.\nDo you agree?？", isPresented: $isShowAlert ){
                Button("No."){
                    doui = false
                }
                Button("Yes."){
                    doui = true
                    fishingCheckListIni()
                }
            }
        message: {
//            Text("Please choose")
        }
        }else {
            //            let _ = print("ys10 ",selectionStateFlag)
            VStack {
                NavigationStack {
                    Text(" convenient")
                    //                    .font(.system(size: 20))
                        .font(.system(size: 16))
                        .frame(width:160, height:16, alignment:.leading)
                        .offset(x: 0, y: -20)
                    Form {
                        NavigationLink {
                            ContentViewTide()
                        } label: {
                            Text("Tide")
                                .padding()
                        }
                        
                        NavigationLink("\(viewCheckDayTime)", destination: ContentViewCheck(a: $structA).onDisappear {
                            viewCheckDayTime = viewCheckDayTimeSet()
                            fishingCheckListSet()
                            print("main \(structA.selectionStateFlag)")
                        })
                        
                        NavigationLink {
                            ContentViewNylon()
                        } label: {
                            Text("Fluorocarbon and Nylon Line")
                                .padding()
                        }
                        
                        NavigationLink {
                            ContentViewOmori()
                        } label: {
                            Text("Weight table")
                                .padding()
                        }
                        
                        NavigationLink {
                            ContentViewPE()
                        } label: {
                            Text("Polyethylene Line")
                                .padding()
                        }
                    }
                    .environment(\.defaultMinListRowHeight, 14 )
                    .padding()
                    .onAppear {
                        //                      print("back to Any")
                    }
                }
            }
            .environment(\.defaultMinListRowHeight, 12 )
            .background(Color(red: 0.1, green: 0.15, blue: 0.0))
            
        }
    }
    
    /**
     チェック記録をFishingCheckFlgからとり出す
      - Parameters:なし
      - Returns: なし
    */
    public func fishingCheckListIni()  {
        //UserDefaults.standardに設定されているか確認
        if UserDefaults.standard.object(forKey: "FishingCheckFlg") == nil {
            //はじめて使う場合は設定されてないので初期値を入れる
            UserDefaults.standard.set(structA.selectionStateFlag, forKey: "FishingCheckFlg")
        }else {
            //再起動の場合は、記録されている値を入れる
            structA.selectionStateFlag = UserDefaults.standard.array(forKey: "FishingCheckFlg") as! [Bool]
        }
        let _ = print("ini  ",structA.selectionStateFlag)
    }
    
    //チェック記録をFishingCheckFlgに書き出す
    public func fishingCheckListSet()  {
        UserDefaults.standard.set(structA.selectionStateFlag, forKey: "FishingCheckFlg")
        let _ = print("save ",structA.selectionStateFlag)
    }
    
    //「釣行チェック」ボタンに日付を入れる
    func viewCheckDayTimeSet( ) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let date = Date()
        let month : Int = Int(calendar.component(.month, from: date))
        let day: Int = Int( calendar.component(.day, from: date) )
        let year : Int = Int(calendar.component(.year, from: date))
        let miut : Int = Int(calendar.component(.minute, from: date))
        let hour : Int = Int(calendar.component(.hour, from: date))
        return String(format: "  Pre-Fishing CK\n  %02d/%02d/%02d %02d:%02d", year%100, month, day, hour, miut)
    }
    
    
}

#Preview {
    ContentView()
}


func buttonList() -> some View {
    VStack {
        //右上ボタン ベル
        HStack{
            Spacer()
            Button(
                action: {
//                        bellWiewFlag = bellWiew( flg: bellWiewFlag )
//                        bellSet()
//                        notificationManager.scheduleNotification()
                },
                label: {
                Image(systemName: "bell")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                }
            )
            .frame(width: 25, height: 25)
            .background(Color(red: 0.6, green: 0.5, blue: 0.1))   //背景色
            .cornerRadius(30.0)         //固定値指定にして丸くして
            .offset(x: 0, y: -10)
            
        }
        Spacer()
        HStack{
            //右下ボタン
            Spacer()
            Button(
                action: {
//                        tokeiWiewFlag = tokeiWiew( flg: tokeiWiewFlag )
//                        bellSet()
//                        notificationManager.scheduleNotification()


                }, label: {
                Image(systemName: "doc")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                }
            )
            .frame(width: 25, height: 25)
            .background(Color(red: 0.5, green: 0.6, blue: 0.2))   //背景色
            .cornerRadius(30.0)         //固定値指定にして丸くして
            .offset(x: 0, y: 8)
        }
        
    }
}


