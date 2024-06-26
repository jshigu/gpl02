//
//  ContentViewTide.swift
//  gpl02 Watch App
//
//  Created by 世吉 on 2024/06/22.
//


import SwiftUI
import UIKit



struct gridLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint ( x: 10 , y: 10 ) )
        path.addLine(to: CGPoint ( x: 50 , y: 50 ) )
        return path
    }
}

#Preview {
    gridLine()
}


struct ContentViewTide: View {
    let dr = 0.0174532925199433   /*   degree to  radian */
    let rd = 57.29577951308232    /*   radian to degree  */

    @State private var tideWiewFlag: Int = 0       //0:Tide　　    1:List
    
    //LatLon Set
    @State private var tideSelectionValue = 3
    let M = [31,31,28,31,30,31,30,31,31,30,31,30,31]
    let na = [["静岡/舞阪", 34.41, 137.37,  70],
              ["愛知/師崎", 34.42, 136.59, 125],
              ["愛知/武豊", 34.51 ,136.56 ,132],
              ["三重/五ケ所",34.19, 136.40, 103],
              ["三重/鳥羽", 34.29, 136.51, 120],
              ["三重/的矢", 34.22, 136.52, 110],
              ["三重/尾鷲", 34.04, 136.13, 104]
    ]
    let hr  = [
        //"静岡/舞阪"
        [12.60,1.80,1.10,2.10,0.90,2.30,0.40,11.40,0.20,0.40,0.40,5.00,0.30,15.70,0.60,0.20,0.70,0.50,0.40,0.70,0.30,5.10,0.90,0.20,29.70,0.40,1.00,1.00,13.10,0.40,3.70,0.30,0.40,0.30,0.60,0.30,0.70,0.70,0.20,0.30],
        //"愛知/師崎"
        [16.50,0.90,1.10,1.30,1.10,3.80,0.80,17.70,0.40,0.80,0.40,7.70,0.50,23.70,0.30,0.40,1.30,0.40,0.80,1.50,1.90,10.30,1.60,0.50,57.40,0.50,2.00,1.80,26.70,0.10,7.60,0.30,0.40,1.20,0.50,0.40,0.20,0.20,0.20,0.20],
        [15.50,0.40,0.40,1.60,0.40,3.40,0.60,18.00,0.40,1.20,0.50,7.30,0.40,24.00,0.30,0.30,1.30,0.60,0.60,0.90,2.00,10.50,2.00,0.30,60.50,1.10,1.80,1.40,28.50,0.40,8.00,0.40,0.80,1.30,0.90,0.60,0.30,0.10,0.30,0.50],
        [13.00,0.00,0.00,0.00,0.00,0.00,0.00,17.00,0.00,0.00,0.00,6.70,0.00,20.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,45.00,0.00,0.00,0.00,21.00,0.00,5.70,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
        [13.10,1.80,1.40,1.20,0.70,3.50,0.70,17.40,0.40,1.00,0.50,7.50,0.60,23.30,0.20,0.30,1.40,0.30,0.80,1.20,1.70,9.30,1.90,0.20,55.50,0.60,1.80,1.70,25.50,0.30,7.20,0.20,0.70,0.90,0.60,0.50,0.20,0.20,0.10,0.10,],
        [13.00,0.00,0.00,0.00,0.00,0.00,0.00,17.00,0.00,0.00,0.00,7.30,0.00,22.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,44.00,0.00,0.00,0.00,20.00,0.00,5.40,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
        [12.20,1.70,0.70,0.40,0.50,3.50,0.70,17.00,0.20,0.50,0.40,7.10,0.50,22.20,0.30,0.30,1.20,0.20,0.70,1.10,1.10,7.80,1.50,0.10,44.10,0.40,1.40,1.30,19.80,0.10,5.50,0.10,0.00,0.50,0.10,0.20,0.10,0.10,0.00,0.00]
    ]
    let pl =  [
        [161.20,1.80,33.80,20.2,177.90,164.1,157.60,173.5,330.70,195.1,164.40,186.8,339.50,194,228.40,144.8,214.80,31.8,226.20,175.7,218.60,176.2,178.30,159.6,179.60,177.4,187.80,176,204.50,68,196.00,43.5,264.30,178.5,268.10,343.1,264.00,289.6,274.90,302.1],
        [136.50,0.90,68.70,16.9,2.70,155.7,163.00,165.5,231.70,182.8,199.80,183.6,335.10,187.1,249.40,151.3,204.80,263.7,218.10,167.6,194.30,170.7,171.90,195.1,176.50,179.7,188.70,195.2,203.30,65.3,199.10,19.5,251.60,201.1,296.10,54.2,136.50,125.3,180.20,195],
        [140.70,218.7,144.90,46.8,69.10,158.8,152.40,167.4,202.90,131.1,165.80,186.4,320.40,188,95.90,140.4,220.80,314,240.60,181.4,205.40,179.9,175.20,103.4,179.60,165.9,167.80,198.7,206.40,5.6,198.30,9.4,305.80,186.3,289.70,17.2,305.40,280.1,211.30,217.3],
        [166.00,0,0.00,0,0.00,0,0.00,165,0.00,0,0.00,186,0.00,186,0.00,0,0.00,0,0.00,0,000.00,0,00.00,0,166.00,0,000.00,0,190.00,0,190.00,0,0.00,0,0.00,0,000.00,0,0.00,0],
        [159.60,342.4,65.80,30.5,158.80,156.4,155.10,167.4,182.10,229.9,165.60,185.6,22.00,188.2,137.70,160.8,213.60,284.4,223.30,180,191.80,176.2,178.90,328.9,179.50,166.7,179.50,205.7,205.90,21.6,202.20,352,300.00,197.6,292.80,42.3,19.40,52.9,285.50,319.2],
        [160.00,0,0.00,0,0.00,0,0.00,164,0.00,0,0.00,188,0.00,188,0.00,0,0.00,0,0.00,0,000.00,0,00.00,0,171.00,0,000.00,0,199.00,0,199.00,0,0.00,0,0.00,0,000.00,0,0.00,0],
        [161.80,345.3,54.20,22.3,167.60,153.8,155.50,165.2,187.00,202.3,175.80,182.5,40.60,185.5,211.30,165.1,204.60,263.5,227.30,162.4,167.20,165.7,165.20,78.1,170.30,176.4,179.10,192.3,194.50,179.5,189.70,78.5,346.10,170.6,254.20,45,54.30,40.8,181.80,229.8]
    ]
    
    private var tideXY =  [
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
    ]

    
    //Data
    @State private var selectionOffset = 2
 
    
    var body: some View {
        //        Text("Tide 潮汐")
        
        VStack {
            //西暦
            let calendar = Calendar(identifier: .gregorian)
            let date = Date()
            let modifiedDate = Calendar.current.date(byAdding: .day, value: selectionOffset - 2, to: date)!
            
            let month : Int = Int(calendar.component(.month, from: modifiedDate))
            let day: Int = Int( calendar.component(.day, from: modifiedDate) )
            let year : Int = Int(calendar.component(.year, from: modifiedDate))
            
            Text("\(year%100)年\(month)月\(day)日").font(.system(size: 18))
                .offset(x: 0, y: -30 )
            HStack{
                Picker("場所", selection: $tideSelectionValue ) {
                    /// 選択項目の一覧
                    Text("静岡/舞阪").tag(0)
                    Text("愛知/師崎").tag(1)
                    Text("愛知/武豊").tag(2)
                    Text("三重/五ケ所").tag(3)
                    Text("三重/鳥羽").tag(4)
                    Text("三重/的矢").tag(5)
                    Text("三重/尾鷲").tag(6)
                }
                .pickerStyle(.wheel)

                Picker("日付差", selection: $selectionOffset ) {
                    /// 選択項目の一覧
                    Text("-2").tag(0)
                    Text("-1").tag(1)
                    Text(" 0").tag(2)
                    Text(" 1").tag(3)
                    Text(" 2").tag(4)
                    Text(" 3").tag(5)
                    Text(" 4").tag(6)
                    Text(" 5").tag(7)
                    Text(" 6").tag(8)
                    Text(" 7").tag(9)
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: 37  , alignment: .leading)

            }
            .offset(x: 0, y: -40 )
            .frame(maxHeight: 37 , alignment: .leading)
            
            let returnTideLintPoint = tideLineSet( year:year, month:month, day: day)
            
            ZStack {
                ForEach(0..<73) { num in
                    tideLine( num:num , tid:returnTideLintPoint )
                }
                gridLine()
            }
            .offset(x: -5, y: -35 )
        }
        .padding()
        .background(Color(red: 0.1, green: 0.15, blue: 0.0))
        
    }
    
    func tideLine( num:Int, tid:[Double] ) -> some View {
        tideLine2(width: 140, height: 100, x1:tid[num * 2] , y1:tid[num * 2 + 1], x2:tid[num * 2 + 2], y2:tid[num * 2 + 3] )
//            .fill(Color(red: 0.6, green: 0.2, blue: 0.2))
            .offset(x: 10, y: -5)
    }
   
    func tideLine2(width: CGFloat, height: CGFloat, x1:Double, y1:Double, x2:Double, y2:Double ) -> some Shape {
        Path { path in
            path.move(to: CGPoint(x: x1 , y: y1))
            path.addLine(to: CGPoint(x: x1  + 1 , y: y1))
            path.addLine(to: CGPoint(x: x1  + 1 , y: y1 + 1))
            path.addLine(to: CGPoint(x: x1      , y: y1 + 1))
            path.closeSubpath()
        }
    }

    
    func gridLine() -> some View {
        gridLine2(width: 140, height: 100)
        //            .fill(Color(red: 0.6, green: 0.2, blue: 0.2))
        //            .frame(width: 12, height: 40)0
            .offset(x: 10, y: -5)
    }
    
    func gridLine2(width: CGFloat, height: CGFloat) -> some Shape {
        Path { path in
            var i = width / 24 * 0
            path.move(to: CGPoint(x: i , y: 0))
            path.addLine(to: CGPoint(x: i , y: height))
            path.addLine(to: CGPoint(x: i + 1 , y: height))
            path.addLine(to: CGPoint(x: i + 1 , y: 0))
            path.closeSubpath()
            i = width / 24 * 6
            path.move(to: CGPoint(x: i, y: 0))
            path.addLine(to: CGPoint(x:i , y: height))
            path.addLine(to: CGPoint(x: i + 0.5 , y: height))
            path.addLine(to: CGPoint(x: i + 0.5 , y: 0))
            path.closeSubpath()
            i = width / 24 * 12
            path.move(to: CGPoint(x: i, y: 0))
            path.addLine(to: CGPoint(x:i , y: height))
            path.addLine(to: CGPoint(x: i + 1 , y: height))
            path.addLine(to: CGPoint(x: i + 1 , y: 0))
            path.closeSubpath()
            i = width / 24 * 18
            path.move(to: CGPoint(x: i, y: 0))
            path.addLine(to: CGPoint(x:i , y: height))
            path.addLine(to: CGPoint(x: i + 0.5 , y: height))
            path.addLine(to: CGPoint(x: i + 0.5 , y: 0))
            path.closeSubpath()
            i = width / 24 * 24
            path.move(to: CGPoint(x: i, y: 0))
            path.addLine(to: CGPoint(x:i , y: height))
            path.addLine(to: CGPoint(x: i + 1 , y: height))
            path.addLine(to: CGPoint(x: i + 1 , y: 0))
            path.closeSubpath()
            
            
            i = height * 0
            path.move(to: CGPoint(x: 0 , y: i))
            path.addLine(to: CGPoint(x: width , y: i))
            path.addLine(to: CGPoint(x: width , y: i + 1))
            path.addLine(to: CGPoint(x: 0 , y: i + 1))
            path.closeSubpath()
            i = height * 0.5
            path.move(to: CGPoint(x: 0 , y: i))
            path.addLine(to: CGPoint(x: width , y: i))
            path.addLine(to: CGPoint(x: width , y: i + 0.5))
            path.addLine(to: CGPoint(x: 0 , y: i + 0.5))
            path.closeSubpath()
            i = height
            path.move(to: CGPoint(x: 0 , y: i))
            path.addLine(to: CGPoint(x: width , y: i))
            path.addLine(to: CGPoint(x: width , y: i + 1))
            path.addLine(to: CGPoint(x: 0 , y: i + 1))
            path.closeSubpath()
            
        }
        
    }
    
    func tideLineSet(year:Int, month:Int, day:Int ) -> [Double] {
        let z =  serial_z(yr: year, mh:month, dy:24 )     /* 天文計算用通日 */
        let arg1 = z + 6.5;
        let arg2 = floor(arg1/7.0);
//        let wday = (Int)(arg1 - arg2*7.0);
        let l = (Int)((year+3)/4)-500;
        let tz = serial_day(month:month, day:day) + l   /* 潮汐計算用通日 */
        /*  太陽、月の軌道要素 */
        let re = mean_longitudes(year:year, tz:tz )
        /*  基本となる分潮の天文因数 及び天文引数  */
        var f0 = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 ,9.0]
        var u0 = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 ,9.0]
        var v = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 ,9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0 ,19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0 ,29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0 ,39.0]
        var u = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 ,9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0 ,19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0 ,29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0 ,39.0]
        var f = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 ,9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0 ,19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0 ,29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0 ,39.0]
        var nc = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 ,9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0 ,19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0 ,29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0 ,39.0]
        var ags = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 ,9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0 ,19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0 ,29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0 ,39.0]
        var vl = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0 ,9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0 ,19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0 ,29.0, 30.0, 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0 ,39.0]
        /*  基本となる分潮の天文因数 及び天文引数  */
        var re00 = argument_f0( p:re.p, n:re.n, ff: &f0)
        re00 = argument_u0( p:re.p, n:re.n, ff: &u0)
        re00 = argument_v1( s:re.s, h:re.h, p:re.p, ff: &v)
        re00 = argument_u1( u0: &u0, u: &u )
        /*  グリニッチに於ける午前零時の値            */
        re00 = argument_vu( v: &v, u: &u )
        /* 　　天文因数　f　　*/
        re00 = argument_f1( f0: &f0, f: &f )
        /* 分潮の波数 */
        re00 = cycle_numbe( nc: &nc )
        /*  分潮の角速度　*/
        re00 = angular_speed( ags: &ags )
        /*   天文引数 (V0+U)l  観測地の帯域時午前零時の値に変換  */
        let latAy = na[tideSelectionValue][1] as! Double
        let lngAy = na[tideSelectionValue][2] as! Double

