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
        pieChart?.isSelectedAnimation = true
        
        pieChart?.pieChartRadiusRate = 0.6
        pieChart?.pieChartLineLength = 10
        
//        let view1 = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view1.image = UIImage(named: "test.png")
//        view1.contentMode = .scaleAspectFill
//        view1.clipsToBounds = true
//        view1.layer.cornerRadius = view1.frame.width / 2
//        
//        let view2 = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view2.image = UIImage(named: "test.png")
//        view2.contentMode = .scaleAspectFill
//        view2.clipsToBounds = true
//        view2.layer.cornerRadius = view1.frame.width / 2
//        
//        let view3 = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view3.image = UIImage(named: "test.png")
//        view3.contentMode = .scaleAspectFill
//        view3.clipsToBounds = true
//        view3.layer.cornerRadius = view1.frame.width / 2
//        
//        let view4 = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view4.image = UIImage(named: "test.png")
//        view4.contentMode = .scaleAspectFill
//        view4.clipsToBounds = true
//        view4.layer.cornerRadius = view1.frame.width / 2
//        
//        let view5 = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view5.image = UIImage(named: "test.png")
//        view5.contentMode = .scaleAspectFill
//        view5.clipsToBounds = true
//        view5.layer.cornerRadius = view1.frame.width / 2
//        
//        let view6 = UIImageView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
//        view6.image = UIImage(named: "test.png")
//        view6.contentMode = .scaleAspectFill
//        view6.clipsToBounds = true
//        view6.layer.cornerRadius = view1.frame.width / 2
        
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
    
    func numberOfLineColors() -> Int {
        return colorList.count
    }
    
    func pieChartLineColor(at indexPath: IndexPath) -> UIColor {
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
        let data = dataList[indexPath.item]
        print(data.title)
    }
}
