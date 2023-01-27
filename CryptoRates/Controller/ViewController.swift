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
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var tenButton: UIButton!
    @IBOutlet weak var fiftyButton: UIButton!
    @IBOutlet weak var hundredButton: UIButton!
    
    private var model = CryptoRatesModel()
    private var firstCurrencyLabel = ""
    private var secondCurrencyLabel = ""
    var multipier = 1.0
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        firstPicker.dataSource = self
        firstPicker.delegate = self
        secondPicker.dataSource = self
        secondPicker.delegate = self
        bitCoinButton.setImage(UIImage(named: "bitcoin_pink"), for: .normal)
        textField.attributedPlaceholder = NSAttributedString(string: "99", attributes: [NSAttributedString.Key.foregroundColor:UIColor.lightGray])
    }
    
    @IBAction func multipierSelected(_ sender: UIButton) {
        oneButton.isSelected = false
        tenButton.isSelected = false
        fiftyButton.isSelected = false
        hundredButton.isSelected = false
        sender.isSelected = true
        let choice = sender.currentTitle!
        let numberChoice = Double(choice)!
        multipier = numberChoice
        if sender.isSelected{
            self.textField.text = .none
            self.textField.backgroundColor = .black
        }
        self.textField.endEditing(true)
    }
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        oneButton.isSelected = false
        tenButton.isSelected = false
        fiftyButton.isSelected = false
        hundredButton.isSelected = false
        textField.clearsOnBeginEditing = true
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.black
        
        
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        model.fetchCurrency(from: firstCurrencyLabel, to: secondCurrencyLabel)
        performSegue(withIdentifier: "goToResult", sender: self)
        self.textField.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.labelOne = firstCurrencyLabel
            destinationVC.labelTwo = secondCurrencyLabel
            destinationVC.multiplier = multipier
            
            
        }
    }

    
    
}
//MARK: - PickerViewDelegate


extension ViewController :UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textField.endEditing(true)
        if pickerView.tag == 1{
            firstCurrencyLabel = model.firstCurrencyArray[row]
                    }
        if pickerView.tag == 2 {
            secondCurrencyLabel = model.secondCurrencyArray[row]

        }
        
        
    }
}


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
//MARK: - UITextFieldDelegate


extension ViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let doubleText = Double(textField.text ?? "33") ?? 1
        multipier = doubleText
        print(multipier)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 3
        if textField.text!.count <= maxLength{
            return true
        }else{
            textField.text = .none
            return false
        }
    }
}
    


