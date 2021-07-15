//
//  CropMaskViewManager.swift
//  Mantis
//
//  Created by Echo on 10/28/18.
//  Copyright © 2018 Echo. All rights reserved.
//

import UIKit

class CropMaskViewManager {
    fileprivate var dimmingView: CropDimmingView!
    fileprivate var visualEffectView: CropVisualEffectView!
    
    var cropShapeType: CropShapeType = .rect
    
    var cropVisualEffectBackgroundAlpha: CGFloat = 1.0

    init(with superview: UIView,
         cropShapeType: CropShapeType = .rect,
         cropVisualEffectBackgroundAlpha: CGFloat = 1.0) 
    {
        setup(in: superview)
        self.cropShapeType = cropShapeType
        self.cropVisualEffectBackgroundAlpha = cropVisualEffectBackgroundAlpha
    }
    
    private func setupOverlayView(in view: UIView) {
        dimmingView = CropDimmingView(cropShapeType: cropShapeType)
        dimmingView.isUserInteractionEnabled = false
        dimmingView.alpha = 0
        view.addSubview(dimmingView)
    }
    
    private func setupTranslucencyView(in view: UIView) {
        visualEffectView = CropVisualEffectView(cropShapeType: cropShapeType)
        visualEffectView.isUserInteractionEnabled = false
        view.addSubview(visualEffectView)
    }

    func setup(in view: UIView) {
        setupOverlayView(in: view)
        setupTranslucencyView(in: view)
    }
    
    func removeMaskViews() {
        dimmingView.removeFromSuperview()
        visualEffectView.removeFromSuperview()
    }
    
    func bringMaskViewsToFront() {
        dimmingView.superview?.bringSubviewToFront(dimmingView)
        visualEffectView.superview?.bringSubviewToFront(visualEffectView)
    }
    
    func showDimmingBackground() {
        UIView.animate(withDuration: 0.1) {
            self.dimmingView.alpha = 1
            self.visualEffectView.alpha = 0
        }
    }
    
    func showVisualEffectBackground() {
        UIView.animate(withDuration: 0.5) {
            self.dimmingView.alpha = 0
            self.visualEffectView.alpha = self.cropVisualEffectBackgroundAlpha
        }
    }
    
    func adaptMaskTo(match cropRect: CGRect) {
        dimmingView.adaptMaskTo(match: cropRect)
        visualEffectView.adaptMaskTo(match: cropRect)
    }
}
