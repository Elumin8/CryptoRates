//
//  ResultViewController.swift
//  CryptoRates
//
//  Created by Kyrylo Kolosov on 2023-01-16.
//

import UIKit

class ResultViewController: UIViewController, CryptoRatesModelDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCurrencyRate(price: String, firstCurrency: String, secondCurrency: String) {
        newRate = price
        labelOne = firstCurrency
        labelTwo = secondCurrency
    }
    
    

    @IBOutlet weak var firstCurrencyLabel: UILabel!
    
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    
    @IBOutlet weak var currentRate: UILabel!
    var labelOne = ""
    var labelTwo = ""
    var multiplier : Double = 1.0
    var newRate = ""
    var model = CryptoRatesModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        // Do any additional setup after loading the view.
        firstCurrencyLabel.text = labelOne
        secondCurrencyLabel.text = labelTwo
        currentRate.text =  ""
        
    }
    var viewOne = ViewController()
    
    @IBAction func recalculate(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        model.fetchCurrency(from: labelOne, to: labelTwo)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        newRate = multilyingCoin(multiplier: multiplier)
        currentRate.text = newRate
    }
    func multilyingCoin(multiplier : Double) -> String{
        let currencyPrice = Double(newRate)!
        let multik = currencyPrice * multiplier
        let stringNewValue = String(format: "%.5f",multik)
        return stringNewValue
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
