//
//  SunflowerDataModel.swift
//  DrawPopUpBooks
//
//  Created by yryang on 2019/3/11.
//  Copyright © 2019 yryang. All rights reserved.
//

import Foundation
import UIKit
class SunflowerDataModel {
    struct dataEntry {
        var day : Int!
        var height : Int!
    }
    
    final let rawData : Dictionary<Int, dataEntry> =
        [1: dataEntry(day: 0, height: 0),
         2:dataEntry(day: 3, height: 1),
         3:dataEntry(day: 6, height: 2),
         4:dataEntry(day: 9, height: 5),
         5:dataEntry(day: 12, height: 14),
         6:dataEntry(day: 15, height: 21),
         7:dataEntry(day: 18, height: 23),
         8:dataEntry(day: 21, height: 24),
         9:dataEntry(day: 24, height: 25)]
    
    init() {
        
    }
    
    func getDay(tap: Int) -> Int {
        return rawData[tap]!.day
    }
    func getHeight(tap: Int) -> Int {
        return rawData[tap]!.height
    }
    
    
    final let imgLocation:Dictionary<Int, CGRect> =
        [1: CGRect(x: 35, y: 70, width: 49, height: 210),
         2: CGRect(x: 85, y: 70, width: 49, height: 210),
         3: CGRect(x: 135, y: 70, width: 49, height: 210),
         4: CGRect(x: 185, y: 70, width: 49, height: 210),
         5: CGRect(x: 235, y: 70, width: 49, height: 210),
         6: CGRect(x: 285, y: 70, width: 49, height: 210),
         7: CGRect(x: 335, y: 70, width: 49, height: 210),
         8: CGRect(x: 385, y: 70, width: 49, height: 210),
         9: CGRect(x: 435, y: 70, width: 49, height: 210)]
    func getImgLocation(tap: Int) -> CGRect {
        return imgLocation[tap]!
    }
}
