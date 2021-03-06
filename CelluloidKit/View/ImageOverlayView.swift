//
//  ImageOverlayView.swift
//  Celluloid
//
//  Created by Mango on 16/3/21.
//  Copyright © 2016年 Mango. All rights reserved.
//

import Foundation

open class ImageOverlayView: UIView {
    
    open var bubbleModels: [BubbleModel] {
        return self.subviews.flatMap { $0 as? BubbleView }
            .map({ $0.bubbleModel })
    }
    
    open var stickerModels: [StickerModel] {
        return self.subviews.flatMap({ $0 as? StickerView })
            .map({ $0.stickerModel })
    }
    
    //MARK: init
    fileprivate func commonInit() {
        self.backgroundColor = UIColor.clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(touch))
        self.addGestureRecognizer(tap)
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    open static func makeViewOverlaysImageView(_ imageView: UIImageView) -> ImageOverlayView {
        let overlayView = ImageOverlayView()
        imageView.addSubview(overlayView)
        overlayView.frame = imageView.imageRect
        return overlayView
    }
    
    //MARK: layout
    open func adjustFrame() {
        if let imageView = self.superview as? UIImageView {
            self.frame = imageView.imageRect
        }
    }
    
    open func addBubble(_ bubbleModel: BubbleModel) {
        let bubble = BubbleView(bubbleModel: bubbleModel)
        self.addSubview(bubble)
    }
    
    open func addSticker(_ stickerModel: StickerModel) {
        let sticker = StickerView(stickerModel: stickerModel)
        self.addSubview(sticker)
    }
    
}

//MARK: Action
extension ImageOverlayView {
    @objc func touch() {
        self.subviews.flatMap({ $0 as? AttachView }).forEach{
            $0.hideButtonEnable = true
        }
    }
}
