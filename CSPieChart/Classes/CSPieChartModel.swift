//
//  CSPieChartModel.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

public class CSPieChartData: NSObject {
    public var key: String
    public var value: Double
    
    public init(key: String, value: Double) {
        self.key = key
        self.value = value
    }
}
