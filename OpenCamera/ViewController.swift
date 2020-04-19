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
    
    private var videoPreviewLayerBoundsUpdated = false;
    
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
        
        videoPreviewLayerBoundsUpdated = false;
            
        let captureMetaDataOutput = AVCaptureMetadataOutput();
        
        self.captureSession  = AVCaptureSession();
        self.captureSession.addInput(input);
        self.captureSession.addOutput(captureMetaDataOutput);
        
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession);
        self.videoPreviewLayer.videoGravity = .resizeAspectFill;
//        self.videoPreviewLayer.frame = self.view.layer.bounds;
        
        self.view.layer.addSublayer(self.videoPreviewLayer);
        
        self.captureSession.startRunning();
        
        
    }

    override func viewDidLayoutSubviews() {
        if !videoPreviewLayerBoundsUpdated
        {
            videoPreviewLayerBoundsUpdated = true;
            self.videoPreviewLayer.frame = self.view.layer.bounds;
        }
        
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        videoPreviewLayerBoundsUpdated = false;
        
        let orientation = UIDevice.current.orientation;
        switch orientation {
        case .faceUp:
            self.videoPreviewLayer.connection!.videoOrientation = .portrait;
        case .faceDown:
            self.videoPreviewLayer.connection!.videoOrientation = .portraitUpsideDown;
        case .landscapeRight:
            self.videoPreviewLayer.connection!.videoOrientation = .landscapeLeft;
        case .landscapeLeft:
            self.videoPreviewLayer.connection!.videoOrientation = .landscapeRight;
        case .unknown:
            self.videoPreviewLayer.connection!.videoOrientation = .portrait;
        case .portrait:
            self.videoPreviewLayer.connection!.videoOrientation = .portrait;
        case .portraitUpsideDown:
            self.videoPreviewLayer.connection!.videoOrientation = .portraitUpsideDown;
        @unknown default:
            self.videoPreviewLayer.connection!.videoOrientation = .portrait;
        }
        
    }
  

}

