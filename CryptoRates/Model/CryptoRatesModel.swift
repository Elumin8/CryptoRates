//
//  CryptoRatesModel.swift
//  CryptoRates
//
//  Created by Kyrylo Kolosov on 2023-01-17.
//

import Foundation
protocol CryptoRatesModelDelegate{
    func didFailWithError(error: Error)
    func didUpdateCurrencyRate(price: String, firstCurrency: String, secondCurrency: String )
}
struct CryptoRatesModel {
    var delegate: CryptoRatesModelDelegate?
    
    let firstCurrencyArray = ["Choose currency","BTC"]
    let secondCurrencyArray = ["Choose currency","USD"]
    
    let apiURL = "https://rest.coinapi.io/v1/exchangerate/"
    let apiKey = "DC74734C-6828-431C-A8AE-10AC9064EB55"
    
    
    func fetchCurrency(from firstCurrency: String, to secondCurrency:String){
        let finalURL = "\(apiKey)/\(firstCurrency)/\(secondCurrency)?apikey=\(apiKey)"
        if let url = URL(string: finalURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let firstCurrencyPrice = parseJSON(currencyData: safeData){
                        let price = String(format: "%.5f", firstCurrencyPrice)
                        delegate?.didUpdateCurrencyRate(price: price, firstCurrency: firstCurrency, secondCurrency: secondCurrency)
                    }
                }
            }
        }
    }
    func parseJSON(currencyData: Data) -> Double?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CryptoData.self, from: currencyData)
            let rate = decodedData.rate
            return rate
        }catch{
            print("Error with parsing \(error)")
            return nil
        }
        
    }
}
