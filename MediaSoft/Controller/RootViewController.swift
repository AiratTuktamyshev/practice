//
//  ViewController.swift
//  MediaSoft
//
//  Created by Айрат Туктамышев on 30/06/2019.
//  Copyright © 2019 Айрат Туктамышев. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var imageDownload:[Hits]=[]//структура для сохранения ответа
    var jsonReq:JsonReqStr=JsonReqStr()//структура для модификации запроса
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func LoadJson(){
        
        var request = self.jsonReq.Result()
        print(jsonReq)
        request.httpMethod="GET"
        request.httpBody=Data()
        request.addValue("contentType", forHTTPHeaderField: "Application/JSON")
        
        let image = URLSession.shared.dataTask(with: request) { [weak self] (data,response, error) in
            guard self != nil else {return}
            
            if error == nil{
                do {
                    let json = try JSONDecoder().decode(ImageJSON.self, from: data!)
                    self!.imageDownload=json.hits
                    
                    print("Количество ")
                    print (self!.imageDownload.count)
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                }
                catch let error {print(error)}
            }
            
            
            
        }
        image.resume()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="showDetail" {
            if let ds = segue.destination as? ImageDetailViewController{
               let imagelarge = sender as? String
                ds.imageinfo = imagelarge
            }
        }
        
        if segue.identifier=="showFilter"{
            let FilterVC = segue.destination as! ModalViewController
            FilterVC.req=jsonReq
            FilterVC.delegate=self//прослушиваем делегат
        }

    }
    
    
    
}






extension RootViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    
    // работа сollection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDownload.count
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RootCell", for: indexPath)  as? RootCollectionViewCell  {
            
            
            let url = URL( string: imageDownload[indexPath.row].previewURL! )
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
            
                DispatchQueue.main.async {
                itemCell.imageCell.image = UIImage(data: data!)
                }
            }
            
            return itemCell
        
         }
        return UICollectionViewCell()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let largeUrl = imageDownload[indexPath.row].largeImageURL
        
        self.performSegue(withIdentifier: "showDetail", sender: largeUrl)
        
    }
    
}




extension RootViewController: UISearchBarDelegate{

    //работа с search bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            return headerView
        }
 
        return UICollectionReusableView()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !((searchBar.text?.isEmpty)!){
            var str=searchBar.text!
            
            while(str.contains("  ")){
                str=str.replacingOccurrences(of: "  ", with: " ")
            }
            
            str=str.replacingOccurrences(of: " ", with: "+")
            
            jsonReq.q=str
            LoadJson()
        }
        if (searchBar.text?.isEmpty)!{
            imageDownload.removeAll()
            collectionView.reloadData()
        }
        
     }
 
}
    



//Mark: protocol

extension RootViewController: FilterProtocol{
    func SendInfo(category: String, imageType: String, orient:String) {
        self.jsonReq.category=category
        self.jsonReq.image_type=imageType
        self.jsonReq.orientation=orient
        
        let b=self.jsonReq.isEmpty()
        if b == true{
            LoadJson()
        }
    }
    
    
}
