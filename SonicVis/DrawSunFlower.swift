//
//  DrawSunFlower.swift
//  DrawPopUpBooks
//
//  Created by yryang on 2019/3/11.
//  Copyright © 2019 yryang. All rights reserved.
//

import UIKit
import Charts
import AVFoundation

class DrawSunFlower:  UIView{
    var chartView: LineChartView! = LineChartView()
    var count = 10
    var nowTap = 0
    var rawDataModel = SunflowerDataModel()
    var dataEntries = [ChartDataEntry]()
    var player = PlayAudio()
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 30, y: 30, width: 500, height: 250))
        
        sunflowerGrow(frame: CGRect(x: 30, y: 30, width: 450, height: 230))
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        self.addSubview(chartView)
        
        /*画9次，然后掉用finish()*/
//                draw(1)
//                draw(2)
//                draw(3)
//                draw(4)
//                draw(5)
//                draw(6)
//                draw(7)
//                draw(8)
//                draw(9)
//
//                finish()
//
        
    }
    func sunflowerGrow(frame: CGRect) {
        chartView.frame = frame
        
        chartView.noDataText = " "
        
        
        //设置交互样式
        chartView.scaleYEnabled = false //取消Y轴缩放
        chartView.doubleTapToZoomEnabled = false //双击缩放
        chartView.dragEnabled = true //启用拖动手势
        chartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
        chartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果摩擦系数(0~1)越小惯性越不明显
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisMaximum = 24
        chartView.xAxis.drawGridLinesEnabled = false
        //        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        //        chartView.xAxis.drawLabelsEnabled = false
        //        chartView.xAxis.gridLineWidth = 1
        //        chartView.xAxis.
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 30
        //        chartView.leftAxis.drawGridLinesEnabled = false
        //        chartView.leftAxis.gridLineWidth = 1
        
        chartView.legend.enabled = false
        
    }
    
    func draw(_ ith: Int) {
        if ith == nowTap+1{
            draw()
            playAudio(tap: nowTap)
        }
        else{
            nowTap = 0
            removeImage()
            dataEntries.removeAll()
            for _ in 0..<ith{
                draw()
            }
            playAudio(tap: nowTap)
        }
    }
    
    func draw() {
        
        var y : Int
        var x : Int
        
        nowTap = nowTap + 1
        if nowTap < count{
            
          
            x = rawDataModel.getDay(tap: nowTap)
            y = rawDataModel.getHeight(tap: nowTap)
            let entry = ChartDataEntry.init(x: Double(x), y: Double(y))
            dataEntries.append(entry)
            placeSunflowerImage(num: nowTap)
            
           
        }
        
        
        //这50条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "sunflower")
        
        chartDataSet.colors = [UIColor.blue]
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.mode = .linear
        chartDataSet.drawValuesEnabled = false
        
        //目前折线图只包括1根折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartView.data = chartData
        
        
        
        
    }
    func finish() {
        removeImage()
        player.playAudio(audioName: "flower")
        
        
    }
    
    func removeImage(){
        for i in 100..<100+count{
            print("remove")
            if let imageViewWithTag = self.viewWithTag(i){
                imageViewWithTag.removeFromSuperview()
                print("in")
            }
            
        }
    }
    
    func placeSunflowerImage(num: Int) {
        
        let img = "SF-" + String(num)+".png"
        
        //        chartView.borderColor = UIColor.red
        //        chartView.layer.borderWidth = 1
        let newImage = UIImage(named: img)
        
        let imageView = UIImageView(image:newImage)
        imageView.frame = rawDataModel.getImgLocation(tap: num)
        imageView.tag = num + 100
        
        self.addSubview(imageView)
        
        
    }
    
    /*attention
     *the audio needs improved
     */
    func playAudio(tap: Int){
        //this is for the audio
        let audio = "flower-" + String(tap)
        player.playAudio(audioName: audio)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
