//
//  FriendPhotoCollectionViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 19.05.2021.
//

import UIKit

class FriendPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    
    func setup() {
        
    }
    
    
    func clearCell() {
        myImageView.image = nil
    }
    
    
    override func prepareForReuse() {
        clearCell()
    }
    
    
    func configure() {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
}
