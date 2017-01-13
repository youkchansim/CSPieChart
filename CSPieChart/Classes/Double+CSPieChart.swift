//
//  Double+Extension.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

extension Double {
    var toRadian: CGFloat {
        return CGFloat(self * (M_PI / 180))
    }
}
