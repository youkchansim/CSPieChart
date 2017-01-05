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
    func pieChartComponentData(at indexPath: IndexPath) -> CSPieChartData
    
    func numberOfComponentColors() -> Int
    func pieChartComponentColor(at indexPath: IndexPath) -> UIColor
    
    //  If you are implement this, you can show subView. example) 'UIImageView' or 'UILable'
    @objc optional func numberOfComponentSubViews() -> Int
    @objc optional func pieChartComponentSubView(at indexPath: IndexPath) -> UIView
    
    //  If you are implement this, you apply color to line path
    //  Otherwish line color is applied default 'black'
    @objc optional func numberOfLineColors() -> Int
    @objc optional func pieChartLineColor(at indexPath: IndexPath) -> UIColor
}
