//
//  ViewController.swift
//  CryptoRates
//
//  Created by Kyrylo Kolosov on 2023-01-16.
//

import UIKit

class ViewController: UIViewController{
    
    
    @IBOutlet weak var firstPicker: UIPickerView!
    @IBOutlet weak var secondPicker: UIPickerView!
    @IBOutlet weak var bitCoinButton: UIButton!
    
    private var model = CryptoRatesModel()
    private var firstCurrencyLabel = ""
    private var secondCurrencyLabel = ""
    var rate = "12222.22222"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        firstPicker.dataSource = self
        firstPicker.delegate = self
        secondPicker.dataSource = self
        secondPicker.delegate = self
        bitCoinButton.setImage(UIImage(named: "bitcoin_pink"), for: .normal)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        
        performSegue(withIdentifier: "goToResult", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
                let destinationVC = segue.destination as! ResultViewController
                destinationVC.labelOne = self.firstCurrencyLabel
                destinationVC.labelTwo = self.secondCurrencyLabel
                destinationVC.rate = rate

            
        }
    }
 
    
}
//MARK: - PickerViewDelegate
extension ViewController : CryptoRatesModelDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCurrencyRate(price: String, firstCurrency: String, secondCurrency: String) {
            self.firstCurrencyLabel = firstCurrency
            self.secondCurrencyLabel = secondCurrency
            self.rate = price
    }
    
    
}

extension ViewController :UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            firstCurrencyLabel = model.firstCurrencyArray[row]
        }
        if pickerView.tag == 2 {
            secondCurrencyLabel = model.secondCurrencyArray[row]
            model.fetchCurrency(from: firstCurrencyLabel, to: secondCurrencyLabel)
            print()
        }
        
    }
}
//MARK: - CryptoRatesModelDelegate



//MARK: -  PickerViewDataSource
extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return model.firstCurrencyArray.count
        }else if pickerView.tag == 2{
            return model.secondCurrencyArray.count
        }else{
            return 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return model.firstCurrencyArray[row]
        }else{
            return model.secondCurrencyArray[row]
        }
    }
    
}


