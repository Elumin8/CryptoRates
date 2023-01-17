//
//  CryptoData.swift
//  CryptoRates
//
//  Created by Kyrylo Kolosov on 2023-01-17.
//

import Foundation

struct CryptoData: Codable{
    var asset_id_base :String
    var asset_id_quote: String
    var rate: Double
}
