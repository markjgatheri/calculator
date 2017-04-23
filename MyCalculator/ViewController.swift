//
//  ViewController.swift
//  MyCalculator
//
//  Created by Apple on 23/04/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblDisplay: UILabel!
    var isUserTyping: Bool = false
    var model: calculatorModel = calculatorModel()
    
    var displayValue: Double {
        get{
            return Double(lblDisplay.text!)!
        }
        set{
            lblDisplay.text = String(newValue)
        }
    }
    
    @IBAction func digitTouched(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        if isUserTyping {
            lblDisplay.text =  lblDisplay.text! + digit
            
        }else{
            lblDisplay.text = digit
        }
        isUserTyping = true
    }
 

    
    
    @IBAction func performoperation(_ sender: UIButton) {
        print("clicked")
        
        if isUserTyping {
            model.getOperands(operand: displayValue)
            isUserTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            model.performOperation(symbol: mathSymbol)
            
        }
        displayValue = model.result
    }
}


