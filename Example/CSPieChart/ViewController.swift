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

    var pieChart: CSPieChartViewController?
    
    var dataList = [
        CSPieChartData(title: "test1", value: 30),
        CSPieChartData(title: "test2", value: 30),
        CSPieChartData(title: "test3", value: 30),
        CSPieChartData(title: "test4", value: 30),
        CSPieChartData(title: "test5", value: 30),
        CSPieChartData(title: "test6", value: 30)
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
//        let view1 = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view1.backgroundColor = UIColor.red
//        view1.layer.cornerRadius = view1.frame.width / 2
//        
//        let view2 = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view2.backgroundColor = UIColor.orange
//        view2.layer.cornerRadius = view1.frame.width / 2
//        
//        let view3 = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view3.backgroundColor = UIColor.yellow
//        view3.layer.cornerRadius = view1.frame.width / 2
//        
//        let view4 = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view4.backgroundColor = UIColor.green
//        view4.layer.cornerRadius = view1.frame.width / 2
//        
//        let view5 = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view5.backgroundColor = UIColor.blue
//        view5.layer.cornerRadius = view1.frame.width / 2
//        
//        let view6 = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view6.backgroundColor = UIColor.magenta
//        view6.layer.cornerRadius = view1.frame.width / 2
        let view1 = UILabel()
        view1.text = "red"
        view1.textAlignment = .center
        view1.backgroundColor = UIColor.groupTableViewBackground
        view1.sizeToFit()
        
        let view2 = UILabel()
        view2.text = "orange"
        view2.textAlignment = .center
        view2.backgroundColor = UIColor.groupTableViewBackground
        view2.sizeToFit()
        
        let view3 = UILabel()
        view3.text = "yellow"
        view3.textAlignment = .center
        view3.backgroundColor = UIColor.groupTableViewBackground
        view3.sizeToFit()
        
        let view4 = UILabel()
        view4.text = "green"
        view4.textAlignment = .center
        view4.backgroundColor = UIColor.groupTableViewBackground
        view4.sizeToFit()
        
        let view5 = UILabel()
        view5.text = "blue"
        view5.textAlignment = .center
        view5.backgroundColor = UIColor.groupTableViewBackground
        view5.sizeToFit()
        
        let view6 = UILabel()
        view6.text = "magenta"
        view6.textAlignment = .center
        view6.backgroundColor = UIColor.groupTableViewBackground
        view6.sizeToFit()
        
        subViewList.append(view1)
        subViewList.append(view2)
        subViewList.append(view3)
        subViewList.append(view4)
        subViewList.append(view5)
        subViewList.append(view6)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "pieChart" {
            self.pieChart = segue.destination as? CSPieChartViewController
        }
    }
}

extension ViewController: CSPieChartDataSource {
    func numberOfComponentData() -> Int {
        return dataList.count
    }
    
    func pieChartComponentData(at indexPath: IndexPath) -> CSPieChartData {
        let index = indexPath.item
        return dataList[index]
    }
    
    func numberOfComponentColors() -> Int {
        return colorList.count
    }
    
    func pieChartComponentColor(at indexPath: IndexPath) -> UIColor {
        let index = indexPath.item
        return colorList[index]
    }
    
    func numberOfComponentSubViews() -> Int {
        return subViewList.count
    }
    
    func pieChartComponentSubView(at indexPath: IndexPath) -> UIView {
        let index = indexPath.item
        return subViewList[index]
    }
}

extension ViewController: CSPieChartDelegate {
    func didSelectedPieChartComponent(at indexPath: IndexPath) {
        
    }
}
