//
//  NewsCustomTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 28.05.2021.
//

import UIKit

class NewsCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var commentButton: LikeButton!
    @IBOutlet weak var repostButton: LikeButton!
    
    // первоначальные настройки ячейки
    func setup() {
        
    }
    
    // очищаем
    func clearCell() {
        avatarImageView.image = nil
        authorLabel.text = nil
        timeLabel.text = nil
        postLabel.text = nil
        postImageView.image = nil
        //        likeButton.likeImage = nil
        //        commentButton.likeImage = nil
        //        repostButton.likeImage = nil
        
        likeButton.isSelected = false
        commentButton.isSelected = false
        repostButton.isSelected = false
        
    }
    
    // функция prepareForReuse вызывается автоматически при переиспользовании ячейки
    override func prepareForReuse() {
        
        super.prepareForReuse()
        clearCell()
        
    }
    
    // передаем параметры для настройки содержимого нашей ячейки  
    func configure(avatar: UIImage?, author: String?, time: String?, post: String?, postPhoto: UIImage?, like: UIImage?, comment: UIImage?, repost: UIImage?) {
        
        if let avatar = avatar {
            avatarImageView.image = avatar
        }
        
        if let author = author {
            authorLabel.text = author
        }
        
        if let time = time {
            timeLabel.text = time
        }
        
        if let post = post {
            postLabel.text = post
        }
        
        if let postPhoto = postPhoto {
            postImageView.image = postPhoto
        }
        
        if let like = like {
            likeButton.likeImage = like
        }
        
        if let comment = comment {
            commentButton.likeImage = comment
        }
        
        if let repost = repost {
            repostButton.likeImage = repost
        }
    }
    
    // вызывается один раз, это инициализация ячейки
    override func awakeFromNib() {
        super.awakeFromNib()
                setup()
                clearCell()
    }
}
