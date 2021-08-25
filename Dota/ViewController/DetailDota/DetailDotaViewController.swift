//
//  DetailDotaViewController.swift
//  Dota
//
//  Created by adriansalim on 25/08/21.
//

import UIKit
import SDWebImage

class DetailDotaViewController: UIViewController {
    
    @IBOutlet weak var tableViewDetail: UITableView!
    
    var dataDetail: DotaElement?
    
    var baseSection = NSMutableArray()
    var moveSection = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = self.dataDetail?.localizedName ?? ""
        self.baseSection.add("Base Health")
        self.baseSection.add("Base Mana")
        self.baseSection.add("Base Armor")
        self.baseSection.add("Base Attack")
        self.moveSection.add("Move Speed")
        self.showTableViewData()
    }
    
    func showTableViewData() {
        self.tableViewDetail.delegate = self
        self.tableViewDetail.dataSource = self
        self.tableViewDetail.separatorColor = .clear
        self.tableViewDetail.showsVerticalScrollIndicator  = false
        self.tableViewDetail.showsHorizontalScrollIndicator = false
        self.tableViewDetail.backgroundColor = UIColor.clear
        self.tableViewDetail.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        self.tableViewDetail.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        self.tableViewDetail.register(NameTypeTableViewCell.self, forCellReuseIdentifier: "nameTypeCell")
        self.tableViewDetail.register(UINib(nibName: "NameTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "nameTypeCell")
        self.tableViewDetail.register(AttTypeTableViewCell.self, forCellReuseIdentifier: "attCell")
        self.tableViewDetail.register(UINib(nibName: "AttTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "attCell")
        self.tableViewDetail.register(EtcTypeTableViewCell.self, forCellReuseIdentifier: "etcCell")
        self.tableViewDetail.register(UINib(nibName: "EtcTypeTableViewCell", bundle: nil), forCellReuseIdentifier: "etcCell")
        self.tableViewDetail.reloadData()
    }


}

extension DetailDotaViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
            case 0:
               return 1
            case 1:
               return 1
            case 2:
               return 1
            case 3:
               return 4
            case 4:
               return 1
            case 5:
                return self.dataDetail?.roles?.count ?? 0
            default:
               return 0
         }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath as IndexPath) as! ImageTableViewCell
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor.clear
                cell.imgCell.sd_setImage(with: URL(string: "http://cdn.dota2.com" + (self.dataDetail?.img ?? ""), relativeTo: nil))
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "nameTypeCell", for: indexPath as IndexPath) as! NameTypeTableViewCell
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor.clear
                cell.imgCell.sd_setImage(with: URL(string: "http://cdn.dota2.com" + (self.dataDetail?.img ?? ""), relativeTo: nil))
                cell.titleLabel.text = self.dataDetail?.localizedName ?? ""
                cell.typeLabel.text = self.dataDetail?.primaryAttr?.rawValue.uppercased() ?? ""
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "attCell", for: indexPath as IndexPath) as! AttTypeTableViewCell
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor.clear
                cell.staticLabel.text = "Attack Type"
                cell.valueLabel.text = self.dataDetail?.attackType?.rawValue ?? ""
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "etcCell", for: indexPath as IndexPath) as! EtcTypeTableViewCell
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor.clear
                cell.staticCell.text = self.baseSection[indexPath.row] as? String
                if(indexPath.row == 0) {
                    cell.valueCell.text = self.dataDetail?.baseHealth?.description
                } else if(indexPath.row == 1) {
                    cell.valueCell.text = self.dataDetail?.baseMana?.description
                } else if(indexPath.row == 2) {
                    cell.valueCell.text = self.dataDetail?.baseArmor?.description
                } else if(indexPath.row == 3) {
                    cell.valueCell.text = self.dataDetail?.baseAttackMin?.description
                }
                
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "etcCell", for: indexPath as IndexPath) as! EtcTypeTableViewCell
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor.clear
                cell.staticCell.text = self.moveSection[indexPath.row] as? String
                cell.valueCell.text = self.dataDetail?.moveSpeed?.description
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "attCell", for: indexPath as IndexPath) as! AttTypeTableViewCell
                cell.selectionStyle = .none
                cell.contentView.backgroundColor = UIColor.clear
                cell.staticLabel.text = (self.dataDetail?.roles?[indexPath.row].rawValue) ?? ""
                cell.valueLabel.text = ""
                return cell
            default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section) {
            case 0:
               return 200
            case 1:
               return 50
            case 2:
               return 50
            case 3:
               return 50
            case 4:
               return 50
            case 5:
               return 50
            default:
               return 0
         }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        footerView.backgroundColor = UIColor(red: 211/255.0, green: 211/255.0, blue: 211/255.0, alpha: 0.5)
        if(section == 5){
            return UIView()
        }
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
