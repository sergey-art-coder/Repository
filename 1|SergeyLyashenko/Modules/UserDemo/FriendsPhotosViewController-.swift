//
//  FriendsPhotosViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 17.05.2021.
//

import UIKit

class FriendsPhotosViewController: UIViewController {
  
    private let reuseIdentifier = "FriendsPhotosCell"
    var photos: Friend!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension FriendsPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.userPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotosCell", for: indexPath) as! FriendsPhotosCollectionViewCell
        
        let photo = photos.userPhotos[indexPath.item]
        cell.frienndPhotosImage.image = photo
        
        return cell
    }
}
