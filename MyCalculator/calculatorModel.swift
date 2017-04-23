//
//  calculatorModel.swift
//  MyCalculator
//
//  Created by Apple on 23/04/2017.
//  Copyright © 2017 Strathmore. All rights reserved.
//

import Foundation



class calculatorModel {
    private var accumulator = 0.0
     private var valueOperand=""
    
    
    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constants(M_PI),
        "√" : Operation.UnaryOperations(sqrt),
        "÷" : Operation.BinaryOperation(/,{"("+$0+"/"+$1+")"}),
        "×" :Operation.BinaryOperation(*,{"("+$0+"*"+$1+")"}),//closure
        
        "+" : Operation.BinaryOperation(+,{"("+$0+"+"+$1+")"}),
        
        "-" : Operation.BinaryOperation(-,{"("+$0+"-"+$1+")"}),
        "=" : Operation.Equals,
        
        
        "Sin" : Operation.UnaryOperations({sin($0)}),
        
        "Cos" : Operation.UnaryOperations({cos($0)}),
        
        "Tan" : Operation.UnaryOperations({tan($0)}),
        
        "℮" : Operation.Constants(M_E),
        
        "%" : Operation.UnaryOperations({$0/100}),
        
        "±" : Operation.UnaryOperations({-1*$0}),
        
        "AC": Operation.Clear
    ]
    
    private enum Operation {
        case Constants(Double)
        case UnaryOperations((Double) -> Double)
        case BinaryOperation((Double,Double)->Double,(String,String)->String)
        case Equals
        
         case Clear
    }
    
    private struct PendingBinaryOp{
        var binaryFunc: (Double, Double) -> Double
        var firstOperand: Double
        
        var stringFunc:(String,String)->String
        
        var stringOperand:String
        
    }
    
    private var pending: PendingBinaryOp?
    
    
    
    func getOperands(operand: Double) {
        accumulator = operand
        valueOperand=String(operand)
        
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constants(let value):
                accumulator = value
                
            case .UnaryOperations(let function):
                accumulator = function(accumulator)
                
            case .BinaryOperation(let function,let functionString):
                
                executeOp()
                
                pending=PendingBinaryOp(binaryFunc: function, firstOperand: accumulator,stringFunc: functionString,stringOperand: valueOperand)
                
            case .Equals:
                executeOp()
             
            case .Clear:
                clear()
                
                
                
            }
        }
        
    }
    
    func executeOp(){
       if pending != nil{
            
            accumulator=pending!.binaryFunc(pending!.firstOperand,accumulator)
            
            valueOperand=pending!.stringFunc(pending!.stringOperand,valueOperand)
            
            pending=nil
            
        }
        
    }
    
    
    
    var result: Double {
        get{
            return accumulator
        }
    }
    
    
    private func clear(){
        
        accumulator=0
        
        pending=nil
        
     
        }
    
    
    var sData:String{
        
        get {
            
            
            
            return valueOperand
            
        }
        
        
        
    }
    
    
    
}
