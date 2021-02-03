//
//  CommonViewModel.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/3.
//

import Foundation

class CommonViewModel: NSObject {
    func fetchData(complete:@escaping (_ list: [StockHQ]) -> Void){
        
        let array:[StockHQ] = fetchLocalJson()
        
        complete(array)
    }
    
    private func fetchLocalJson() -> [StockHQ] {
        
        let jsonPath = filepath()
        
        guard jsonPath.count != 0 else { return []}
        
        var mArray:[StockHQ] = []
        
        let data = NSData.init(contentsOfFile: jsonPath)
        
        let jsonDict = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
        
        let array = jsonDict["dataArray"] as! Array<Dictionary<String, Any>>
        
        for dict in array {
            let model = StockHQ.deserialize(from: dict)
            
            if model != nil {
                if model?.longName?.count != 0 {
                    model?.name = model?.longName
                }
                mArray.append(model!)
            }
        }
        return mArray
    }
    
    private func filepath() -> String {
        return Bundle.main.path(forResource: "CommonData", ofType: "json") ?? ""
    }
}

