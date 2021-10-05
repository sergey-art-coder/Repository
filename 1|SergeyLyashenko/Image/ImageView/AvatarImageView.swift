//
//  RoundedView.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 29.05.2021.


import UIKit

class AvatarImageView: UIImageView {
    
    // cornerRadius - отвечает за закругление краев
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = cornerRadius > 0
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
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
    
    // анимация при тапе на аватар
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
