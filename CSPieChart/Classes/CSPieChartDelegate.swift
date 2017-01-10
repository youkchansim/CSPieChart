//
//  CSPieChartDelegate.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 6..
//
//

@objc
public protocol CSPieChartDelegate {
    @objc optional func didSelectedPieChartComponent(at index: Int)
}
