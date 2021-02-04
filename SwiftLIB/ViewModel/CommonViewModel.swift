//
//  CommonViewModel.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/3.
//

import Foundation

typealias StingAnyDictionry = Dictionary<String, Any>

class CommonViewModel: NSObject {
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
        m.stockHq = model
        return m
    }
}

