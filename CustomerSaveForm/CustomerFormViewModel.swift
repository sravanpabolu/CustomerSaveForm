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
    
    internal func constructCell(_ indexPath: IndexPath, _ cell: CustomerFormCell) {
        if indexPath.row < self.tblItems.count {
            cell.lblTitle.isHidden = false
            cell.txtField.isHidden = false
            cell.signUpBtn.isHidden = true
            cell.lblTitle.text = self.tblItems[indexPath.row]
            cell.txtField.tag = indexPath.row
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
}
