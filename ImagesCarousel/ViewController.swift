//
//  ViewController.swift
//  ImagesCarousel
//
//  Created by YeshwantSatya on 11/08/21.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableVw: UITableView!
    @IBOutlet weak var scrollVwRef: UIScrollView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionVw: UICollectionView!
    
    @IBOutlet weak var viewHt: NSLayoutConstraint!
    @IBOutlet weak var viewRef: UIView!
    
    
    var imageArr = [UIImage (named: "image1"),
                    UIImage (named: "image2"),UIImage (named: "image3"),
                    UIImage (named: "image4"),UIImage (named: "image5"),
                    UIImage (named: "image6"),UIImage (named: "image7"),
                    UIImage (named: "image8")]
    
    var isSearch : Bool = false
    var tableData = ["Afghanistan", "Algeria", "Bahrain","Brazil", "Cuba", "Denmark","Denmark", "Georgia", "Hong Kong", "Iceland", "India", "Japan", "Kuwait", "Nepal"];
    var filteredTableData:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableVw.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let offsetY = scrollVwRef.contentOffset.y
        
        if (offsetY > 0) {
            UIView.animate(withDuration: 0.2) {[weak self] in
                self?.viewHt.constant = 0
                self?.view.layoutIfNeeded()
            }
            scrollVwRef.isScrollEnabled = false
        }
        else if (offsetY < 0) {
            UIView.animate(withDuration: 0.2) {[weak self] in
                self?.viewHt.constant = 300
                self?.view.layoutIfNeeded()
                
            }
        }
        
        scrollVwRef.isScrollEnabled = true
    }
    
    
    
    
    
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell:CollectionViewCell! = collectionVw
            .dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell
        
        
        cell.imgRef.image = imageArr[indexPath.row]
        
        
        return cell
        
        
    }
}

extension ViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize (width: collectionVw.bounds.size.width, height: collectionVw.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}

extension ViewController: UISearchBarDelegate{
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearch = false
            tableVw.reloadData()
        } else {
            filteredTableData = tableData.filter({ (text) -> Bool in
                let tmp: NSString = text as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if(filteredTableData.count == 0){
                isSearch = false
            } else {
                isSearch = true
            }
            tableVw.reloadData()
        }
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearch) {
            return filteredTableData.count
        }else{
            return tableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TableViewCell! = tableVw.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
        
        if (isSearch) {
            cell.labelRef.text = filteredTableData[indexPath.row]
            
        }
        else {
            cell.labelRef.text = tableData[indexPath.row]
            
        }
        
        return cell
    }
}

