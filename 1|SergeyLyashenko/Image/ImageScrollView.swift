//
//  ImageScrollView.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 03.10.2021.
//

import UIKit

class ImageScrollView: UIScrollView, UIScrollViewDelegate {

    // свойство которое содержит в себе изображение
    var photoImageView: UIImageView!
    
    lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        
        // свойство numberOfTapsRequired отвечает при скольки колличествах нажатия на экран будет срабатывать данный жест
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        // устанавливаем скорость передвижения ползунка (fast очень быстро)
        self.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // функция в которой будем создавать новые объекты типа ImageScrollView
    func set(image: UIImage) {
        
        // если мы переиспользуем данную ячейку класса то предыдущая фотография будет удаляться
        photoImageView?.removeFromSuperview()
        photoImageView = nil
        
        photoImageView = UIImageView(image: image)
        self.addSubview(photoImageView)
        
        configurateFor(imageSize: image.size)
    }
    
    func configurateFor(imageSize: CGSize) {
        
        // свойство contentSize хранит в себе значения типа CGSize (можем скролить фотографию)
        self.contentSize = imageSize
        
        setCurrentMaxandMinZoomScale()
        self.zoomScale = self.minimumZoomScale
        
        // зарегестрируем жест
        self.photoImageView.addGestureRecognizer(self.zoomingTap)
        self.photoImageView.isUserInteractionEnabled = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.centerImage()
    }
    
    func setCurrentMaxandMinZoomScale() {
        
        // зафиксируем размеры нашего устройства (зафиксируем рамки)
        let boundsSize = self.bounds.size
        // зафиксируем размеры фотографии
        let imageSize = photoImageView.bounds.size
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1.0
        if minScale < 0.1 {
            maxScale = 0.3
        }
        if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        }
        if minScale >= 0.5 {
            maxScale = max(1.0, minScale)
        }
        
        // минимальный размер фотографии до которого мы можем зумить
        self.minimumZoomScale = minScale
        // максимальный размер фотографии до которого мы можем зумить
        self.maximumZoomScale = maxScale
    }
    
    // func centerImage() - для того когда мы зумим то картинка возращается в центру экрана
    func centerImage() {
        
        // зафиксируем размеры нашего устройства (зафиксируем рамки)
        let boundsSize = self.bounds.size
        // зафиксируем frame до центра
        var frameToCenter = photoImageView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        photoImageView.frame = frameToCenter
    }
    
    // gesture
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
    
    // логика нажатия на жест (по первому нажатию картинка увеличивается в два раза и по повторному сварачивается в два раза)
    func zoom(point: CGPoint, animated: Bool) {
        let currectScale = self.zoomScale
        let minScale = self.minimumZoomScale
        let maxScale = self.maximumZoomScale
        
        if (minScale == maxScale && minScale > 1) {
            return
        }
        
        let toScale = maxScale
        let finalScale = (currectScale == minScale) ? toScale : minScale
        let zoomRect = self.zoomRect(scale: finalScale, center: point)
        self.zoom(to: zoomRect, animated: animated)
    }
    
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = self.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
}

