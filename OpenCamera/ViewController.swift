//
//  ViewController.swift
//  OpenCamera
//
//  Created by florian BUREL on 04/04/2020.
//  Copyright © 2020 f10.solutions. All rights reserved.
//

import UIKit

import AVKit;

class ViewController: UIViewController {
    
    private var captureSession : AVCaptureSession!;
    private var videoPreviewLayer : AVCaptureVideoPreviewLayer!;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Create the capture session.
        self.captureSession = nil;
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return;
        }
        
        guard let input = try? AVCaptureDeviceInput.init(device: captureDevice) else {
            
            // Camera permission ??
            return;
        }
        
            
        let captureMetaDataOutput = AVCaptureMetadataOutput();
        
        self.captureSession  = AVCaptureSession();
        self.captureSession.addInput(input);
        self.captureSession.addOutput(captureMetaDataOutput);
        
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession);
        self.videoPreviewLayer.videoGravity = .resizeAspectFill;
        self.videoPreviewLayer.frame = self.view.layer.bounds;
        self.view.layer.addSublayer(self.videoPreviewLayer);
        
        self.captureSession.startRunning();
        
        
    }



}

