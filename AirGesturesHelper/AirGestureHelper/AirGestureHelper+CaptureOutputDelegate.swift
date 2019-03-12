//
//  AirGestureHelper+CaptureOutputDelegate.swift
//  AirGesturesHelper
//
//  Created by gesture machines on 08/03/2019.
//  Copyright © 2019 gesture machines. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

extension AirGesturesHelper: AVCaptureVideoDataOutputSampleBufferDelegate{
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer:
        CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        if(model == nil){
            captureNoModel(pixelBuffer: pixelBuffer)
        }
        else{
            captureOutputModel(pixelBuffer: pixelBuffer)
        }
    }
    
    func handle(_ request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let newObservation = request.results?.first as?
                VNDetectedObjectObservation else {
                    return
            }
            self.lastObservation = newObservation
            var transformedRect = newObservation.boundingBox
            transformedRect.origin.y = 1 - transformedRect.origin.y
            let convertedRect =
                self.cameraLayer.layerRectConverted(fromMetadataOutputRect:
                    transformedRect)
            
            self.highlightView.layer.position = convertedRect.origin
            
            print(self.highlightView.frame.maxX)
            
            self.rightHandler()
        
        }
    }
    
    func rightHandler(){
        self.rightSwipeGesture(completion: { (success) -> Void in
            
            if success { // this will be equal to whatever value is set in this method call
               self.highlightView.backgroundColor = .green
                
            } else {
                print("false")
                self.highlightView.backgroundColor = .red
                    self.leftHandler()
            }
        })
    }
    
    func leftHandler(){
        self.leftSwipeGesture(completion: { (success) -> Void in
            
            if success { // this will be equal to whatever value is set in this method call
                
                self.highlightView.backgroundColor = .green
                
            } else {
                print("false")
                self.highlightView.backgroundColor = .red
            }
        })
    }
    
    func captureNoModel(pixelBuffer: CVImageBuffer){
        guard let observation = self.lastObservation else {
            return
        }
        let request = VNTrackObjectRequest(detectedObjectObservation:
        observation) { [unowned self] request, error in
            self.handle(request, error: error)
        }
        request.trackingLevel = .accurate
        do {
            try self.handler.perform([request], on: pixelBuffer)
            
        }
        catch {
            print(error)
        }
    }
    
    func captureOutputModel(pixelBuffer: CVImageBuffer){
        guard let model = try? VNCoreMLModel(for: model!) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            DispatchQueue.global(qos: .default).sync {
                
                self.startCaptureObject(pixelBuffer: pixelBuffer,identifier: firstObservation.identifier)
                
            }
            
            print(firstObservation.identifier, firstObservation.confidence)
            
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    func startCaptureObject(pixelBuffer: CVImageBuffer, identifier: String){
        if(identifier == "FIVE-UB-RHand") {
            DispatchQueue.main.async {
                if(self.firstTime == true){
                    
                    self.makeHighlightView(view: self.rootVC.view)
                    self.firstTime = false
                }}
            self.captureNoModel(pixelBuffer: pixelBuffer)
        }
    }
 
}
