//
//  PhotosFriendCollectionViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 19.04.2021.
//

import UIKit

class PhotosFriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photosFriendImage: UIImageView!
    
    
    func setup() {
        
    }
    
    
    func clearCell() {
        photosFriendImage.image = nil
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
