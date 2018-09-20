//
//  CSPieChartDataSource.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 6..
//
//

//  This is datasource for 'CSPieChartViewController'

@objc
public protocol CSPieChartDataSource {
    
    ///  Component data
    func numberOfComponentData() -> Int
    func pieChart(_ pieChart: CSPieChart, dataForComponentAt index: Int) -> CSPieChartData
    
    ///  Component colors
    func numberOfComponentColors() -> Int
    func pieChart(_ pieChart: CSPieChart, colorForComponentAt index: Int) -> UIColor
    
    ///  If you are implement this, you can show subView. example) 'UIImageView' or 'UILable'
    @objc optional func numberOfComponentSubViews() -> Int
    @objc optional func pieChart(_ pieChart: CSPieChart, viewForComponentAt index: Int) -> UIView
    
    ///  If you are implement this, you apply color to line path
    ///  Otherwish line color is applied default 'black'
    @objc optional func numberOfLineColors() -> Int
    @objc optional func pieChart(_ pieChart: CSPieChart, lineColorForComponentAt index: Int) -> UIColor
}
