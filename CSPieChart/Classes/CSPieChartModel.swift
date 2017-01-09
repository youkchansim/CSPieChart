//
//  CSPieChartModel.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

public class CSPieChartData: NSObject {
    public var title: String
    public var value: Double
    
    public init(title: String, value: Double) {
        self.title = title
        self.value = value
    }
}
