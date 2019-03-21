//
//  DrawBarView.swift
//  DrawPopUpBooks
//
//  Created by yryang on 2019/3/17.
//  Copyright © 2019 yryang. All rights reserved.
//

import UIKit
import Charts
import AVFoundation
class DrawBarView: UIView {
    let shapeLayer = CAShapeLayer()
    var bezierPath: UIBezierPath! = UIBezierPath()
    let cellWidth = 60
    let cellHeight = 60
    let row = 5
    let col = 8
    var dataAnimal : Dictionary<String, Int> = ["Sheep":0,  "Chick":0, "Bird": 0, "Duck":0,"Dog":0]
    var mytag = 100
    var chartView = HorizontalBarChartView()
    var flag = false
    var player = PlayAudio()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 50, y: 50, width: 480, height: 300))
        
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        draw(CGRect(x: 0, y: 0, width: 480 , height: 300))
        addPlacePic()
        
//        draw(name: "Dog")
//        draw(name: "Dog")
//
//        draw(name: "Bird")
//        draw(name: "Bird")
//
//        draw(name: "Duck")
//        draw(name: "Chick")
//        Finish1()
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(9), execute: {
//            self.Finish2()
//        })

//        self.Finish2()
//
//        deletePic()
//        drawTheChart()
        
    }
    func addPlacePic() {
        addOnePlacePic(rowth: 0, name: "CA-mountain.png")
        addOnePlacePic(rowth: 1, name: "CA-field.png")
        addOnePlacePic(rowth: 2, name: "CA-cloud.png")
        addOnePlacePic(rowth: 3, name: "CA-grassland.png")
        addOnePlacePic(rowth: 4, name: "CA-house.png")
    }
    func addOnePlacePic(rowth: Int, name: String)  {
        
        let location = findLocationOfPic(rowth: rowth, colth: 0)
        let newImage = UIImage(named: name)
        let imageView = UIImageView(image:newImage)
        imageView.frame = CGRect(x: location.x+5, y: location.y+10, width: 40, height: 40)
        imageView.tag = mytag
        mytag = mytag + 1
        
        self.addSubview(imageView)
    }
    override func draw(_ rect: CGRect) {
//        super.draw(rect)
        
     
        //开始绘制
        if flag == false{
            bezierPath.move(to: CGPoint(x: 0, y: 0))
            for i in 0..<row+1 {
                bezierPath.move(to: CGPoint(x: cellWidth, y: i * cellHeight))
                bezierPath.addLine(to: CGPoint(x: cellWidth*col, y: i*cellHeight))
            }
            for j in 1..<col+1{
                bezierPath.move(to: CGPoint(x: j*cellWidth, y: 0))
                bezierPath.addLine(to: CGPoint(x: j*cellWidth, y: cellHeight*row))
            }
        
            UIColor.green.setStroke()
            //        bezierPath.fill()
            shapeLayer.path = bezierPath.cgPath
            shapeLayer.strokeColor = UIColor.gray.cgColor
            shapeLayer.lineWidth = 1.0
            //shapeLayer.backgroundColor = CGColor(colorSpace: <#T##CGColorSpace#>, components: <#T##UnsafePointer<CGFloat>#>)
            self.layer.addSublayer(shapeLayer)
            
        }
        
        if flag {
            shapeLayer.lineWidth = 0
            bezierPath.removeAllPoints()
            shapeLayer.path = bezierPath.cgPath
        }
        
//        deletePic()
//        bezierPath.stroke()
        
        
    }
    func Finish1() {
        self.player.playAudio(audioName: "sheep-mix")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.player.playAudio(audioName: "chick-mix")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                self.player.playAudio(audioName: "dove-mix")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    self.player.playAudio(audioName: "duck-mix")
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                        self.player.playAudio(audioName: "dog-mix")
                    })
                })
            })
            
        })
    }
    
    func Finish2() {
        shapeLayer.lineWidth = 0
        deletePic()
        drawTheChart()
        player.playAudio(audioName: "bar-chart-whole")
    }
    
    func finish(){
        Finish1()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
            self.Finish2()
        })
    }
    
    func draw(name: String) {
        switch name {
        case "Sheep":
            addPic(name: "Sheep", rowth: 0)
            player.playAudio(audioName: "sheep")
        case "Chick":
            addPic(name: "Chick", rowth: 1)
            player.playAudio(audioName: "chick")
        case "Bird":
            addPic(name: "Bird", rowth: 2)
            player.playAudio(audioName: "dove")
        case "Duck":
            addPic(name: "Duck", rowth: 3)
            player.playAudio(audioName: "duck")
        case "Dog":
            addPic(name: "Dog", rowth: 4)
            player.playAudio(audioName: "dog")
        default:
            print("default")
        }
    }
    func addPic(name:String, rowth: Int) {
        dataAnimal[name] = dataAnimal[name]! + 1
        let colth = dataAnimal[name]
        let location = findLocationOfPic(rowth: rowth, colth: colth!)
        var  newImage: UIImage!
        switch name {
        case "Sheep":
            newImage = UIImage(named: "CA-sheep" + ".png")
        case "Bird":
            newImage = UIImage(named: "CA-bird2" + ".png")
        case "Chick":
            newImage = UIImage(named: "CA-chick3"  + ".png")
        case "Duck":
            newImage = UIImage(named: "CA-rabbit1" + ".png")
        case "Dog":
            newImage = UIImage(named: "CA-dog1" + ".png")
        default:
            print("no")
        }
        
        
        let imageView = UIImageView(image:newImage)
        imageView.frame = CGRect(x: location.x+10, y: location.y+10, width: 40, height: 40)
        imageView.tag = mytag
        mytag = mytag + 1
        
        self.addSubview(imageView)
    }
    func findLocationOfPic(rowth: Int, colth: Int)-> CGPoint {
        return CGPoint(x: colth*cellWidth ,y: rowth * cellHeight)
    }
    
    func drawTheChart(){
        
        
        chartView.frame = CGRect(x: 0, y: 0, width: cellWidth * col, height: cellHeight*row)
        self.addSubview(chartView)
        
        //不显示图例
        chartView.legend.enabled = false
        chartView.backgroundColor = //UIColor(red: 43, green: 43, blue: 43, alpha: 0.5)
             UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        //x轴显示在左侧
        chartView.xAxis.labelPosition = .bottom
        //y轴起始刻度为0
        chartView.leftAxis.axisMinimum = 0
        chartView.rightAxis.axisMinimum = 0
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.drawBordersEnabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        
        chartView.xAxis.axisMinimum = 0.0
        chartView.xAxis.axisMaximum = 7.0
//        chartView.xAxis.granularity = 0.5
        
        let xValues = ["" ,"sheep", "chick", "duck", "dog", "bird"]
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
//        chartView.xAxis.forceLabelsEnabled = true
    
        var dataEntries = [BarChartDataEntry]()
        
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(dataAnimal["Sheep"]!), icon: resizeImage(image: UIImage( named: "CA-sheep.png")!, newWidth: 50))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(dataAnimal["Chick"]!), icon: resizeImage(image: UIImage( named: "CA-chick3.png")!, newWidth: 50))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(dataAnimal["Duck"]!), icon: resizeImage(image: UIImage( named: "CA-rabbit1.png")!, newWidth: 50))
        let entry4 = BarChartDataEntry(x: 4.0, y: Double(dataAnimal["Dog"]!),  icon: resizeImage(image: UIImage( named: "CA-dog1.png")!, newWidth: 50))
        let entry5 = BarChartDataEntry(x: 5.0, y: Double(dataAnimal["Bird"]!), icon: resizeImage(image: UIImage( named: "CA-bird2.png")!, newWidth: 50))
        //这10条数据作为柱状图的所有数据
        dataEntries.append(entry1)
        dataEntries.append(entry2)
        dataEntries.append(entry3)
        dataEntries.append(entry4)
        dataEntries.append(entry5)
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "图例1")
        chartDataSet.drawValuesEnabled = false
        //目前柱状图只包括1组立柱
        let chartData = BarChartData(dataSets: [chartDataSet])
        chartDataSet.colors = [
            UIColor(red: 227/255, green: 170/255, blue: 169/255, alpha: 1),
            UIColor(red: 215/255, green: 110/255, blue: 117/255, alpha: 1),
            UIColor(red: 138/255, green: 194/255, blue: 234/255, alpha: 1),
            UIColor(red: 222/255, green: 205/255, blue: 86/255,  alpha: 1),
            UIColor(red: 160/255, green: 209/255, blue: 221/255, alpha: 1)]
        
        //设置柱状图数据
        chartView.data = chartData
        chartView.fitScreen()
        
    }
    func deletePic()  {
        flag = true
        
        for i in 100..<mytag{
            if let view1 = self.viewWithTag( i){
                view1.removeFromSuperview()
            }
            
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
