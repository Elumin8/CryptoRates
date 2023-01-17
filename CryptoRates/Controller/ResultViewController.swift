//
//  ResultViewController.swift
//  CryptoRates
//
//  Created by Kyrylo Kolosov on 2023-01-16.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var firstCurrencyLabel: UILabel!
    
    @IBOutlet weak var secondCurrencyLabel: UILabel!
    
    @IBOutlet weak var currentRate: UILabel!
    var labelOne = ""
    var labelTwo = ""
    var rate = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstCurrencyLabel.text = labelOne
        secondCurrencyLabel.text = labelTwo
        currentRate.text = rate
        
        
    }
    
    @IBAction func recalculate(_ sender: UIButton) {
        self.dismiss(animated: true)
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
