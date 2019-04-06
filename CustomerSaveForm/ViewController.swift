//
//  ViewController.swift
//  CustomerSaveForm
//
//  Created by Sravan on 04/04/19.
//  Copyright © 2019 Sravan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var segmentedControl = UISegmentedControl()
    let someView = UIView()
    let tableView = UITableView()
    
    let tblItems = ["First Name", "Last Name", "Nick Name", "Address"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.designUI()
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 5000000000)) { //5 seconds
//            self.segmentedControl.center = self.someView.center
//        }
//        
//    }
    
    private func designUI() {
        self.view.backgroundColor = UIColor.lightGray
        
        self.addSomeView()
        self.addSegmentControl()
        self.addTableView()
        self.addFooterView()
    }
    
    private func addSomeView() {
        self.someView.backgroundColor = UIColor.green
        self.someView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.someView)
        
        let viewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-50-[view]-50-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": self.someView])
        let viewConstraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-50-[view]-50-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["view": self.someView])
        
        self.view.addConstraints(viewConstraintH)
        self.view.addConstraints(viewConstraintV)
    }

    private func addSegmentControl() {
        let items = ["Customer 1" , "Customer 2"]
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControl = UISegmentedControl(items : items)
        self.segmentedControl.selectedSegmentIndex = 0
//        self.segmentedControl.center = self.someView.center
//        self.segmentedControl.addTarget(self, action: #selector(ViewController.indexChanged(_:)), for: .valueChanged)
        
        self.segmentedControl.layer.cornerRadius = 5.0
        self.segmentedControl.backgroundColor = .red
        self.segmentedControl.tintColor = .yellow
        
//        self.view.addSubview(self.segmentedControl)
//        self.segmentedControl.setTitle("Customer 1", forSegmentAt: 0)
//        self.segmentedControl.setTitle("Customer 2", forSegmentAt: 1)

        self.segmentedControl.addTarget(self, action: #selector(self.segmentChanged(_:)), for: .valueChanged)

        self.someView.addSubview(self.segmentedControl)
        
        /*
        let leading = NSLayoutConstraint.init(
            item: self.segmentedControl,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.someView,
            attribute: .leading,
            multiplier: 1, constant: 50)
        
        let top = NSLayoutConstraint.init(
            item: self.segmentedControl,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.someView,
            attribute: .top,
            multiplier: 1, constant: 50)
        
        let width = NSLayoutConstraint.init(
            item: self.segmentedControl,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1, constant: 50)
        
        let height = NSLayoutConstraint.init(
            item: self.segmentedControl,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1, constant: 50)
        
        let centerHorizontally = NSLayoutConstraint(item: self.segmentedControl,
                                                    attribute: .centerX,
                                                    relatedBy: .equal,
                                                    toItem: self.someView,
                                                    attribute: .centerX,
                                                    multiplier: 1.0,
                                                    constant: 0.0).isActive = true
        
//        self.view.addConstraints([leading, top, width, height])
        
        NSLayoutConstraint.activate([leading, top, width, height])
        */
        
        let segmentConstraintH = NSLayoutConstraint.constraints(
//            withVisualFormat: "H:[superview]-(<=1)-[segmentedControl]",
            withVisualFormat: "H:[segmentedControl]",
            options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
            metrics: nil,
            views: ["segmentedControl":self.segmentedControl
//                ,
//                    "superview": self.someView
            ])

        let segmentConstraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[segmentedControl]|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["segmentedControl":self.segmentedControl])

        self.view.addConstraints(segmentConstraintH)
        self.view.addConstraints(segmentConstraintV)
        
        
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
//            withVisualFormat: "H:|-100-[view]-10-|",
//            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
//            metrics: nil,
//            views: ["view": self.segmentedControl]))
        
//        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-padding-[top]-100-[view(30)]-|",
//            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
//            metrics: ["padding": 20],
//            views: ["view": self.segmentedControl, "top": self.view.safeAreaLayoutGuide.topAnchor]))
        
    }
    
    private func addTableView() {
//        self.tableView.backgroundColor = UIColor.blue
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(CustomerFormCell.self, forCellReuseIdentifier: String.init(describing: CustomerFormCell.self))
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        
        let tableConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[tableView]-10-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["tableView" : self.tableView])
        
        let tableConstraintV = NSLayoutConstraint.constraints(
//            withVisualFormat: "V:|-10-[segmentView]-10-[tableView]-50-|",
            withVisualFormat: "V:|-100-[tableView]-100-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["tableView" : self.tableView,
//                    "segmentView" : self.segmentedControl
            ])
        
        self.view.addConstraints(tableConstraintH)
        self.view.addConstraints(tableConstraintV)
    }
    
    private func addFooterView() {
        let btnCompare : UIButton = {
            let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitle(Constants.btnTitleCompare, for: .normal)
            btn.backgroundColor = UIColor.lightGray
            btn.addTarget(self, action: #selector(btnCompareTapped), for: .touchUpInside)
            return btn
        }()
        
        let txtView : UITextView = {
            let txtView = UITextView()
            txtView.translatesAutoresizingMaskIntoConstraints = false
            txtView.text = Constants.txtViewResultText
            return txtView
        }()
        
        self.view.addSubview(btnCompare)
        self.view.addSubview(txtView)
        
        let viewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[btn]|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["btn" : btnCompare
            ])
        let txtViewConstraintH = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[txtView]|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: [ "txtView" : txtView
            ])
        
        let viewConstraintV = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[tblView]-5-[btn]-5-[txtView]-5-|",
            options: NSLayoutConstraint.FormatOptions.init(rawValue: 0),
            metrics: nil,
            views: ["btn" : btnCompare
                , "txtView" : txtView
                , "tblView" : self.tableView
            ])
        
        self.view.addConstraints(viewConstraintH)
        self.view.addConstraints(viewConstraintV)
        self.view.addConstraints(txtViewConstraintH)
    }
    
//    @objc func indexChanged(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex{
//        case 0:
//            print("iOS");
//        case 1:
//            print("Android")
//        default:
//            break
//        }
//    }
    
    
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
