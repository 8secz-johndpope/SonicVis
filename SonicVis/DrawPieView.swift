//
//  DrawPieView.swift
//  DrawPopUpBooks
//
//  Created by yryang on 2019/3/16.
//  Copyright © 2019 yryang. All rights reserved.
//


import UIKit
import Charts
import AVFoundation

class DrawPieView: UIView{
  
   
    var chartView = PieChartView()
    var dataEntries = [PieChartDataEntry]()
    var chartDataSet = PieChartDataSet()
    var chartData = PieChartData()
    var player = PlayAudio()
    
    
    override init(frame: CGRect) {
        let fra = CGRect(x: 50, y: 40, width: 400, height: 400)
        let fr:CGRect = CGRect(x: 0, y: 0, width: 300, height: 300)
        chartView.frame = fr
        chartView.rotationEnabled = false
        chartView.drawHoleEnabled = false
        
        super.init(frame: fra)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.addSubview(chartView)
        
//        initialziePie()
//       tabletennis()
//        draw(name: "Badminton")
//        draw(name: "Baseball")
//        draw(name: "Tabletennis")
//        draw(name: "Chess")
////        draw(name: "Badminton")
//       finish()
        
        
        
    }
    //
    func finish() {
        
//        draw(name: "Indoor")
//        draw(name: "Finish2")
       
        self.draw(name: "Finish1")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
            self.draw(name: "Finish2")
        })
       
//        sleep(3)
        
