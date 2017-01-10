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
    func numberOfComponentData() -> Int
    func pieChartComponentData(at index: Int) -> CSPieChartData
    
    func numberOfComponentColors() -> Int
    func pieChartComponentColor(at index: Int) -> UIColor
    
    //  If you are implement this, you can show subView. example) 'UIImageView' or 'UILable'
    @objc optional func numberOfComponentSubViews() -> Int
    @objc optional func pieChartComponentSubView(at index: Int) -> UIView
    
    //  If you are implement this, you apply color to line path
    //  Otherwish line color is applied default 'black'
    @objc optional func numberOfLineColors() -> Int
    @objc optional func pieChartLineColor(at index: Int) -> UIColor
}
