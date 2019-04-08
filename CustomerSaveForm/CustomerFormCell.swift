//
//  CustomerFormCell.swift
//  CustomerSaveForm
//
//  Created by Sravan on 06/04/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import UIKit

protocol CustomerFormCellDelegate {
    func signUPBtnTapped()
}

class CustomerFormCell: UITableViewCell {
    var delegate: CustomerFormCellDelegate?
    
    lazy var lblTitle : UILabel  = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Custom Label"
        return lbl
    }()
    
    lazy var txtField : UITextField = {
        let txtFld = UITextField()
        txtFld.translatesAutoresizingMaskIntoConstraints = false
        txtFld.placeholder = "Enter some value"
        return txtFld
    }()
    
    lazy var signUpBtn : UIButton = {
        let btn = UIButton()
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Constants.btnTitleSignUP, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        btn.addTarget(self, action: #selector(btnSignupTapped), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String.init(describing: CustomerFormCell.self))
        
        let stackView = UIStackView(arrangedSubviews: [lblTitle, txtField])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let btnPlusFieldsStackView = UIStackView(arrangedSubviews: [stackView, signUpBtn])
        btnPlusFieldsStackView.axis = .vertical
        btnPlusFieldsStackView.spacing = 5
        btnPlusFieldsStackView.distribution = .equalSpacing
        btnPlusFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(btnPlusFieldsStackView)

        let lblH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-5-[view]-5-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": btnPlusFieldsStackView])
        let lblV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[view]-5-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": btnPlusFieldsStackView])
        
        addConstraints(lblH)
        addConstraints(lblV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func btnSignupTapped() {
        self.delegate?.signUPBtnTapped()
    }
}
