//
//  CommonViewModel.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/3.
//

import Foundation
import SwiftyJSON

class CommonViewModel: NSObject {
    func fetchData(complete:@escaping (_ list: [StockHQ]) -> Void){
        
        var array: [StockHQ] = []
        let model = StockHQ()
        array.append(model)
        complete(array)
    }
    
    func fetchLocalJson() -> [StockHQ] {
        let jsonPath = Bundle.main.path(forResource: "CommonData", ofType: "json")
        guard jsonPath?.count != 0 else { return []}
        
        let d = NSData.init(contentsOfFile: jsonPath ?? "")
        
        
        //let jsonDict = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
        var mArray:[StockHQ] = []
        
        do {
            let dict = try JSON.init(data: d! as Data)
            let array = dict["dataArray"]
            for _ in array {
                let model = StockHQ()
                mArray.append(model)
            }
            
        } catch {
            print(error)
        }
        
        return mArray
    }
}

