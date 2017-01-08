//
//  CSPieChartViewController.swift
//  Pods
//
//  Created by Youk Chansim on 2017. 1. 5..
//
//

import UIKit

public class CSPieChartViewController: UIViewController {
    
    public var dataSource: CSPieChartDataSource?
    public var delegate: CSPieChartDelegate?
    
    public var pieChartRadiusRate: CGFloat = 0.7
    public var pieChartLineLength: CGFloat = 10
    
    fileprivate var pieChartView: UIView?
    fileprivate var selectedComponent: CSPieChartComponent?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let randomValue = Double(arc4random() % 361)
        var startAngle = randomValue.toRadian
        
        let width = view.frame.width
        let height = width
        let size = CGSize(width: width, height: height)
        
        let pieChartPoint = CGPoint(x: 0, y: 0)
        let pieChartFrame = CGRect(origin: pieChartPoint, size: size)
        pieChartView = UIView(frame: pieChartFrame)
        
        if let itemCount = dataSource?.numberOfComponentData() {
            
            var sum: Double = 0
            for index in 0..<itemCount {
                if let data = dataSource?.pieChartComponentData(at: IndexPath(item: index, section: 0)) {
                    sum += data.value
                }
            }
            
            for index in 0..<itemCount {
                if let data = dataSource?.pieChartComponentData(at: IndexPath(item: index, section: 0)) {
                    let degree: Double = data.value / sum * 360
                    let endAngle = startAngle + degree.toRadian
                    
                    let componentColorsCount = dataSource?.numberOfComponentColors() ?? 0
                    let compoenetColorIndexPath = IndexPath(item: index % componentColorsCount, section: 0)
                    let componentColor = dataSource?.pieChartComponentColor(at: compoenetColorIndexPath) ?? UIColor.white
                    let component = CSPieChartComponent(frame: pieChartFrame, startAngle: startAngle, endAngle: endAngle, data: data, color: componentColor, radiusRate: self.pieChartRadiusRate)
                    
                    let lineColorsCount = dataSource?.numberOfLineColors?() ?? 0
                    let lineColorIndexPath = IndexPath(item: index % componentColorsCount, section: 0)
                    let lineColor = dataSource?.pieChartLineColor?(at: lineColorIndexPath) ?? UIColor.black
                    
                    if let subViewsCount = dataSource?.numberOfComponentSubViews?() {
                        let subViewIndexPath = IndexPath(item: index % subViewsCount, section: 0)
                        let subView = dataSource?.pieChartComponentSubView?(at: subViewIndexPath) ?? UIView()
                        let foregroundView = CSPieChartForegroundView(frame: pieChartFrame, startAngle: startAngle, endAngle: endAngle, lineColor: lineColor, radiusRate: self.pieChartRadiusRate, subView: subView, lineLength: self.pieChartLineLength)
                        
                        pieChartView?.addSubview(component)
                        pieChartView?.addSubview(foregroundView)
                    } else {
                        pieChartView?.addSubview(component)
                    }
                    
                    startAngle = endAngle
                }
            }
        }
        
        if let pieChart = pieChartView {
            view.addSubview(pieChart)
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: pieChartView) {
            for subView in pieChartView!.subviews {
                if subView is CSPieChartComponent {
                    if let layer = subView.layer.mask as? CAShapeLayer, let path = layer.path {
                        if path.contains(location), let component = subView as? CSPieChartComponent {
                            if selectedComponent != component {
                                selectedComponent?.stopPieceAnimation()
                                selectedComponent = nil
                            }
                            
                            if !component.isAnimated! {
                                component.startPieceAnimation()
                                selectedComponent = component
                            } else {
                                component.stopPieceAnimation()
                                selectedComponent = nil
                            }
                        }
                    }
                }
            }
        }
    }
}
