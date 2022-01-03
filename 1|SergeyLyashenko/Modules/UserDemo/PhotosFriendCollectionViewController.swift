//
//  PhotosFriendCollectionViewController.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 14.05.2021.
//

import UIKit

class PhotosFriendCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let reuseIdentifier = "PhotosFriendsCell"
    let photosFriendsCell = "PhotosFriendsCell"
    let toFriendPhoto = "toFriendPhoto"
    
    var photos: Friend?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*  зададим отступы
         collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
         
         заголовок для Navigation Bar
         title = photos.userName */
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.userPhotos.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosFriendsCell, for: indexPath) as? PhotosFriendCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = photos?.userPhotos[indexPath.item]
        
        cell.photosFriendImage.layer.borderWidth = 3
        cell.photosFriendImage.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.photosFriendImage.image = photo
        
        return cell
    }
    
    // MARK: - прописывам нужный размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width
        let insets = collectionView.contentInset.left + collectionView.contentInset.right
        width -= insets
        width -= 40
        width /= 3
        return CGSize(width: width, height: width)
    }
    
    // сохраняем выбранный индекс в переменной selectedIndex и убираем выделения
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: toFriendPhoto, sender: selectedIndex)
    }
    
    // метод через который мы переходим на FriendsPhotosViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //вызываем подготовку к переходу
        super.prepare(for: segue, sender: sender)
        
        // проверяем что индитификатор называется "toFriendPhoto"
        if segue.identifier == toFriendPhoto {
            
            guard let detailVC = segue.destination as? FriendPhotoViewController,
                  let indexPath = self.collectionView.indexPathsForSelectedItems?.first else { return }

            detailVC.selectedIndex = indexPath.item
            detailVC.photos = photos
        }
    }
}
