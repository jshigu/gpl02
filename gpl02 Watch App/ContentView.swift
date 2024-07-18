//
//  ContentView.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/03/25.
//


import SwiftUI

struct StructA {
    var selectionStateFlag = [false,false,false,false,false,false,false,false,false,false,false,false]
    var selectionValueMono = ["竿", "タモ", "糸,オモリ", "救命胴衣", "浮き", "クーラ", "エサ", "雨具", "レジャマット", "JETBOIL", "扇風機"]
}

struct ContentView: View {
    //「釣行チェック」ボタンの初期表示内容
    @State var viewCheckDayTime: String = "  釣行チェック"
    //スタート
    @State var isShowAlert = false
    @State var doui:Bool = false
    
    @State var structA = StructA()
    
    
    var body: some View {
        
        if doui == false {
            Button {
                isShowAlert = true
            } label: {
                Text("ご利用にあたり")
            }
            .alert( "いかなる損害に責任を負いません\n同意しますか？", isPresented: $isShowAlert ){
                Button("いいえ"){
                    doui = false
                }
                Button("はい"){
                    doui = true
                    fishingCheckListIni()
                }
            }
        message: {
            Text("選択して下さい")
        }
        }else {
            //            let _ = print("ys10 ",selectionStateFlag)
            VStack {
                NavigationStack {
                    Text(" 釣行に便利")
                    //                    .font(.system(size: 20))
                        .font(.system(size: 16))
                        .frame(width:160, height:16, alignment:.leading)
                        .offset(x: 0, y: -20)
                    Form {
                        NavigationLink {
                            ContentViewTide()
                        } label: {
                            Text("Tide 潮汐")
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
    
    //チェック記録をFishingCheckFlgからとり出す
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
        return String(format: "  釣行チェック\n  %02d/%02d/%02d %02d:%02d", year%100, month, day, hour, miut)
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


