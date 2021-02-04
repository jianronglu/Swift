//
//  StockHQ.swift
//  SwiftLIB
//
//  Created by Lu on 2021/2/3.
//

import Foundation
import HandyJSON // json 与 model 互换第三方库

class ExtraData: HandyJSON {
    var monthChgRatio: Int?
    var actBSFlag: Int?
    var buyTotalVol: Int?
    var iopv: Int?
    var buyAvgPrice: Int?
    var matchVol: Int?
    var refPrice: Int?
    var gzhgBP: Int?
    var commitDiff: Int?
    var unmatchVol: Int?
    var totalChg: Int?
    var sellTotalVol: Int?
    var maxPriceHistory: Int?
    var day20ChgRatio: Int?
    var refPriceEnd: Int?
    var day10ChgRatio: Int?
    var minPriceHistory: Int?
    var committee: Float?
    var seasonChgRatio: Int?
    var sellPriceNum: Int?
    var gzhgAvgBP: Int?
    var day5ChgRatio: Int?
    var yearChgRatio: Int?
    var commitSum: Int?
    var buyPriceNum: Int?
    var refPriceStart: Int?
    var afterDealVol: Int?
    var returnRateIn10Day: Int?
    var maxPrice52Week: Int?
    var lastChangeValue: Int?
    var blockTrade: Bool?
    var afterDealAmount: Int?
    var thisYearChgRatio: Int?
    var minPrice52Week: Int?
    var sellAvgPrice: Int?
    
    required init() {} // 使用 HandyJSON 必须
}

class XsbData: HandyJSON {
    var zrType: Int?
    var securityType: Int?
    var fcType: Int?
    var cqcxStatus: Int?
    var zrStatus: Int?
    var marketMakeCount: Int?
    var diffRight: Int?
    var tpStatus: Int?
    
    required init() {}
}

class StockHQ: HandyJSON {
    var xsb: XsbData?
    var extData: ExtraData?
    var equalCount: Int?
    var headSetCode: Int?
    var ztCount: Int?
    var changeValue: Float?
    var stockNum: Int?
    var isSupportCYBReg: Bool?
    var hyBlockCode: String?
    var isGDR: Bool?
    var tradeStatus: Int?
    var endDate: Int?
    var netProfitGrowthRatio3Y: Int?
    var ipoStocks: Int?
    var riseCount: Int?
    var longName: String?
    var intrinsicValue: Int?
    var isStFlag: Bool?
    var ipoPrice: Float?
    var everyHand: Int?
    var origCategory: Int?
    var upDays: Int?
    var openPrice: Int?
    var pbRatio: Float?
    var peRatioTTM: Float?
    var nowVol: Int?
    var code: String?
    var yClosePrice: Float?
    var hasHKMarginMark: Bool?
    var holdVol: Int?
    var lybCurrDayRank: Int?
    var impliedVolatility: Int?
    var perStockNetAsset: Float?
    var lowPrice: Float?
    var hasSecuritiesMark: Bool?
    var headNowPrice: Int?
    var openAmount: Int?
    var tagType: Int?
    var name: String?
    var ySettlementPrice: Int?
    var diffRight: Bool?
    var divideRateLFY: Int?
    var relatedBlockId: String?
    var changeRatio: Float?
    var category: Int?
    var dealAmount: Int?
    var dealVol: Int?
    var premiumRatio: Int?
    var nowVolBSFlag: Int?
    var circulationStocks: Int?
    var hkCAS: Bool?
    var insideVol: Int?
    var tagTypes: [Int]?
    var netAssetPRatio: Float?
    var peRatio: Float?
    var divideTTM: Int?
    var isProControl: Bool?
    var leverageRatio: Int?
    var hyBlockName: String?
    var coinType: Int?
    var hasMarginMark: Float?
    var subCategory: Int?
    var limitUpPrice: Int?
    var zdLimit: Int?
    var minutes: Int?
    var tradeDate: Int?
    var netValue: Float?
    var isCDR: Bool?
    var zczb: Int?
    var hkdOpenHighLimitPrice: Int?
    var swingRatio: Float?
    var tradeTime: Int?
    var openVolume: Int?
    var headChangeValue: Int?
    var lybPreDayRank: Int?
    var isZT: Bool?
    var highPrice: Float?
    var fallCount: Int?
    var totalStocks: Int?
    var peRatioStatic: Float?
    var revenueGrowthRatio3Y: Int?
    var outsideVol: Int?
    var nowPrice: Int?
    var hkVCM: Bool?
    var headChangeRatio: Int?
    var openInterestDiff: Int?
    var turnoverRate: Float?
    var totalMarketValue: Int?
    var isIpoPrime: Bool?
    var circulationMarketValue: Int?
    var divideRateTTM: Int?
    var volRatio: Float?
    var blockInfoArray: [Dictionary<String, AnyObject>]?
    var ipoFlag: Bool?
    var boardDays: Int?
    var limitUpDownMark: Int?
    var hkOpenLowLimitPrice: Int?
    var limitDownPrice: Int?
    var setCode: Int?
    var isDeficit: Bool?
    var hkPOS: Bool?
    var perStockIncome: Float?
    var avgPrice: Int?
    var ipoDate: Int?
    var upSpeed: Int?
    var precise: Int?
    var warrantType: Int?
    var divideLFY: Int?
    var sameRight: Bool?
    
    required init() {}
}

class TableItemModel: HandyJSON {
    var stockHq: StockHQ?
    required init() {}
}
