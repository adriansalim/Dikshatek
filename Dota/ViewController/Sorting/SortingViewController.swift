//
//  SortingViewController.swift
//  Dota
//
//  Created by adriansalim on 25/08/21.
//

import UIKit

protocol sortDelegate: AnyObject {
    func sortData(sortName: Int, completion: @escaping (() -> Void))
}

class SortingViewController: UIViewController {

    @IBOutlet weak var tableViewSort: UITableView!
    var arraySort = NSMutableArray()
    weak var delegate: sortDelegate?
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arraySort.add("Base Attack (Lower Limit)")
        self.arraySort.add("Base Health")
        self.arraySort.add("Base Mana")
        self.arraySort.add("Base Speed")
        
        self.tableViewSort.delegate = self
        self.tableViewSort.dataSource = self
        self.tableViewSort.showsVerticalScrollIndicator  = false
        self.tableViewSort.showsHorizontalScrollIndicator = false
        self.tableViewSort.backgroundColor = UIColor.clear
        self.tableViewSort.register(SortTableViewCell.self, forCellReuseIdentifier: "sortCell")
        self.tableViewSort.register(UINib(nibName: "SortTableViewCell", bundle: nil), forCellReuseIdentifier: "sortCell")
        self.tableViewSort.tableFooterView = UIView(frame: CGRect.zero)
        self.tableViewSort.reloadData()
    }

    @IBAction func btnApply(_ sender: Any) {
        self.delegate?.sortData(sortName: self.selectedIndex, completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}

extension SortingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arraySort.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath as IndexPath) as! SortTableViewCell
        cell.lblSort.text = self.arraySort[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
    }
}
