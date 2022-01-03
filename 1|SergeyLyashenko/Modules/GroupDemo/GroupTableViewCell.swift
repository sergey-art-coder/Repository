//
//  GroupTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.04.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameGroupLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    func setup() {
        
    }
    
    
    func clearCell() {
        nameGroupLabel.text = nil
        photoImageView.image = nil
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
