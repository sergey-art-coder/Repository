//
//  AllGroupTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 18.04.2021.
//

import UIKit

class AllGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var allGroupLabel: UILabel!
    
    // этот метод вызывается каждый раз когда подготавливаем ячейку к переиспользованию (чистим)
    override func prepareForReuse() {
        super.prepareForReuse()
        allGroupLabel.text = ""
    }

}
