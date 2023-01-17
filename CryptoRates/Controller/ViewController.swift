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
    @IBAction func buttonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destinationVC = segue.destination as! ResultViewController
        
        // Pass the selected object to the new view controller.
    }
    
    let model = CryptoRatesModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstPicker.dataSource = self
        firstPicker.delegate = self
        secondPicker.dataSource = self
        secondPicker.delegate = self
        bitCoinButton.setImage(UIImage(named: "bitcoin_pink"), for: .normal)
    }
}
extension ViewController :UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if model.firstCurrencyArray[row] != "Choose currency" && model.secondCurrencyArray[row] != "Choose currency"{
            let one = model.firstCurrencyArray[row]
            let two = model.secondCurrencyArray[row]
            model.fetchCurrency(from: one, to: two)
        }
    }
    
}
extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return model.firstCurrencyArray.count
        }else{
            return model.secondCurrencyArray.count
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


