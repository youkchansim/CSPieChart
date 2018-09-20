//
//  ViewController.swift
//  CSPieChart
//
//  Created by chansim.youk on 01/04/2017.
//  Copyright (c) 2017 chansim.youk. All rights reserved.
//

import UIKit
import CSPieChart

class ViewController: UIViewController {
    
    @IBOutlet weak var pieChart: CSPieChart!
    @IBAction func reloadPieChart(_ sender: Any) {
        pieChart.reloadPieChart()
    }
    
    var dataList = [
        CSPieChartData(key: "test1", value: 30),
        CSPieChartData(key: "test2", value: 30),
        CSPieChartData(key: "test3", value: 30),
        CSPieChartData(key: "test4", value: 30),
        CSPieChartData(key: "test5", value: 30),
        CSPieChartData(key: "test6", value: 30)
    ]
    
    var colorList: [UIColor] = [
        .red,
        .orange,
        .yellow,
        .green,
        .blue,
        .magenta
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pieChart?.dataSource = self
        pieChart?.delegate = self
        
        pieChart?.pieChartRadiusRate = 0.5
        pieChart?.pieChartLineLength = 12
        pieChart?.seletingAnimationType = .touch
        
        pieChart?.show(animated: true)
    }
    
    fileprivate var touchDistance: CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: view) else {
            return
        }
        
        touchDistance = location.x
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: view) else {
            return
        }
        
        touchDistance -= location.x
        
        if touchDistance > 100 {
            print("Right")
        } else if touchDistance < -100 {
            print("Left")
        }
        
        touchDistance = 0
    }
}

extension ViewController: CSPieChartDataSource {
    
    func numberOfComponentData() -> Int {
        return dataList.count
    }
    
    func pieChart(_ pieChart: CSPieChart, dataForComponentAt index: Int) -> CSPieChartData {
        return dataList[index]
    }
    
    func numberOfComponentColors() -> Int {
        return colorList.count
    }
    
    func pieChart(_ pieChart: CSPieChart, colorForComponentAt index: Int) -> UIColor {
        return colorList[index]
    }
    
    func numberOfLineColors() -> Int {
        return colorList.count
    }
    
    func pieChart(_ pieChart: CSPieChart, lineColorForComponentAt index: Int) -> UIColor {
        return colorList[index]
    }
    
    func numberOfComponentSubViews() -> Int {
        return dataList.count
    }
    
    func pieChart(_ pieChart: CSPieChart, viewForComponentAt index: Int) -> UIView {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.image = UIImage(named: "test.png")
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }
}

extension ViewController: CSPieChartDelegate {
    
    func pieChart(_ pieChart: CSPieChart, didSelectComponentAt index: Int) {
        let data = dataList[index]
        print(data.key)
    }
}