//        let lat = dg2dc( latAy )
        let lng = dg2dc( lngAy )
        let zt = floor(( Double( lng ) + 7.5) / 15.0) * 15.0
        re00 = tenbunHiki( vl: &vl, v: &v , nc: &nc, ags: &ags , zt:zt, lng:lng)
        
        let level = 1
        var hr2 = hr[tideSelectionValue]
        var pl2 = pl[tideSelectionValue]
        
        var tide2 = tideXY
        re00 = tidegraph(level:level, f:&f, hr:&hr2, vl:&vl, ags:&ags, pl:&pl2 ,tideXY:&tide2 )
        return(tide2)
    }
    
    func serial_z(yr: Int, mh:Int, dy:Int ) -> Double {
        /*****************************************
         天文計算用通日
         ﾕﾘｳｽ日を求める式を利用したもの  暦便利帳
         2000年 1月 1日を第１日とする通日
         この式の通用期間は、1582年10月15日以降永久に通用する
         M[]の内容に関係なく通日が計算される
         ***********************************************************/
        var b:Int
        var YK:Int
        var XM:Int
        var a:Double
        var c:Double
        var z:Double
        
        if(mh > 2){
            YK = yr
            XM = mh
        }else{
            YK = yr - 1
            XM = mh + 12
        }
        a = Double( YK / 100 )
        b = (Int)( 2.0 - a + (a / 4) )
        c = floor(365.25 * Double( YK ))
        z = floor(30.6001 * Double(XM + 1) ) + Double( b ) + c + Double( dy )
        
        /*printf("Jurian day =%f¥n", z+1720994.5 );*/
        /*printf("天文計算用通日 =%f¥n", z+1720994.5 - 2451545);*/
        
        z = z - 730550.5
        /*printf("天文計算用通日 =%f¥n", z);    getch();*/
        return z
    }
    
    
    func serial_day(month:Int, day:Int ) -> Int {
        /******************************
         年初（1月1日）からの経過日数
         閏年のチェックは行わない
         M[]の値をそのまま使うだけなのでM[]の内容が間違っていると
         この関数の値も不正になる
         *******************************/
        var sday:Int = 0
        
        for i in 1..<month {
            sday = sday+M[i] ;
        }
        sday = sday+day-1;
        return sday;
    }
    
    /*  太陽、月の軌道要素 */
    func mean_longitudes(year:Int, tz:Int ) -> (s:Double, h:Double, p:Double, n:Double) {
        let ty:Double = Double( year ) - 2000
        let s = rnd(  211.728 + rnd( 129.38471 * ty ) + rnd( 13.176396 * Double( tz ) ))
        let h = rnd( 279.974 + rnd(  -0.23871 * ty ) + rnd(  0.985647 * Double( tz ) ))
        let p = rnd(  83.298 + rnd(  40.66229 * ty ) + rnd(  0.111404 * Double( tz ) ))
        let n = rnd( 125.071 + rnd( -19.32812 * ty ) + rnd( -0.052954 * Double( tz ) ))
        return (s, h, p, n )
    }
    
    func rnd( _ x:Double ) -> Double   {
        return ( x - floor(x/360.0) * 360.0  )
    }
    
    func argument_f0( p:Double, n:Double, ff : inout [Double]) -> Int {
        var su:Double
        var cu:Double
        var arg:Double
        
        let n1 = cos(    n * 1.0 * dr)
        let n2 = cos(rnd(n * 2.0) * dr)
        let n3 = cos(rnd(n * 3.0) * dr)

        ff[ 0] = 1.0000 - 0.1300 * n1 + 0.0013 * n2  + 0.0000 * n3
        ff[ 1] = 1.0429 + 0.4135 * n1 - 0.0040 * n2  + 0.0000 * n3
        ff[ 2] = 1.0089 + 0.1871 * n1 - 0.0147 * n2  + 0.0014 * n3
        ff[ 3] = 1.0060 + 0.1150 * n1 - 0.0088 * n2  + 0.0006 * n3
        ff[ 4] = 1.0129 + 0.1676 * n1 - 0.0170 * n2  + 0.0016 * n3
        ff[ 5] = 1.1027 + 0.6504 * n1 + 0.0317 * n2  - 0.0014 * n3
        ff[ 6] = 1.0004 - 0.0373 * n1 + 0.0002 * n2  + 0.0000 * n3
        ff[ 7] = 1.0241 + 0.2863 * n1 + 0.0083 * n2  - 0.0015 * n3
        
        cu = 1.0 - 0.2505 * cos( p * 2.0 * dr) - 0.1102 * cos((p * 2.0 - n ) * dr) - 0.0156 * cos(( p * 2.0 - n * 2.0) * dr) - 0.0370 * cos( n * dr )
        su = 0.0 - 0.2505 * sin( p * 2.0 * dr) - 0.1102 * sin((p * 2.0 - n ) * dr) - 0.0156 * sin(( p * 2.0 - n * 2.0) * dr) - 0.0370 * sin( n * dr )

        arg = atan2(su, cu) * rd
        ff[ 8] = su / sin( arg * dr )
        
        cu = 2.0*cos(p*dr) + 0.4*cos((p-n)*dr)
        su =     sin(p*dr) + 0.2*cos((p-n)*dr)
        
        arg = atan2(su, cu) * rd
        ff[ 9] = cu / cos( arg * dr )
        return( 0 )
    }
    
    func argument_u0( p:Double, n:Double, ff : inout [Double]) -> Int
    {
        //        float s1, s2, s3 ;
        //        float cu, su ;
        var su:Double
        var cu:Double
        
        let s1 = sin(    n * dr   )
        let s2 = sin(rnd(n*2.0)*dr)
        let s3 = sin(rnd(n*3.0)*dr)
        
        ff[ 0] =    0.00 * s1  +  0.00 * s2  +  0.00 * s3 ;
        ff[ 1] =  -23.74 * s1  +  2.68 * s2  -  0.38 * s3 ;
        ff[ 2] =   10.80 * s1  -  1.34 * s2  +  0.19 * s3 ;
        ff[ 3] =   -8.86 * s1  +  0.68 * s2  -  0.07 * s3 ;
        ff[ 4] =  -12.94 * s1  +  1.34 * s2  -  0.19 * s3 ;
        ff[ 5] =  -36.68 * s1  +  4.02 * s2  -  0.57 * s3 ;
        ff[ 6] =   -2.14 * s1  +  0.00 * s2  +  0.00 * s3 ;
        ff[ 7] =  -17.74 * s1  +  0.68 * s2  -  0.04 * s3 ;
        
        cu = 1.0 - 0.2505 * cos( p * 2.0 * dr) - 0.1102 * cos((p * 2.0 - n ) * dr) - 0.0156 * cos(( p * 2.0 - n * 2.0) * dr) - 0.0370 * cos( n * dr )
        su = 0.0 - 0.2505 * sin( p * 2.0 * dr) - 0.1102 * sin((p * 2.0 - n ) * dr) - 0.0156 * sin(( p * 2.0 - n * 2.0) * dr) - 0.0370 * sin( n * dr )
        
        ff[ 8] = atan2(su, cu) * rd   ;
        
        cu = 2.0*cos(p*dr) + 0.4*cos((p-n)*dr) ;
        su =     sin(p*dr) + 0.2*cos((p-n)*dr) ;
        
        ff[ 9] = atan2(su, cu) * rd     ;
        return( 0 )
    }

    func argument_v1( s:Double, h:Double, p:Double, ff : inout [Double]) -> Int
    {
        ff[ 0] = (  0.0*s +  1.0*h +  0.0*p +   0.0 ) ;
        ff[ 1] = (  0.0*s +  2.0*h +  0.0*p +   0.0 ) ;
        ff[ 2] = (  1.0*s +  0.0*h -  1.0*p +   0.0 ) ;
        ff[ 3] = (  2.0*s -  2.0*h +  0.0*p +   0.0 ) ;
        ff[ 4] = (  2.0*s +  0.0*h +  0.0*p +   0.0 ) ;
        ff[ 5] = ( -3.0*s +  1.0*h +  1.0*p + 270.0 ) ;
        ff[ 6] = ( -3.0*s +  3.0*h -  1.0*p + 270.0 ) ;
        ff[ 7] = ( -2.0*s +  1.0*h +  0.0*p + 270.0 ) ;
        ff[ 8] = ( -2.0*s +  3.0*h +  0.0*p - 270.0 ) ;
        ff[ 9] = ( -1.0*s +  1.0*h +  0.0*p +  90.0 ) ;
        ff[10] = (  0.0*s -  2.0*h +  0.0*p + 192.0 ) ;
        ff[11] = (  0.0*s -  1.0*h +  0.0*p + 270.0 ) ;
        ff[12] = (  0.0*s +  0.0*h +  0.0*p + 180.0 ) ;
        ff[13] = (  0.0*s +  1.0*h +  0.0*p +  90.0 ) ;
        ff[14] = (  0.0*s +  2.0*h +  0.0*p + 168.0 ) ;
        ff[15] = (  0.0*s +  3.0*h +  0.0*p +  90.0 ) ;
        ff[16] = (  1.0*s +  1.0*h -  1.0*p +  90.0 ) ;
        ff[17] = (  2.0*s -  1.0*h +  0.0*p - 270.0 ) ;
        ff[18] = (  2.0*s +  1.0*h +  0.0*p +  90.0 ) ;
        ff[19] = ( -4.0*s +  2.0*h +  2.0*p +   0.0 ) ;
        ff[20] = ( -4.0*s +  4.0*h +  0.0*p +   0.0 ) ;
        ff[21] = ( -3.0*s +  2.0*h +  1.0*p +   0.0 ) ;
        ff[22] = ( -3.0*s +  4.0*h -  1.0*p +   0.0 ) ;
        ff[23] = ( -2.0*s +  0.0*h +  0.0*p + 180.0 ) ;
        ff[24] = ( -2.0*s +  2.0*h +  0.0*p +   0.0 ) ;
        ff[25] = ( -1.0*s +  0.0*h +  1.0*p + 180.0 ) ;
        ff[26] = ( -1.0*s +  2.0*h -  1.0*p + 180.0 ) ;
        ff[27] = (  0.0*s -  1.0*h +  0.0*p + 282.0 ) ;
        ff[28] = (  0.0*s +  0.0*h +  0.0*p +   0.0 ) ;
        ff[29] = (  0.0*s +  1.0*h +  0.0*p + 258.0 ) ;
        ff[30] = (  0.0*s +  2.0*h +  0.0*p +   0.0 ) ;
        ff[31] = (  2.0*s -  2.0*h +  0.0*p +   0.0 ) ;
        ff[32] = ( -4.0*s +  3.0*h +  0.0*p + 270.0 ) ;
        ff[33] = ( -3.0*s +  3.0*h +  0.0*p + 180.0 ) ;
        ff[34] = ( -2.0*s +  3.0*h +  0.0*p +  90.0 ) ;
        ff[35] = (  0.0*s +  1.0*h +  0.0*p +  90.0 ) ;
        ff[36] = ( -4.0*s +  4.0*h +  0.0*p +   0.0 ) ;
        ff[37] = ( -2.0*s +  2.0*h +  0.0*p +   0.0 ) ;
        ff[38] = ( -6.0*s +  6.0*h +  0.0*p +   0.0 ) ;
        ff[39] = ( -4.0*s +  4.0*h +  0.0*p +   0.0 ) ;
        return( 0 )
    }

    func argument_u1( u0 : inout [Double], u : inout [Double]) -> Int
    {
        u[ 0] = 0.0
        u[ 1] = 0.0
        u[ 2] = 0.0
        u[ 3] = -u0[ 6]
        u[ 4] =  u0[ 1]
        u[ 5] =  u0[ 2]
        u[ 6] =  u0[ 2]
        u[ 7] =  u0[ 2]
        u[ 8] =  u0[ 6]
        u[ 9] =  u0[ 9]
        u[10] =  0.0
        u[11] =  0.0
        u[12] =  0.0
        u[13] =  u0[ 3]
        u[14] =  0.0
        u[15] =  0.0
        u[16] =  u0[ 4]
        u[17] = -u0[ 2]
        u[18] =  u0[ 5]
        u[19] =  u0[ 6]
        u[20] =  u0[ 6]
        u[21] =  u0[ 6]
        u[22] =  u0[ 6]
        u[23] =  u0[ 2]
        u[24] =  u0[ 6]
        u[25] =  u0[ 6]
        u[26] =  u0[ 8]
        u[27] =  0.0
        u[28] =  0.0
        u[29] =  0.0
        u[30] =  u0[ 7]
        u[31] = -u0[ 6]
        u[32] =  u0[ 6] + u0[ 2]
        u[33] =  u0[ 6] * 1.5
        u[34] =  u0[ 6] + u0[ 3]
        u[35] =  u0[ 3]
        u[36] =  u0[ 6] * 2.0
        u[37] =  u0[ 6]
        u[38] =  u0[ 6] * 3.0
        u[39] =  u0[ 6] * 2.0

        return( 0 )
    }

    /*  グリニッチに於ける午前零時の値            */
    func argument_vu( v : inout [Double], u : inout [Double]) -> Int
    {
        for i in 0...39 {
            v[i]=rnd(v[i]+u[i])
        }
        return( 0 )
    }

    /* 　　天文因数　f　　*/
    func argument_f1( f0 : inout [Double], f: inout [Double]) -> Int
    {
        f[ 0] = 1.0
        f[ 1] = 1.0
        f[ 2] = f0[ 0]
        f[ 3] = f0[ 6]
        f[ 4] = f0[ 1]
        f[ 5] = f0[ 2]
        f[ 6] = f0[ 2]
        f[ 7] = f0[ 2]
        f[ 8] = f0[ 6]
        f[ 9] = f0[ 9]
        f[10] = 1.0
        f[11] = 1.0
        f[12] = 1.0
        f[13] = f0[ 3]
        f[14] = 1.0
        f[15] = 1.0
        f[16] = f0[ 4]
        f[17] = f0[ 2]
        f[18] = f0[ 5]
        f[19] = f0[ 6]
        f[20] = f0[ 6]
        f[21] = f0[ 6]
        f[22] = f0[ 6]
        f[23] = f0[ 2]
        f[24] = f0[ 6]
        f[25] = f0[ 6]
        f[26] = f0[ 8]
        f[27] = 1.0
        f[28] = 1.0
        f[29] = 1.0
        f[30] = f0[ 7]
        f[31] = f0[ 6]  ;
        f[32] = f0[ 6]  *  f0[ 2]
        f[33] = pow( f0[ 6], 1.5 ) ;
        f[34] = f0[ 6]  *  f0[ 3]
        f[35] = f0[ 3]
        f[36] = pow( f0[ 6], 2.0 )
        f[37] = f0[ 6]
        f[38] = pow( f0[ 6], 3.0 )
        f[39] = pow( f0[ 6], 2.0 )
        return( 0 )
    }

    /* 分潮の波数 */
    func cycle_numbe(  nc: inout [Double]) -> Int {
        nc[ 0] = 0 ;   nc[10] = 1 ;   nc[20] = 2 ;   nc[30] = 2 ;
        nc[ 1] = 0 ;   nc[11] = 1 ;   nc[21] = 2 ;   nc[31] = 2 ;
        nc[ 2] = 0 ;   nc[12] = 1 ;   nc[22] = 2 ;   nc[32] = 3 ;
        nc[ 3] = 0 ;   nc[13] = 1 ;   nc[23] = 2 ;   nc[33] = 3 ;
        nc[ 4] = 0 ;   nc[14] = 1 ;   nc[24] = 2 ;   nc[34] = 3 ;
        nc[ 5] = 1 ;   nc[15] = 1 ;   nc[25] = 2 ;   nc[35] = 3 ;
        nc[ 6] = 1 ;   nc[16] = 1 ;   nc[26] = 2 ;   nc[36] = 4 ;
        nc[ 7] = 1 ;   nc[17] = 1 ;   nc[27] = 2 ;   nc[37] = 4 ;
        nc[ 8] = 1 ;   nc[18] = 1 ;   nc[28] = 2 ;   nc[38] = 6 ;
        nc[ 9] = 1 ;   nc[19] = 2 ;   nc[29] = 2 ;   nc[39] = 6 ;
        
        return( 0 )
    }

    /* 分潮の波数 */
    func angular_speed(  ags: inout [Double]) -> Int {
        ags[ 0] =   0.0410686  ;    ags[ 1] =   0.0821373  ;
        ags[ 2] =   0.5443747  ;    ags[ 3] =   1.0158958  ;
        ags[ 4] =   1.0980331  ;    ags[ 5] =  13.3986609  ;
        ags[ 6] =  13.4715145  ;    ags[ 7] =  13.9430356  ;
        ags[ 8] =  14.0251729  ;    ags[ 9] =  14.4920521  ;
        ags[10] =  14.9178647  ;    ags[11] =  14.9589314  ;
        ags[12] =  15.0000000  ;    ags[13] =  15.0410686  ;
        ags[14] =  15.0821353  ;    ags[15] =  15.1232059  ;
        ags[16] =  15.5854433  ;    ags[17] =  16.0569644  ;
        ags[18] =  16.1391017  ;    ags[19] =  27.8953548  ;
        ags[20] =  27.9682084  ;    ags[21] =  28.4397295  ;
        ags[22] =  28.5125831  ;    ags[23] =  28.9019669  ;
        ags[24] =  28.9841042  ;    ags[25] =  29.4556253  ;
        ags[26] =  29.5284789  ;    ags[27] =  29.9589333  ;
        ags[28] =  30.0000000  ;    ags[29] =  30.0410667  ;
        ags[30] =  30.0821373  ;    ags[31] =  31.0158958  ;
        ags[32] =  42.9271398  ;    ags[33] =  43.4761563  ;
        ags[34] =  44.0251729  ;    ags[35] =  45.0410686  ;
        ags[36] =  57.9682084  ;    ags[37] =  58.9841042  ;
        ags[38] =  86.9523127  ;    ags[39] =  87.9682084  ;

        return( 0 )
    }

    func tenbunHiki( vl : inout [Double], v: inout [Double], nc: inout [Double], ags: inout [Double], zt:Double, lng:Double ) -> Int
    {
        for i in 0...39 {
            vl[i] = v[i] - ( 0 - lng)*nc[i] + ags[i]*( 0 - zt/15.0)
            vl[i] = rnd( vl[i] )
        }
        return( 0 )
    }

  /**********************************
        １日潮汐曲線
**/
    func tidegraph( level:Int, f : inout [Double], hr: inout [Double], vl: inout [Double], ags: inout [Double], pl: inout [Double], tideXY: inout [Double] ) -> Int {
//        var k:Int
//        var pos:Int
        var tc:Double
//        var x1:Double
//        var y1:Double
        var x2:Double
        var y2:Double
        var cox:Double
        var itv:Double
//        var inc:Double

        let scale:Double = 0.2
        let offsetTide:Int = 0
//        x1=0
//        y1=0
        x2=0
        y2=0
//        pos=51
//        k=19
        itv = 20   /* 計算間隔  */
//        inc = 24 * 60 / itv + 3   /* 計算回数  */
        cox = itv * 0.097
        
        
        for i in 0...72 {
            tc = 1
            for j in 0...39 {
                tc = tc + f[j] * hr[j] * cos( (vl[j] + ags[ j] * Double( i )  / (60 / itv) - pl[j] ) * dr )
            }
            
            if(i==0){
                x2 = 1
                y2 = Double( 50 - ( Int(tc * 1.6 * scale ) ) + offsetTide )
                tideXY[i * 2 ] = Double( x2 )
                tideXY[i * 2 + 1] = Double( y2 )
//                _moveto((Int)x2,(int)y2);
                let _ = print("moveto x=%d  y=%d",x2,y2)
            }
            if i>0 && i < 73 {
//                x1=x2
//                y1=y2;
                x2 = 1 + Double( i ) * cox
                y2 = Double( 50 - ( Int(tc * 1.6 * scale ) ) + offsetTide )
                tideXY[i * 2 ] = Double( x2 )
                tideXY[i * 2 + 1] = Double( y2 )
//                _lineto((iIt)x2,(Int)y2);
                let _ = print("lintto x=%d  y=%d ",x2,y2)
            }
        }
        
        return( 0 )
    }


    func dg2dc( _ value: Double ) -> Double {
        let integer = Int( value )
        let fraction = value.truncatingRemainder(dividingBy: 1) / 6 * 10
        return( Double( integer ) + fraction )
    }
    
}
#Preview {
  ContentViewPE()
}

