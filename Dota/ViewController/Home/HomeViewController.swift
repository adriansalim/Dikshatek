//
//  HomeViewController.swift
//  Dota
//
//  Created by adriansalim on 25/08/21.
//

import UIKit
import Alamofire
import SDWebImage



class HomeViewController: UIViewController {

    @IBOutlet weak var collectionViewCategory: UICollectionView!
    @IBOutlet weak var collectionViewList: UICollectionView!
    var dataDota = Dota()
    var dicCategory = NSMutableDictionary()
    var arrCategory = NSMutableArray()
    var arrCategorySort = NSArray()
    var listCategory = Dota()
    var selectedCategory = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrCategory.add("All")
        self.selectedCategory.append(1)
        self.getDataAPI()
    }
    
    func getDataAPI(){
        Alamofire.request(URL(string: "https://api.opendota.com/api/herostats")!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseJSON{ response in
                if(response.response != nil){
                    guard let data = response.data else { return }
                    do{
                        let decodeData = try JSONDecoder().decode(Dota.self, from: data )
                        self.dataDota = decodeData
                        self.getCategoryType()
                    }
                    catch let jsonErr{
                        print(jsonErr)
                    }

                }
                else{
                   print("nil")
                }
        }
        
    }
    
    func getCategoryType() {
        for item in self.dataDota {
            for categoryName in item.roles ?? [] {
                if((self.dicCategory.object(forKey: categoryName.rawValue)) == nil) {
                    self.dicCategory.setValue("", forKey: categoryName.rawValue)
                    self.arrCategory.add(categoryName.rawValue)
                    self.selectedCategory.append(0)
                }
            }
        }
        self.showCategory()
    }

    func showCategory() {
        self.arrCategorySort = self.arrCategory.sorted {($0 as AnyObject).localizedCaseInsensitiveCompare($1 as! String) == ComparisonResult.orderedAscending} as NSArray
        self.getByCategoryName(category: "All")
        self.collectionViewCategory.showsHorizontalScrollIndicator = false
        self.collectionViewCategory.showsVerticalScrollIndicator = false
        self.collectionViewCategory.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        self.collectionViewCategory.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        self.collectionViewCategory.delegate = self
        self.collectionViewCategory.dataSource = self
        self.collectionViewCategory.tag = 0
        if let flowLayout = self.collectionViewCategory?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        self.collectionViewList.showsHorizontalScrollIndicator = false
        self.collectionViewList.showsVerticalScrollIndicator = false
        self.collectionViewList.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
        self.collectionViewList.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listCell")
        self.collectionViewList.delegate = self
        self.collectionViewList.dataSource = self
        self.collectionViewList.tag = 1
        if let flowLayout = self.collectionViewList?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 10, height: 100)
        }
    }
    
    func getByCategoryName(category: String){
        self.listCategory.removeAll()
        if(category == "All"){
            self.listCategory = self.dataDota
            self.collectionViewList.reloadData()
        } else {
            for item in self.dataDota {
                for categoryName in item.roles ?? [] {
                    if(categoryName.rawValue == category) {
                        self.listCategory.append(item)
                    }
                }
            }
            self.collectionViewList.reloadData()
        }
    }

    @IBAction func btnSort(_ sender: Any) {
        let vc = SortingViewController()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if(collectionView.tag == 0) {
            return 20
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 0) {
            return self.arrCategorySort.count + 1
        }
        return self.listCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView.tag == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            if(self.selectedCategory[indexPath.row] == 1) {
                cell.viewLabel.backgroundColor = .white
                cell.labelCell.textColor = .black
            } else {
                if((self.arrCategorySort.count - 1 ) == indexPath.row) {
                    cell.viewLabel.backgroundColor = .white
                    cell.labelCell.textColor = .black
                } else {
                    cell.viewLabel.backgroundColor = .black
                    cell.labelCell.textColor = .white
                    cell.viewLabel.layer.cornerRadius = 10
                }
            }
            
            if(indexPath.row < self.arrCategorySort.count - 1) {
                cell.labelCell.text = (self.arrCategorySort[indexPath.row] as! String)
            } else {
                cell.labelCell.text = "      "
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCollectionViewCell
            cell.imageDota.sd_setImage(with: URL(string: "http://cdn.dota2.com" + (self.listCategory[indexPath.row].img ?? ""), relativeTo: nil))
            cell.labelDota.text = self.listCategory[indexPath.row].localizedName ?? ""
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView.tag == 0) {
            if(indexPath.row < self.arrCategorySort.count - 1) {
                self.getByCategoryName(category: self.arrCategorySort[indexPath.row] as! String)
                self.selectedCategory.removeAll()
                for _ in (0...self.arrCategorySort.count){
                    self.selectedCategory.append(0)
                }
                self.selectedCategory[indexPath.row] = 1
                self.collectionViewCategory.reloadData()
            }
        } else {
            let vc = DetailDotaViewController()
            vc.dataDetail = self.listCategory[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: sortDelegate {
    func sortData(sortName: Int, completion: @escaping (() -> Void)) {
        print(sortName)
        var tmpListCategory = Dota()
        if(sortName == 0) {
            tmpListCategory = self.listCategory.sorted(by: { $0.baseAttackMin! < $1.baseAttackMin!})
        } else if(sortName == 1) {
            tmpListCategory = self.listCategory.sorted(by: { $0.baseHealth! < $1.baseHealth!})
        } else if(sortName == 2) {
            tmpListCategory = self.listCategory.sorted(by: { $0.baseMana! < $1.baseMana!})
        } else if(sortName == 3) {
            tmpListCategory = self.listCategory.sorted(by: { $0.moveSpeed! < $1.moveSpeed!})
        }
        self.listCategory = tmpListCategory
        self.collectionViewList.reloadData()
        completion()
    }
}
