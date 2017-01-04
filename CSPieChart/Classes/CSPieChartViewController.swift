//
//  CSPieChartViewController.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

import UIKit

class CSPieChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let randomValue = Double(arc4random() % 361)
        var startAngle = randomValue.toRadian
        
        let width = view.frame.width
        let height = width
        let size = CGSize(width: width, height: height)
        
        let point = CGPoint(x: 0, y: 0)
        
        let frame = CGRect(origin: point, size: size)
        
        let pieChartView = UIView(frame: frame)
        
        let dataList = [
            CSPieChartData(title: "test1", value: 70),
            CSPieChartData(title: "test2", value: 70),
            CSPieChartData(title: "test3", value: 70)
        ]
        
        let colorList = [
            UIColor.blue,
            UIColor.brown,
            UIColor.cyan
        ]
        let sum = dataList.map{ $0.value }.reduce(0, +)
        
        for (index, item) in dataList.enumerated() {
            let degree: Double = item.value / sum * 360
            let endAngle = startAngle + degree.toRadian
            
            let colorIndex = index % colorList.count
            let component = CSPieChartComponent(frame: frame, startAngle: startAngle, endAngle: endAngle, data: item, color: colorList[colorIndex])
            let foreground = CSPieChartForegroundView(frame: frame, startAngle: startAngle, endAngle: endAngle, color: UIColor.black)
            startAngle = endAngle
            
            pieChartView.addSubview(component)
            pieChartView.addSubview(foreground)
        }
        
        view.addSubview(pieChartView)
    }
}