//        sleep(3)
    }
    
    
    func initialziePie() {
        
     
        //change the picture
        dataEntries = [PieChartDataEntry(value: 32,  icon: resizeImage(image: UIImage(named: "Sports-total.png")!, newWidth: 120) )]
        
        
        
        chartDataSet = PieChartDataSet(values: dataEntries, label: "数据分布")
        //设置颜色
        chartDataSet.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
        chartDataSet.selectionShift = 0
        chartDataSet.iconsOffset = CGPoint(x: -130, y: 0)
//        chartDataSet.drawValuesEnabled = false


        let formatter = NumberFormatter()
        formatter.positivePrefix = ""

        chartData = PieChartData(dataSet: chartDataSet)
//        chartData.setValueTextColor(.red)
        chartData.setValueFont(.systemFont(ofSize: 60))

        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        chartData.setDrawValues(false)
        
        //设置饼状图数据
        chartView.data = chartData
        chartView.legend.enabled = false
//        chartView.layer.borderWidth = 1.0
        player.playAudio(audioName: "total-32")
        
    }
    func draw(name: String) {
        var flag = false
        switch name {
        case "Baseball":
            dataEntries = [PieChartDataEntry(value: 16,  icon: resizeImage(image: UIImage(named: "Sports-baseball.png")!, newWidth: 50) ),
                           PieChartDataEntry(value: 8),
                           PieChartDataEntry(value: 4),
                           PieChartDataEntry(value: 4)]
            flag = true
            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
            chartDataSet.iconsOffset = CGPoint(x: 0, y: 0)
            
            //设置颜色
            chartDataSet.colors =  [UIColor(red: 104/255, green: 79/255, blue: 160/255, alpha: 1)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)]
            chartDataSet.drawValuesEnabled = false
            chartDataSet.selectionShift = 0
            
            //            let formatter = NumberFormatter()
            //            formatter.positivePrefix = ""
            chartData.setDrawValues(false)
            chartData = PieChartData(dataSet: chartDataSet)
            //            chartData.setValueTextColor(.white)
            //            chartData.setValueFont(.systemFont(ofSize: 40))
            
            //            chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            chartView.data = chartData
            chartView.legend.enabled = false
            
            player.playAudio(audioName: "baseball-2")
            
            
        case "Tabletennis":
            dataEntries = [PieChartDataEntry(value: 16),
                           PieChartDataEntry(value: 8,  icon: resizeImage(image: UIImage(named: "Sports-tabletennis.png")!, newWidth: 50) ),
                           PieChartDataEntry(value: 4),
                           PieChartDataEntry(value: 4)]
            flag = true
            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
            chartDataSet.iconsOffset = CGPoint(x: 0, y: 0)
            
            //设置颜色
            chartDataSet.colors =  [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 104/255, green: 79/255, blue: 160/255, alpha: 1)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)]
            chartDataSet.drawValuesEnabled = false
            chartDataSet.selectionShift = 0
            
            //            let formatter = NumberFormatter()
            //            formatter.positivePrefix = ""
            chartData.setDrawValues(false)
            chartData = PieChartData(dataSet: chartDataSet)
            //            chartData.setValueTextColor(.white)
            //            chartData.setValueFont(.systemFont(ofSize: 40))
            
            //            chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            chartView.data = chartData
            chartView.legend.enabled = false
            
            player.playAudio(audioName: "tabletennis-2")
            
        case "Badminton":
            dataEntries = [PieChartDataEntry(value: 16),
                           PieChartDataEntry(value: 8),
                           PieChartDataEntry(value: 4,  icon: resizeImage(image: UIImage(named: "Sports-badminton.png")!, newWidth: 50) ),
                           PieChartDataEntry(value: 4)]
            flag = true
        
            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
            chartDataSet.iconsOffset = CGPoint(x: 0, y: 0)
            
            //设置颜色
            chartDataSet.colors =  [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 104/255, green: 79/255, blue: 160/255, alpha: 1)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)]
            chartDataSet.drawValuesEnabled = false
            chartDataSet.selectionShift = 0
            
            //            let formatter = NumberFormatter()
            //            formatter.positivePrefix = ""
            chartData.setDrawValues(false)
            chartData = PieChartData(dataSet: chartDataSet)
            //            chartData.setValueTextColor(.white)
            //            chartData.setValueFont(.systemFont(ofSize: 40))
            
            //            chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            chartView.data = chartData
            chartView.legend.enabled = false
            
            player.playAudio(audioName: "badminton-2")
            
        case "Chess":
            dataEntries = [PieChartDataEntry(value: 16),
                           PieChartDataEntry(value: 8),
                           PieChartDataEntry(value: 4 ),
                           PieChartDataEntry(value: 4,  icon: resizeImage(image: UIImage(named: "Sports-chess.png")!, newWidth: 50) )]
             flag = true
            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
            chartDataSet.iconsOffset = CGPoint(x: 0, y: 0)
            
            //设置颜色
            chartDataSet.colors =  [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 0, green: 0, blue: 0, alpha: 0)] + [UIColor(red: 104/255, green: 79/255, blue: 160/255, alpha: 1)]
            chartDataSet.drawValuesEnabled = false
            chartDataSet.selectionShift = 0
            
            //            let formatter = NumberFormatter()
            //            formatter.positivePrefix = ""
            chartData.setDrawValues(false)
            chartData = PieChartData(dataSet: chartDataSet)
            //            chartData.setValueTextColor(.white)
            //            chartData.setValueFont(.systemFont(ofSize: 40))
            
            //            chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            chartView.data = chartData
            chartView.legend.enabled = false
            
            player.playAudio(audioName: "chess-2")
            
        case "Indoor":
            dataEntries = [PieChartDataEntry(value: 20),
                           PieChartDataEntry(value: 12,  icon: resizeImage(image: UIImage(named: "Sports-indoor.png")!, newWidth: 50) )]
             flag = true
            
            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
            chartDataSet.iconsOffset = CGPoint(x: 0, y: 0)
            
            //设置颜色
            chartDataSet.colors =  [UIColor.green] + [UIColor.red]
            chartDataSet.drawValuesEnabled = false
            chartDataSet.selectionShift = 0
            
            //            let formatter = NumberFormatter()
            //            formatter.positivePrefix = ""
            chartData.setDrawValues(false)
            chartData = PieChartData(dataSet: chartDataSet)
            //            chartData.setValueTextColor(.white)
            //            chartData.setValueFont(.systemFont(ofSize: 40))
            
            //            chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            chartView.data = chartData
            chartView.legend.enabled = false
            player.playAudio(audioName: "indoor-12")
        case "Outdoor":
            dataEntries = [PieChartDataEntry(value: 20,  icon: resizeImage(image: UIImage(named: "Sports-outdoor.png")!, newWidth: 50) ),
                           PieChartDataEntry(value: 12)]
            flag = true
            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
            chartDataSet.iconsOffset = CGPoint(x: 0, y: 0)
            
            //设置颜色
            chartDataSet.colors =  [UIColor.red] + [UIColor.green]
            chartDataSet.drawValuesEnabled = false
            chartDataSet.selectionShift = 0
            
            //            let formatter = NumberFormatter()
            //            formatter.positivePrefix = ""
            chartData.setDrawValues(false)
            chartData = PieChartData(dataSet: chartDataSet)
            //            chartData.setValueTextColor(.white)
            //            chartData.setValueFont(.systemFont(ofSize: 40))
            
            //            chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            chartView.data = chartData
            chartView.legend.enabled = false
            player.playAudio(audioName: "outdoor-20")
        case "Finish1":
            dataEntries = [PieChartDataEntry(value: 16,  icon: resizeImage(image: UIImage(named: "Sports-baseball.png")!, newWidth: 50) ),
                           PieChartDataEntry(value: 8,  icon: resizeImage(image: UIImage(named: "Sports-tabletennis.png")!, newWidth: 50) ),
                           PieChartDataEntry(value: 4,  icon: resizeImage(image: UIImage(named: "Sports-badminton.png")!, newWidth: 50) ),
                           PieChartDataEntry(value: 4,  icon: resizeImage(image: UIImage(named: "Sports-chess.png")!, newWidth: 50) )]
            flag = true
            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
            
            // 调整图片位置
            chartDataSet.iconsOffset = CGPoint(x: 10, y: 10)
            
            //设置颜色
            chartDataSet.colors =
                [UIColor(red: 188/255, green: 235/255, blue: 205/255, alpha: 1)] +
                [UIColor(red: 215/255, green: 159/255, blue: 181/255, alpha: 1)] +
                [UIColor(red: 145/255, green: 227/255, blue: 163/255, alpha: 1)] +
                [UIColor(red: 100/255, green: 173/255, blue: 220/255, alpha: 1)]
            chartDataSet.drawValuesEnabled = false
            chartDataSet.selectionShift = 0
            
            let formatter = NumberFormatter()
            formatter.positivePrefix = ""
    
            chartData = PieChartData(dataSet: chartDataSet)
                        chartData.setValueTextColor(.white)
                        chartData.setValueFont(.systemFont(ofSize: 40))
            
                        chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            
            
            chartData.setDrawValues(false)
            
            
            chartView.data = chartData
            chartView.legend.enabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.player.playAudio(audioName: "badminton-mix")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.player.playAudio(audioName: "baseball-mix")
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                        self.player.playAudio(audioName: "tabletennis-mix")
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                            self.player.playAudio(audioName: "chess-mix")
                        })
                    })
                })
            })
            
            
            
            
            
            
        case "Finish2":
            dataEntries = [PieChartDataEntry(value: 20,  icon: resizeImage(image: UIImage(named: "Sports-outdoor.png")!, newWidth: 80) ),
                           PieChartDataEntry(value: 12,  icon: resizeImage(image: UIImage(named: "Sports-indoor.png")!, newWidth: 80) )]
            flag = true
            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
            chartDataSet.iconsOffset = CGPoint(x: 0, y: 0)
            
            //设置颜色
            chartDataSet.colors =
                [UIColor(red: 188/255, green: 235/255, blue: 205/255, alpha: 1)] +
                [UIColor(red: 215/255, green: 159/255, blue: 181/255, alpha: 1)] +
                [UIColor(red: 145/255, green: 227/255, blue: 163/255, alpha: 1)] +
                [UIColor(red: 100/255, green: 173/255, blue: 220/255, alpha: 1)]
            chartDataSet.drawValuesEnabled = false
            chartDataSet.selectionShift = 0
            
            let formatter = NumberFormatter()
            formatter.positivePrefix = ""
            
            chartData = PieChartData(dataSet: chartDataSet)
            chartData.setValueTextColor(.white)
            chartData.setValueFont(.systemFont(ofSize: 40))

            chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
            chartData.setDrawValues(false)
            chartView.data = chartData
            chartView.legend.enabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.player.playAudio(audioName: "indoor-12")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.player.playAudio(audioName: "outdoor-20")
                })
            })
            
        case "Begin":
            initialziePie()
        default:
            print("no")
        }
        
        if flag{
//            chartDataSet = PieChartDataSet(values: dataEntries, label: "")
//            chartDataSet.iconsOffset = CGPoint(x: 0, y: 0)
//
//            //设置颜色
//            chartDataSet.colors =  [UIColor.red] + [UIColor.blue] + [UIColor.orange] + [UIColor.white]
//            chartDataSet.drawValuesEnabled = false
//            chartDataSet.selectionShift = 0
//
////            let formatter = NumberFormatter()
////            formatter.positivePrefix = ""
//
//            chartData = PieChartData(dataSet: chartDataSet)
////            chartData.setValueTextColor(.white)
////            chartData.setValueFont(.systemFont(ofSize: 40))
//
////            chartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
//            chartView.data = chartData
//            chartView.legend.enabled = false
        }
        
        
    }
    
    
    
   
    func begin() {
        draw(name: "Begin")
    }
    
    
    
    

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

