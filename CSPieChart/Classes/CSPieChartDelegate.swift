//
//  CSPieChartDelegate.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 6..
//
//

@objc
public protocol CSPieChartDelegate {
    
    /// Component select
    @objc optional func pieChart(_ pieChart: CSPieChart, didSelectComponentAt index: Int)
}
