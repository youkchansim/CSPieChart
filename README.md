# CSPieChart

[![CI Status](http://img.shields.io/travis/chansim.youk/CSPieChart.svg?style=flat)](https://travis-ci.org/chansim.youk/CSPieChart)
[![Version](https://img.shields.io/cocoapods/v/CSPieChart.svg?style=flat)](http://cocoapods.org/pods/CSPieChart)
[![License](https://img.shields.io/cocoapods/l/CSPieChart.svg?style=flat)](http://cocoapods.org/pods/CSPieChart)
[![Platform](https://img.shields.io/cocoapods/p/CSPieChart.svg?style=flat)](http://cocoapods.org/pods/CSPieChart)

![](Example/ReadMeResource/gif1.gif)
![](Example/ReadMeResource/gif2.gif)

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

First Step  - `@import CSPieChart` to your project

Second Step - You should `CSPieChartData`. This is model for piechart.
```Swift
  let data = CSPieChartData(title: "test", value: 70)
```

Third Step - Add a delegate `CSPieChartDataSource` & `CSPieChartDelegate` to your class & add two delegate methods 
```Swift
public protocol CSPieChartDataSource {
    //  This is data for component
    func numberOfComponentData() -> Int
    func pieChartComponentData(at indexPath: IndexPath) -> CSPieChartData
    
    //  This is colors that is component
    func numberOfComponentColors() -> Int
    func pieChartComponentColor(at indexPath: IndexPath) -> UIColor
    
    //  If you implement this, you can show subView. example) 'UIImageView' or 'UILable'
    //  Caution!! You must designate view frame.
    func numberOfComponentSubViews() -> Int
    func pieChartComponentSubView(at indexPath: IndexPath) -> UIView
    
    //  If you are implement this, you apply color to line path
    //  Otherwish line color is applied default 'black'
    func numberOfLineColors() -> Int
    func pieChartLineColor(at indexPath: IndexPath) -> UIColor
}
```

If you need more information, check example

## Author

chansim.youk, dbrckstla@naver.com

## License

CSPieChart is available under the MIT license. See the LICENSE file for more info.
