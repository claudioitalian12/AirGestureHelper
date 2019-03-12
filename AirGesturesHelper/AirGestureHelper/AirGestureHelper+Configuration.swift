//
//  AirGestureHelper+Configuration.swift
//  AirGesturesHelper
//
//  Created by gesture machines on 08/03/2019.
//  Copyright © 2019 gesture machines. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

extension AirGesturesHelper{
    
    func cameraLayerFrame(frame: CGRect){
        cameraLayer.frame = frame
    }
    
    func startSession(){
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label:
            "queue"))
        
        captureSession.addOutput(output)
        
        captureSession.startRunning()
    }
        
    func makeHighlightView(view: UIView){
        self.highlightView.frame.size = CGSize(width: 120, height: 120)
        self.highlightView.center = view.center
        
        let originalRect = self.highlightView.frame
        
        var convertedRect =
            self.cameraLayer.metadataOutputRectConverted(fromLayerRect:
                originalRect)
        convertedRect.origin.y = 1 - convertedRect.origin.y
        
        self.lastObservation = VNDetectedObjectObservation(boundingBox:
            convertedRect)
    }
    
}
