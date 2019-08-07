//
//  ListViewController.swift
//  ProgrammaticApp-2
//
//  Created by Arun Patwardhan on 29/07/19.
//  Copyright © 2019 Amaranthine. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.createTable()
        self.apply_constraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#line, "Reloading")
        self.list.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //UI Elements   --------------------------------------------------
    var list : UITableView                      =   UITableView()
    
    //Model
    var data            : [FeedbackResponse]?
    lazy var viewMap    : [String : UIView]     = ["list": self.list]
    var allConstraints  : [NSLayoutConstraint]  = [NSLayoutConstraint]()
    
    //Functions     --------------------------------------------------
    func createTable()
    {
        list.delegate                           = self
        list.dataSource                         = self
        self.view.addSubview(list)
    }
    
    //Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard data != nil
        else
        {
            return 0
        }
        print(#line, data!.count)
        return data!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?         = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if nil == cell
        {
            cell                            = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "CELL")
        }
        
        let rowData : FeedbackResponse = data![indexPath.row]
        print(#line, rowData.dateOfSurvey.description)
        let dateFormatter : DateFormatter   = DateFormatter()
        dateFormatter.dateStyle             = DateFormatter.Style.medium
        
        cell?.textLabel?.text               = rowData.name
        cell?.detailTextLabel?.text         = "EMAIL\t: \(rowData.email)\nDOB\t: \(dateFormatter.string(from: rowData.age))\nSERVICE\t: \(rowData.serviceRating.toString())\nSATISFACTION\t: \(rowData.satisfactionRating.toString())\nSURVEY DATE:\t \(dateFormatter.string(from: rowData.dateOfSurvey))"
        
        return cell!
    }
}

/**
 This extension contains the code that creates the constraints
 
 - Author: Arun Patwardhan
 - Version: 1.1
 - Date: 1st August 2019
 
 **Contact Details**
 
 [arun@amaranthine.co.in](mailto:arun@amaranthine.co.in)
 
 [www.amaranthine.in](https://www.amaranthine.in)
 */
extension ListViewController
{
    /**
     Unified Constraint Configuration for `UITableView`
     - important: This function does not perform data validation
     - returns: Void.
     - requires: iOS 12 or later
     - Since: iOS 12
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     - Date: 1st August 2019
     
     **Contact Details**
     
     [arun@amaranthine.co.in](mailto:arun@amaranthine.co.in)
     
     [www.amaranthine.in](https://www.amaranthine.in)
     */
    @available(iOS, introduced: 12.0, message: "Unified Constraint Configuration for `UITableView`")
    func apply_constraints()
    {
        list.translatesAutoresizingMaskIntoConstraints          = false
        let row1horizontalConstraints   : [NSLayoutConstraint]  = NSLayoutConstraint.constraints(withVisualFormat: "H:|-1.0-[list]-1.0-|", options: NSLayoutConstraint.FormatOptions.alignAllLeft, metrics: nil, views: viewMap)
        allConstraints.append(contentsOf: row1horizontalConstraints)
        
        let row1VerticalConstraints     : [NSLayoutConstraint]  = NSLayoutConstraint.constraints(withVisualFormat: "V:|-170.0-[list]-1.0-|", options: NSLayoutConstraint.FormatOptions.alignAllTop, metrics: nil, views: viewMap)
        allConstraints.append(contentsOf: row1VerticalConstraints)
        
        NSLayoutConstraint.activate(allConstraints)
    }
}
