//
//  ViewController.swift
//  CustomerSaveForm
//
//  Created by Sravan on 04/04/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    
    let viewModel = CustomerFormViewModel()
    
    var segmentedControl : UISegmentedControl = {
        let segCtrl = UISegmentedControl(items : [Constants.segmentItem1, Constants.segmentItem2])
       
    UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)

        segCtrl.translatesAutoresizingMaskIntoConstraints = false
        segCtrl.selectedSegmentIndex = 0
        segCtrl.layer.cornerRadius = 5.0
        segCtrl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        return segCtrl
    }()
    
    let btnCompare : UIButton = {
        let btn = UIButton()
        btn.isEnabled = false
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 5 
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.gray, for: .disabled)
        btn.setTitle(Constants.btnTitleCompare, for: .normal)
        btn.backgroundColor = UIColor.lightGray
        btn.addTarget(self, action: #selector(btnCompareTapped), for: .touchUpInside)
        return btn
    }()
    
    let resultTxtView : UITextView = {
        let txtView = UITextView()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.text = Constants.txtViewResultText
        return txtView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.designUI()
        self.addConstraintsToView()
        self.viewModel.clearUserDefaults()
    }
    
    private func designUI() {
        self.view.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(self.segmentedControl)
        
        self.addTableView()
        
        self.view.addSubview(btnCompare)
        self.view.addSubview(resultTxtView)
    }
    
    private func addTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isScrollEnabled = false
        self.tableView.register(CustomerFormCell.self, forCellReuseIdentifier: String.init(describing: CustomerFormCell.self))
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView)
    }
    
    private func addConstraintsToView() {
        let someViewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[view]-10-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": self.segmentedControl])
        
        let tblViewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[view]-10-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": self.tableView])
        
        let btnCompareViewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[view]-10-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": self.btnCompare])
        
        let txtViewResultConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[view]-10-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": self.resultTxtView])

        let viewConstraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-50-[view]-10-[tblView(350)]-10-[btnCompare(30)]-10-[txtViewResult]-50-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: [
                "view": self.segmentedControl,
                "tblView" : self.tableView,
                "btnCompare" : self.btnCompare,
                "txtViewResult" : self.resultTxtView
            ])
        
        self.view.addConstraints(someViewConstraintH)
        self.view.addConstraints(tblViewConstraintH)
        self.view.addConstraints(btnCompareViewConstraintH)
        self.view.addConstraints(txtViewResultConstraintH)
        self.view.addConstraints(viewConstraintV)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    @objc private func btnCompareTapped() {
        let status = self.viewModel.compareCustomerData()
        
        if status == true {
            self.resultTxtView.text = Constants.txtEqual
        } else {
            self.resultTxtView.text = Constants.txtNotEqual
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getTableHeader()
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.viewModel.getTableFooter()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.tblItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: CustomerFormCell.self), for: indexPath) as! CustomerFormCell
        cell.delegate = self
        self.viewModel.constructCell(indexPath, cell)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: CustomerFormCellDelegate {
    func signUPBtnTapped() {
        var custData = [String]()
        
        //get values from text fields
        for index in 0..<self.viewModel.tblItems.count {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell:CustomerFormCell = self.tableView.cellForRow(at: indexPath) as? CustomerFormCell,
                let cellText: String = cell.txtField.text {
                custData.append(cellText)
            }
        }
        
        self.viewModel.processAndSaveCustomerData(for: self.segmentedControl.selectedSegmentIndex, customerData: custData)
        
        self.viewModel.retrieveCustomerData { (customerOne, customerTwo) in
            DLog(object: customerOne as Any)
            DLog(object: customerTwo as Any)
            
            guard !customerOne.isEmpty else { return }
            guard !customerTwo.isEmpty else { return }
            
            self.btnCompare.isEnabled = true
        }
    }
}
