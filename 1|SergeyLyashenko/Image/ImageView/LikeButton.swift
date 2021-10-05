//
//  LikeButton.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 22.05.2021.
//

import UIKit

@IBDesignable class LikeButton: UIControl {
    @IBInspectable var likesCount: Int = 0 {
        didSet {
            //  var likesCount: Int = 0
            updateSelectionState()
        }
    }
    // картинка для лайка
    @IBInspectable var likeImage: UIImage? = nil {
        didSet {
            likeImageView.image = likeImage
        }
    }
    // контейнер
    private var stackView: UIStackView!
    // Label для счетчика
    private var countLabel: UILabel!
    // лайк
    private var likeImageView: UIImageView!
    
    // в конструкторе вызываем метод commonInit
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // выравниваем stackView по размерам самого элемента
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    // в методе commonInit создаем и настраиваем элеменнты
    private func commonInit() {
        countLabel = UILabel()
        likeImageView = UIImageView()
        // что бы вписывался полностью в размеры картинки
        likeImageView.contentMode = .scaleAspectFit
        // выравнивание по левому краю
        countLabel.textAlignment = .left
        stackView = UIStackView(arrangedSubviews: [countLabel, likeImageView])
        addSubview(stackView)
        // отступ
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        updateSelectionState()
    }
    
    private func updateLabelText() {
        let additionalLikes = isSelected ? 1 : 0
        let totalLikes = likesCount + additionalLikes
        if totalLikes >= 1000 {
            countLabel.text = "1К"
        } else {
            countLabel.text = "\(totalLikes)"
        }
        
    }
    // функция которая обрабатывает изменение состояния выдиления (меняется цвет)
    private func updateSelectionState() {
        let color = isSelected ? tintColor : .black
        countLabel.textColor = color
        likeImageView.tintColor = color
        updateLabelText()
    }
    
    // обработчик нажатий (при нажатии на кнопку меняем состояние)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = !isSelected
        updateSelectionState()
        countLabelAnimations()
    }
    
    // анимация счетчиков (лайков, комментариев и тд)
    private func countLabelAnimations() {
        let animatin = CASpringAnimation(keyPath: "transform.scale")
        //  начальное значение
        animatin.fromValue = 1
        // конечное значение
        animatin.toValue = 2
        // длительность анимации
        animatin.duration = 1
        // можем запланировать на любое время анимацию (CACurrentMediaTime() - текущее время)
        animatin.beginTime = CACurrentMediaTime()
        animatin.fillMode = .backwards
        // жесткость пружины
        animatin.stiffness = 200
        animatin.damping = 0.9
        // масса
        animatin.mass = 0.5
        countLabel.layer.add(animatin, forKey: nil)
    }
}
