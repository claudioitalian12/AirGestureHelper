//
//  ViewController.swift
//  AirGesturesHelper
//
//  Created by gesture machines on 08/03/2019.
//  Copyright © 2019 gesture machines. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()
       
      view.layer.addSublayer(AirGesturesHelper.shared.cameraLayer)
     
        AirGesturesHelper.shared.cameraLayer.opacity = 0.0

        view.addSubview(AirGesturesHelper.shared.highlightView)
        
        AirGesturesHelper.shared.model = example_5s0_hand_model().model
        
        AirGesturesHelper.shared.startSession()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(tapAction))
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }

    
    @objc private func tapAction(recognizer: UITapGestureRecognizer) {
        AirGesturesHelper.shared.highlightView.frame.size = CGSize(width: 120, height: 120)
        AirGesturesHelper.shared.highlightView.center = recognizer.location(in: view)
        
        let originalRect = AirGesturesHelper.shared.highlightView.frame
        
        var convertedRect =
            AirGesturesHelper.shared.cameraLayer.metadataOutputRectConverted(fromLayerRect:
                originalRect)
        convertedRect.origin.y = 1 - convertedRect.origin.y
        AirGesturesHelper.shared.lastObservation = VNDetectedObjectObservation(boundingBox:
            convertedRect)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        AirGesturesHelper.shared.cameraLayerFrame(frame: view.bounds)
    }

}
