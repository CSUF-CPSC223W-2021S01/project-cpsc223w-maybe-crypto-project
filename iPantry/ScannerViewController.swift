//
//  ScannerViewController.swift
//  iPantry
//
//  Created by Conner Cook on 3/23/21.
//

//import UIKit
//import AVFoundation
//
//@objc protocol ScannerViewDelegate: class {
//    @objc func didFindScannedText(text: String)
//}
//
//class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
//    var captureSession: AVCaptureSession!
//    var previewLayer: AVCaptureVideoPreviewLayer!
//    
//    @objc public weak var delegate: ScannerViewDelegate?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = UIColor.black
//        captureSession = AVCaptureSession()
//        
//        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
//        let videoInput: AVCaptureDeviceInput
//        
//        do {
//            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
//        } catch {
//            return
//        }
//        
//        if (captureSession.canAddInput(videoInput)) {
//            captureSession.addInput(videoInput)
//        } else {
//            failed()
//            return
//        }
//        
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = view.layer.bounds
//        previewLayer.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(previewLayer)
//        captureSession.startRunning()
//    }
//    
//    func failed() {
//        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
//        captureSession = nil
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if (captureSession?.isRunning == false) {
//            captureSession.startRunning()
//        }
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        if (captureSession?.isRunning == true) {
//            captureSession.stopRunning()
//        }
//    }
//    
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        captureSession.stopRunning()
//        
//        if let metadataObject = metadataObjects.first {
//            guard let readableObject = metadataObjects as? AVMetadataMachineReadableCodeObject else { return }
//            guard let stringValue = readableObject.stringValue else { return }
//            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//            found(code: stringValue)
//        }
//        
//        dismiss(animated: true)
//    }
//    
//    func found(code: String) {
//        print(code)
//        delegate?.didFindScannedText(text: code)
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
//    
//}
