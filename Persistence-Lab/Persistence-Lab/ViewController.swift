//
//  ViewController.swift
//  Persistence-Lab
//
//  Created by Chelsi Christmas on 1/21/20.
//  Copyright © 2020 Chelsi Christmas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var searchQuery = "pizza"
    var photos = [PhotoInfo](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        searchPhotos(searchQuery: searchQuery)
        
    }
    
    func searchPhotos(searchQuery: String){
        PhotosAPIClient.fetchPhoto(for: searchQuery, completion: {[weak self] (result) in
            switch result {
            case .failure(let appError):
                print("Error: \(appError)")
            case .success(let photos):
                self?.photos = photos
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = collectionView.indexPathsForSelectedItems else {
            fatalError("Unable to segue to detail view controller")
        }
        
        let photo = photos[indexPath.first!.row]
        detailVC.photo = photo
        detailVC.searchQuery = searchQuery
        
        
    }



}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("Unable to downcast PhotoCell")
        }
        
        let photo = photos[indexPath.row]
        cell.configureCell(photo: photo)
        
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailVC = storyboard?.instantiateInitialViewController() as? DetailViewController
//        let aPhoto = photos[indexPath.row]
//        detailVC?.photo = aPhoto
//        navigationController?.pushViewController(detailVC!, animated: true)
//    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxWidth: CGFloat = UIScreen.main.bounds.size.width
        let itemWidth: CGFloat = maxWidth * 0.80
//        let interItemSpacing: CGFloat = 10 // space between items
//        let maxWidth = UIScreen.main.bounds.size.width // device's width
//        let numberOfItems: CGFloat = 3 // items
//        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
//        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        
//        
//        return 3
//    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else {
            print("Please type in ma valid entry")
            return
        }
        searchQuery = searchText
        searchPhotos(searchQuery: searchText)
    }
    
}
