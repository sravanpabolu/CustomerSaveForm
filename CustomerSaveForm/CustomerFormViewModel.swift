//
//  CustomerFormViewModel.swift
//  CustomerSaveForm
//
//  Created by Sravan on 08/04/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import Foundation
import UIKit

class CustomerFormViewModel {
    let tblItems = [Constants.tblItemFirstName, Constants.tblItemLastName, Constants.tblItemNickName, Constants.tblItemAddress]
    var customer1Data = Dictionary<String, Any>()
    var customer2Data = Dictionary<String, Any>()
    
    internal func constructCell(_ indexPath: IndexPath, _ cell: CustomerFormCell) {
        if indexPath.row < self.tblItems.count {
            cell.lblTitle.isHidden = false
            cell.txtField.isHidden = false
            cell.signUpBtn.isHidden = true
            cell.txtField.text = ""
            cell.lblTitle.text = self.tblItems[indexPath.row]
        } else if indexPath.row == self.tblItems.count {
            cell.lblTitle.isHidden = true
            cell.txtField.isHidden = true
            cell.signUpBtn.isHidden = false
        }
    }
    
    internal func getTableHeader() -> String? {
        return Constants.tblHeader
    }
    
    internal func getTableFooter() -> String? {
        return Constants.tblFooter
    }
    
    internal func processAndSaveCustomerData(for customerTag: Int, customerData: [String]) {
        if customerTag == 0 {
            customer1Data[Constants.tblItemFirstName] = customerData[0]
            customer1Data[Constants.tblItemLastName] = customerData[1]
            customer1Data[Constants.tblItemNickName] = customerData[2]
            customer1Data[Constants.tblItemAddress] = customerData[3]
            
            UserDefaults.standard.setValue(customer1Data, forKey: Constants.keyCustomerOne)
        } else {
            customer2Data[Constants.tblItemFirstName] = customerData[0]
            customer2Data[Constants.tblItemLastName] = customerData[1]
            customer2Data[Constants.tblItemNickName] = customerData[2]
            customer2Data[Constants.tblItemAddress] = customerData[3]
            
            UserDefaults.standard.setValue(customer2Data, forKey: Constants.keyCustomerTwo)
        }
        UserDefaults.standard.synchronize()
    }
    
    internal func retrieveCustomerData(completionHandler: ([String: Any], [String: Any]) -> Void) {
        guard let customerOne : [String: Any] = UserDefaults.standard.value(forKey: Constants.keyCustomerOne) as? [String : Any] else { return }
        guard let customerTwo : [String: Any] = UserDefaults.standard.value(forKey: Constants.keyCustomerTwo) as? [String : Any] else { return }
        
        completionHandler(customerOne, customerTwo)
    }
    
    internal func compareCustomerData() -> Bool {
        guard let customerOne : [String: Any] = UserDefaults.standard.value(forKey: Constants.keyCustomerOne) as? [String : Any] else { return false }
        guard let customerTwo : [String: Any] = UserDefaults.standard.value(forKey: Constants.keyCustomerTwo) as? [String : Any] else { return false }
        
        var status = false

        if let custOneName: String = customerOne[Constants.tblItemFirstName] as? String,
            let custTwoName: String = customerTwo[Constants.tblItemFirstName] as? String,
            let custOneAddr: String = customerOne[Constants.tblItemAddress] as? String,
            let custTwoAddr: String = customerTwo[Constants.tblItemAddress] as? String
        {
            if custOneName == custTwoName, custOneAddr == custTwoAddr {
                status = true
            }
        }
        
        return status
    }
    
    internal func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: Constants.keyCustomerOne)
        UserDefaults.standard.removeObject(forKey: Constants.keyCustomerTwo)
        UserDefaults.standard.synchronize()
    }
}
