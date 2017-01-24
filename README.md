# CSPieChart

[![Version](https://img.shields.io/cocoapods/v/CSPieChart.svg?style=flat)](http://cocoapods.org/pods/CSPieChart)
[![License](https://img.shields.io/cocoapods/l/CSPieChart.svg?style=flat)](http://cocoapods.org/pods/CSPieChart)
![iOS 8.3+](https://img.shields.io/badge/iOS-8.3%2B-blue.svg)
![Swift 3.0+](https://img.shields.io/badge/Swift-3.0%2B-orange.svg)

![](Example/ReadMeResource/gif1.gif)
![](Example/ReadMeResource/gif2.gif)
![](Example/ReadMeResource/gif3.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CSPieChart is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CSPieChart"
```

## Useage

![](Example/ReadMeResource/view1.png)
![](Example/ReadMeResource/view2.png)
![](Example/ReadMeResource/view3.png)

First Step  - `import CSPieChart` to your project

Second Step - You should `CSPieChartData`. This is model for piechart.
```Swift
  let data = CSPieChartData(key: "test", value: 70)
```

Third Step - Add a delegate `CSPieChartDataSource` & `CSPieChartDelegate` to your class & add two delegate methods 
```Swift
public protocol CSPieChartDataSource {
    //  This is data for component
    func numberOfComponentData() -> Int
    func pieChartComponentData(at index: Int) -> CSPieChartData
    
    //  This is colors that is component
    func numberOfComponentColors() -> Int
    func pieChartComponentColor(at index: Int) -> UIColor
    
    //  If you implement this, you can show subView. example) 'UIImageView' or 'UILable'
    //  Caution!! You must designate view frame.
    optional func numberOfComponentSubViews() -> Int
    optional func pieChartComponentSubView(at index: Int) -> UIView
    
    //  If you are implement this, you apply color to line path
    //  Otherwish line color is applied default 'black'
    optional func numberOfLineColors() -> Int
    optional func pieChartLineColor(at index: Int) -> UIColor
}
```
```Swift
public protocol CSPieChartDelegate {
    optional func didSelectedPieChartComponent(at index: Int)
}
```

You can set some options

```Swift
    //  Pie chart radius rate that is percentage of frames in the superview. default is 0.7
    public var pieChartRadiusRate: CGFloat = 0.7
    
    // Pie chart line length between component and subview. default is 10
    public var pieChartLineLength: CGFloat = 10
    
    //  This is piechart component selecting animation. default is none
    public var seletingAnimationType: SelectingAnimationType = .none
}
```

If you need more information, check example

## Author

chansim.youk, dbrckstla@naver.com

## License

CSPieChart is available under the MIT license. See the LICENSE file for more info.
