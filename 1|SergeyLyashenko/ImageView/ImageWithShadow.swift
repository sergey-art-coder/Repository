//
//  ImageWithShadow.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 22.05.2021.
//

import UIKit

class ImageWithShadow: UIView {
    
    // в переменных которые отвечают за настройки тени сделаем свойства которые настраиваются из storyboard
    // устанавливаем цыет тени
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    // устанавливаем прозрачность тени
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    // устанавливаем размер тени
    @IBInspectable var shadowRadius: CGFloat = 8 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    // устанавливаем сдвиг тени по X и Y
    @IBInspectable var shadowOffset: CGSize = .zero {//CGSize(width: 2, height: 2) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    // создаем переменную image для самой картинки, тип у нее будет UIImage? и по умолчанию отсутствует
    
    @IBInspectable var image: UIImage? = nil {
        didSet {
            // когда меняем картинку то imageView тоже меняет картинку
            imageView.image = image
            setNeedsDisplay()
        }
    }
    
    // cornerRadius - отвечает за закругление краев
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            // masksToBounds - обрез контента картинки по ее размерам. Если cornerRadius > 0 то обрезаем картинку по краям, если равен нулю то не обрезаем картинку по краям
            imageView.layer.masksToBounds = cornerRadius > 0
            // установливаем новое значение
            imageView.layer.cornerRadius = cornerRadius
        }
    }
    
    // создаем переменную imageView которая будет отвечать за картинку и проинициализируем
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        // добавляем картинку как Subview в контейнер
        addSubview(imageView)
        // для картинки указываем тип заполнения контента scaleAspectFill
        imageView.contentMode = .scaleAspectFill
        //цвет ставим прозрачный (убираем фон)
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // размер imageView подравниваем под размер контейнера
        imageView.frame = bounds
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction]) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { completed in
            
        }
    }
    
    override func touchesEnded (_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction]) {
            self.transform = .identity
        } completion: { completed in
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction]) {
            self.transform = .identity
        } completion: { completed in
            
        }
    }
}
