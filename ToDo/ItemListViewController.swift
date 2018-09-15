//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Michael Pujol on 9/14/18.
//  Copyright © 2018 Michael Pujol. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: UITableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataProvider
    }
}
