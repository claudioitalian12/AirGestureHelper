//
//  AirGestureHelper.swift
//  AirGesturesHelper
//
//  Created by gesture machines on 08/03/2019.
//  Copyright © 2019 gesture machines. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class AirGesturesHelper: AVCaptureVideoDataOutput {
    
    static let shared = AirGesturesHelper()
    
    lazy var captureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.photo
        guard let frontCamera =         AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front),
            let input = try? AVCaptureDeviceInput(device: frontCamera) else
        {
            return session
        }
        session.addInput(input)
        return session
    }()
    
    lazy var cameraLayer: AVCaptureVideoPreviewLayer =
        AVCaptureVideoPreviewLayer(session: self.captureSession)
    
    var handler = VNSequenceRequestHandler()
    
    var lastObservation: VNDetectedObjectObservation?
    
    lazy var highlightView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 4
        view.backgroundColor = .clear
        return view
    }()
    
    var model: MLModel?
    
    var firstTime = true
    
    var traslationDuringAcrion = [CGFloat]()
    
    lazy var rootVC : UIViewController = {
        return UIApplication.shared.keyWindow!.rootViewController!
    }()
    
    override init() {}
    
    init(captureSession: AVCaptureSession, cameraLayer: AVCaptureVideoPreviewLayer, handler: VNSequenceRequestHandler, lastObservation: VNDetectedObjectObservation, highlightView: UIView) {
        super.init()
        self.captureSession = captureSession
        self.cameraLayer = cameraLayer
        self.handler = handler
        self.lastObservation = lastObservation
        self.highlightView = highlightView
    }
    
}


class VideoProva: AirGesturesHelper{
    
}
