//
//  FriendPhotoViewControllerCollection.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 19.05.2021.
//

import UIKit

class FriendPhotoViewController: UIViewController {
    
    var photos: Friend?
    // передаем индекс выбраной фотографии (храним в свойстве selectedIndex индекс выбраного слайда)
    var selectedIndex: Int = 0
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.image = photos?.userPhotos[selectedIndex]
        
        // фон экрана будет как фон картинки
        photoImageView.backgroundColor = view.backgroundColor
        // добавим жест в лево
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        // добавим жест в право
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightAction))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
}
extension FriendPhotoViewController {
    @objc
    func swipeLeftAction() {
        
        // убедимся что мы не на последней картинке
        guard photos?.userPhotos.count ?? 0 > selectedIndex + 1 else { return }
        // если есть куда свайпать то мы получаем картинку
        let nextImage = photos?.userPhotos[selectedIndex + 1]
        // создали UIImageView
        let newTemporaryImageView = UIImageView()
        newTemporaryImageView.backgroundColor = view.backgroundColor
        newTemporaryImageView.contentMode = .scaleAspectFit
        newTemporaryImageView.image = nextImage
        // frame указываем как в текущей картинке
        newTemporaryImageView.frame = photoImageView.frame
        // двигаем в право на ширину этой картинки photoImageView
        newTemporaryImageView.frame.origin.x += photoImageView.frame.width
        // добавляем в addSubview
        view.addSubview(newTemporaryImageView)
        // начинаем анимацию
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                // существующею картинку уменьшаем на 20% (делаем scaleX 0.8)
                self.photoImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7) {
                // с права картинку двигаем в лево, двигаем туда где сейчас находится текущая картинка
                newTemporaryImageView.frame.origin.x = 0
            }
        } completion: { _ in
            // повышаем selectedIndex
            self.selectedIndex += 1
            // ставим следующую картинку по списку
            self.photoImageView.image = nextImage
            // отменяем трансформацию
            self.photoImageView.transform = .identity
            // удаляем временную картинку
            newTemporaryImageView.removeFromSuperview()
        }
    }
    
    @objc
    func swipeRightAction() {
        // если selectedIndex > 0 то можем свайпать назад
        guard selectedIndex > 0 else { return }
        // если есть куда свайпать то мы получаем картинку
        let nextImage = photos?.userPhotos[selectedIndex - 1]
        // создали UIImageView
        let newTemporaryImageView = UIImageView()
        newTemporaryImageView.backgroundColor = view.backgroundColor
        newTemporaryImageView.contentMode = .scaleAspectFit
        newTemporaryImageView.image = nextImage
        // frame указываем как в текущей картинке
        newTemporaryImageView.frame = photoImageView.frame
        // уменьшаем картинку которая с зади до scaleX: 0.8
        newTemporaryImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        // добавляем в addSubview
        view.addSubview(newTemporaryImageView)
        // ставим картинку на задний план
        view.sendSubviewToBack(newTemporaryImageView)
        // начинаем анимацию
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                self.photoImageView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3) {
                newTemporaryImageView.transform = .identity
            }
        } completion: { _ in
            // повышаем selectedIndex
            self.selectedIndex -= 1
            // ставим следующую картинку по списку
            self.photoImageView.image = nextImage
            // отменяем трансформацию
            self.photoImageView.transform = .identity
            // удаляем временную картинку
            newTemporaryImageView.removeFromSuperview()
        }
    }
}
