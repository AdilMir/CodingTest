//
//  ViewController.swift
//  AppScripsTest
//
//  Created by Rajeev Vekta on 10/3/20.
//  Copyright © 2020 Adil Mir. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    //MARK:-----Outlets---------
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var bannerCollectionView:UICollectionView!
    @IBOutlet weak var pageControl:UIPageControl!
    
     //MARK:-----Global Variables---------
    var previousIndexPath:IndexPath?
    var currentIndexPath:IndexPath!
    var menuData = [Category]()
    var bannerImages:[UIImage] = [#imageLiteral(resourceName: "Mozzarella Cheese Pizza"),#imageLiteral(resourceName: "Spicy Chicken Pizza"),#imageLiteral(resourceName: "Special Thali")]
    
    
    //MARK:---------View Methods----------
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.tableFooterView = UIView()
    }
    
    //MARK:---------Functions-------------
    
    func setUpView() {
        pageControl.currentPage = 0
        tableView.tableFooterView = UIView()
    }
    
    func loadData() {
        do{
            if let path = Bundle.main.url(forResource: "MenuData", withExtension: "json")
            {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let menuData = try JSONDecoder().decode([Category].self, from: data)
                self.menuData = menuData
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func moveToDetailPage(item:Items) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        controller.item = item
        controller.updateTableView = {
            self.reloadTableCells()
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //Reload Previous and current Selected row
    func reloadTableCells(){
        
        tableView.reloadRows(at: [currentIndexPath], with: .automatic)
        if let previousSelectedIndexPath = previousIndexPath{
            if previousSelectedIndexPath == currentIndexPath{
                return
            }
            menuData[previousSelectedIndexPath.section].items?[previousSelectedIndexPath.row].isSelected = false
            if menuData[previousSelectedIndexPath.section].isListExpanded{
            tableView.reloadRows(at: [previousSelectedIndexPath], with: .automatic)
            }
        }
        previousIndexPath = currentIndexPath
        
    }
    
}
 //MARK:---------Table Delegate and Data Source Methods-------------
extension MenuViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData[section].isListExpanded ? (menuData[section].items?.count ?? 0) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell") as? ItemTableViewCell{
            if let item = menuData[indexPath.section].items?[indexPath.row]{
                cell.setUpCell(item: item)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        viewHeader.backgroundColor = UIColor.gray
        let button = UIButton(type: .custom)
        button.frame = viewHeader.bounds
        button.tag = section // Assign section tag to this button
        button.addTarget(self, action: #selector(tapSection(sender:)), for: .touchUpInside)
        button.setTitle(menuData[section].name ?? "NA", for: .normal)
        viewHeader.addSubview(button)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    @objc func tapSection(sender: UIButton) {
        if menuData[sender.tag].isListExpanded{
            menuData[sender.tag].isListExpanded = false
        }else {
            menuData[sender.tag].isListExpanded = true
        }
        self.tableView.reloadSections([sender.tag], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        if var item = menuData[indexPath.section].items?[indexPath.row]{
            item.isSelected = item.isSelected ? false : true
            menuData[indexPath.section].items?[indexPath.row] = item
            
            moveToDetailPage(item: item)
        }
    }
    
}
//MARK:---------CollectionView Delegate and Data Source Methods-------------
extension MenuViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell{
            let image = bannerImages[indexPath.row]
            cell.setUpCell(image: image)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

//MARK:---------Scrool view delegate Methods--------

extension MenuViewController:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        }
    }
}
