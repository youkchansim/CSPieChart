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
    
    var subViewList: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pieChart?.dataSource = self
        pieChart?.delegate = self
        
        pieChart?.pieChartRadiusRate = 0.6
        pieChart?.pieChartLineLength = 10
        pieChart?.seletingAnimationType = .touch
        
        let view1 = UILabel()
        view1.text = "red"
        view1.textAlignment = .center
        view1.sizeToFit()
        
        let view2 = UILabel()
        view2.text = "orange"
        view2.textAlignment = .center
        view2.sizeToFit()
        
        let view3 = UILabel()
        view3.text = "yellow"
        view3.textAlignment = .center
        view3.sizeToFit()
        
        let view4 = UILabel()
        view4.text = "green"
        view4.textAlignment = .center
        view4.sizeToFit()
        
        let view5 = UILabel()
        view5.text = "blue"
        view5.textAlignment = .center
        view5.sizeToFit()
        
        let view6 = UILabel()
        view6.text = "magenta"
        view6.textAlignment = .center
        view6.sizeToFit()
        
        subViewList.append(view1)
        subViewList.append(view2)
        subViewList.append(view3)
        subViewList.append(view4)
        subViewList.append(view5)
        subViewList.append(view6)
    }
}

extension ViewController: CSPieChartDataSource {
    func numberOfComponentData() -> Int {
        return dataList.count
    }
    
    func pieChartComponentData(at index: Int) -> CSPieChartData {
        return dataList[index]
    }
    
    func numberOfComponentColors() -> Int {
        return colorList.count
    }
    
    func pieChartComponentColor(at index: Int) -> UIColor {
        return colorList[index]
    }
    
    func numberOfLineColors() -> Int {
        return colorList.count
    }
    
    func pieChartLineColor(at index: Int) -> UIColor {
        return colorList[index]
    }
    
    func numberOfComponentSubViews() -> Int {
        return subViewList.count
    }
    
    func pieChartComponentSubView(at index: Int) -> UIView {
        return subViewList[index]
    }
}

extension ViewController: CSPieChartDelegate {
    func didSelectedPieChartComponent(at index: Int) {
        let data = dataList[index]
        print(data.key)
    }
}
