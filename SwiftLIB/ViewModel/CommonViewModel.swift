//
//  CommonViewModel.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/3.
//

import Foundation

typealias StingAnyDictionry = Dictionary<String, Any>

class CommonViewModel: NSObject {
    private var _titles: [String]? = []
    var titles: [String]? {
        set(titles) {
            _titles = titles
        }
        get {
            if _titles?.count == 0 {
                _titles = commonTableViewRightItemTitles.components(separatedBy: ",")
            }
            return _titles
        }
    }
    
    func fetchData(complete: @escaping (_ stockArr: [StockHQ], _ itemArr: [TableItemModel]) -> Void){
        
        let (stockArr, itemArr) = fetchLocalJson()
        
        complete(stockArr, itemArr)
    }
    
    private func fetchLocalJson() -> ([StockHQ], [TableItemModel]) {
        
        let URL = R.file.commonDataJson()
        
        let path = URL?.path
        
        guard path?.count != 0 else { return ([],[])}
        
        let data = NSData.init(contentsOfFile: path ?? "")! as Data
        
        var mArray:[StockHQ] = []
        var itemArray:[TableItemModel] = []
        
        let jsonDict = jsonObj(data: data)
        
        let array = jsonDict[commonDataArrayName] as! Array<StingAnyDictionry>
        
        for dict in array {
            let model = stockHQ(dict: dict)
            mArray.append(model ?? StockHQ())
            
            let item = tableItem(model: model)
            itemArray.append(item)
        }
        return (mArray, itemArray)
    }
    /* - 弃用使用 R.Swift 管理资源
    private func filepath() -> String {
        return Bundle.main.path(forResource: "CommonData", ofType: "json") ?? ""
    }*/
    
    private func jsonObj(data: Data) -> StingAnyDictionry {
        let dict = try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! StingAnyDictionry
        return dict
    }
    
    private func stockHQ(dict: [String:Any]) -> StockHQ? {
        let model = StockHQ.deserialize(from: dict)
        
        if model?.longName?.count != 0 {
            model?.name = model?.longName
        }
        return model
    }
    
    private func tableItem(model: StockHQ?) -> TableItemModel {
        let m = TableItemModel()
        m.name = model?.name
        m.code = model?.code
        m.itemList = ItemList(model: model)
        return m
    }
    
    func ItemList(model: StockHQ?) -> [ItemModel]? {
        var items:[ItemModel] = []
        
        let zxjItem = createItem(num: model?.nowPrice, precise: model?.precise, describe: "最新价")
        items.append(zxjItem)
        
        let zdfItem = createItem(num: model?.changeRatio, style: .percent, precise: model?.precise, describe: "涨跌幅")
        items.append(zdfItem)
        
        let zdeItem = createItem(num: model?.changeValue, precise:  model?.precise, describe: "涨跌额")
        items.append(zdeItem)
        
        let zsItem = createItem(num: model?.yClosePrice, precise:  model?.precise, describe: "昨收")
        items.append(zsItem)
        
        let upItem = createItem(num: model?.changeValue, style: .percent, precise:  model?.precise, describe: "涨速")
        items.append(upItem)
        
        let rateItem = createItem(num: model?.turnoverRate, style: .percent, precise: model?.precise, describe: "换手率")
        items.append(rateItem)
        
        let cjlItem = createItem(num: model?.dealVol, describe: "成交量")
        items.append(cjlItem)
        
        let cjeItem = createItem(num: model?.dealAmount, describe: "成交额")
        items.append(cjeItem)
        
        let openItem = createItem(num: model?.openPrice, precise:  model?.precise, describe: "今开")
        items.append(openItem)
        
        let zgItem = createItem(num: model?.highPrice, precise:  model?.precise, describe: "最高")
        items.append(zgItem)
        
        let lowItem = createItem(num: model?.lowPrice, precise:  model?.precise, describe: "最低")
        items.append(lowItem)
        
        let peItem = createItem(num: model?.peRatio, precise:  model?.precise, describe: "市盈率")
        items.append(peItem)
        
        return items
    }

    func createItem(num: Float?, precise: UInt?, describe: String) -> ItemModel  {
        return createItem(num: num, style: .decimal, precise: precise, describe: describe)
    }
    
    func createItem(num: Float?, style:NumberFormatter.Style, precise: UInt?, describe: String) -> ItemModel {
        let item = ItemModel()
        item.describe = describe
        item.title = DecimalNumberUtil.transNumber(num: num, style: style, precise: precise)
        item.width = 100
        return item
    }
    
    func createItem(num: Int?, describe: String) -> ItemModel {
        let item = ItemModel()
        item.describe = describe
        item.title = DecimalNumberUtil.transNumber(num: num, style: .none)
        item.width = 100
        return item
    }
}

/*
 - 0 : "最新价"
 - 1 : "涨跌幅"
 - 2 : "涨跌额"
 - 3 : "昨收"
 - 4 : "涨速"
 - 5 : "换手率"
 - 6 : "成交量"
 - 7 : "成交额"
 - 8 : "今开"
 - 9 : "最高"
 - 10 : "最低"
 - 11 : "市盈率"
 */
