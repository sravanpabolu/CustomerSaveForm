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
    
    var segmentedControl : UISegmentedControl = {
        let segCtrl = UISegmentedControl(items : [Constants.segmentItem1, Constants.segmentItem2])
        segCtrl.translatesAutoresizingMaskIntoConstraints = false
        segCtrl.selectedSegmentIndex = 0
        segCtrl.layer.cornerRadius = 5.0
        return segCtrl
    }()
    
    let someView = UIView()
    
    let btnCompare : UIButton = {
        let btn = UIButton()
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 5 
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(UIColor.black, for: .normal)
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
    
    let tblItems = Constants.tableItems
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.designUI()
        self.addConstraintsToView()
    }
    
    private func designUI() {
        self.view.backgroundColor = UIColor.lightGray
        
//        self.someView.backgroundColor = UIColor.green
        self.someView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.someView)
        
        self.segmentedControl.addTarget(self, action: #selector(self.segmentChanged(_:)), for: .valueChanged)
        self.someView.addSubview(self.segmentedControl)
        
        self.addTableView()
        
        self.view.addSubview(btnCompare)
        self.view.addSubview(resultTxtView)
    }
    
    
    private func addTableView() {
//        self.tableView.backgroundColor = UIColor.blue
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(CustomerFormCell.self, forCellReuseIdentifier: String.init(describing: CustomerFormCell.self))
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView)
    }
    
    private func addConstraintsToView() {
        let someViewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[view]-10-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": self.someView])
        
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
        
        let segmentConstraintH = NSLayoutConstraint.constraints(
//            withVisualFormat: "H:[segmentedControl]",
//            withVisualFormat: "H:[view]-(<=1)-[segmentedControl]",
            withVisualFormat: "H:|-(>=20)-[segmentedControl(==200)]-(>=20)-|",
            options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
            metrics: nil,
            views: ["segmentedControl" : self.segmentedControl,
//                    "view" : self.someView
                    ])
        
        let segmentConstraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[segmentedControl]|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["segmentedControl":self.segmentedControl])

        let viewConstraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-50-[view]-10-[tblView(350)]-10-[btnCompare(30)]-10-[txtViewResult]-50-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: [
                "view": self.someView,
                "tblView" : self.tableView,
                "btnCompare" : self.btnCompare,
                "txtViewResult" : self.resultTxtView
            ])
        
        self.view.addConstraints(segmentConstraintH)
        self.view.addConstraints(segmentConstraintV)
        self.view.addConstraints(someViewConstraintH)
        self.view.addConstraints(tblViewConstraintH)
        self.view.addConstraints(btnCompareViewConstraintH)
        self.view.addConstraints(txtViewResultConstraintH)
        self.view.addConstraints(viewConstraintV)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            DLog(object: "Customer 1")
        default:
            DLog(object: "Customer 2")
        }
    }
    
    @objc private func btnCompareTapped() {
        DLog(object: "Btn Compare tapped")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.tblHeader
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return Constants.tblFooter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: CustomerFormCell.self), for: indexPath) as! CustomerFormCell
        
        if indexPath.row < tblItems.count {
            cell.lblTitle.isHidden = false
            cell.txtField.isHidden = false
            cell.signUpBtn.isHidden = true
            cell.lblTitle.text = tblItems[indexPath.row]
            cell.txtField.tag = indexPath.row
        } else if indexPath.row == tblItems.count {
            cell.lblTitle.isHidden = true
            cell.txtField.isHidden = true
            cell.signUpBtn.isHidden = false
        }
        
        
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
