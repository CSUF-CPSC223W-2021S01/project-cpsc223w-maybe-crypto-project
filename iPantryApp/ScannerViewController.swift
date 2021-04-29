//
//  ScannerViewController.swift
//  iPantryApp
//
//  Created by Conner Cook on 4/29/21.
//

import UIKit
import Vision
import AVFoundation
import SafariServices

class ScannerViewController: UIViewController {
  // MARK: - Private Variables
  var captureSession = AVCaptureSession()

  // Make VNDetectBarcodesRequest variable, detects a barcode in an image
  lazy var detectBarcodeRequest = VNDetectBarcodesRequest { request, error in
    guard error == nil else {
      self.showAlert(
        withTitle: "Barcode error",
        message: error?.localizedDescription ?? "error")
      return
    }
    self.processClassification(request)
  }
  
  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    checkPermissions()
    setupCameraLiveView()
    
    //swipe right gesture to inventory page
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
    print(rightSwipe)
    rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
    self.view.addGestureRecognizer(rightSwipe)
    
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // Stop Session
    captureSession.stopRunning()
  }
}


extension ScannerViewController {
  // MARK: - Camera
  private func checkPermissions() {
    // Pretty much just asks for camera permissions in the application
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    // 1
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { [self] granted in
        if !granted {
          showPermissionsAlert()
        }
      }

    // 2
    case .denied, .restricted:
      showPermissionsAlert()

    // 3
    default:
      return
    }
  }

  private func setupCameraLiveView() {
    // Setup captureSession
    captureSession.sessionPreset = .hd1280x720 //instance of AVCaptureSession
    // 1
    let videoDevice = AVCaptureDevice
      .default(.builtInWideAngleCamera, for: .video, position: .back) //checks if phone has wide angle, can take video with back camera

    // 2
    guard
      let device = videoDevice,
      let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
      captureSession.canAddInput(videoDeviceInput)
      else {
        // 3
        showAlert(
          withTitle: "Cannot Find Camera",
          message: "There seems to be a problem with the camera on your device.")
        return
      }

    // 4
    captureSession.addInput(videoDeviceInput)
    
    // Add output
    let captureOutput = AVCaptureVideoDataOutput()
    // Set video sample rate
    captureOutput.videoSettings =
      [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
    captureOutput.setSampleBufferDelegate(
      self,
      queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
    captureSession.addOutput(captureOutput)
    
    configurePreviewLayer()

    // Run session
    captureSession.startRunning()
  }

  // MARK: - Vision
  func processClassification(_ request: VNRequest) {
    // Main logic
    // 1
    guard let barcodes = request.results else { return }
    DispatchQueue.main.async { [self] in
      if captureSession.isRunning {
        view.layer.sublayers?.removeSubrange(1...)

        // 2
        for barcode in barcodes {
          guard
            // Check for barcode symbology and confidence score
            let potentialBarcode = barcode as? VNBarcodeObservation,
            potentialBarcode.symbology != .QR,
            potentialBarcode.confidence > 0.9
            else { return }

          // 3
          showAlert(
            withTitle: potentialBarcode.symbology.rawValue,
            // Check the confidence score
            message: potentialBarcode.payloadStringValue ?? "" )
        }
      }
    }
  }

  // MARK: - Handler
  func observationHandler(payload: String?) {
    // TODO: Open it in Safari
  }
}


// MARK: - AVCaptureDelegation
extension ScannerViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    // Live Vision
    // 1
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }

    // 2
    let imageRequestHandler = VNImageRequestHandler(
      cvPixelBuffer: pixelBuffer,
      orientation: .right)

    // 3
    do {
      try imageRequestHandler.perform([detectBarcodeRequest])
    } catch {
      print(error)
    }
  }
}


// MARK: - Helper
extension ScannerViewController {
  private func configurePreviewLayer() {
    let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    cameraPreviewLayer.videoGravity = .resizeAspectFill
    cameraPreviewLayer.connection?.videoOrientation = .portrait
    cameraPreviewLayer.frame = view.frame
    view.layer.insertSublayer(cameraPreviewLayer, at: 0)
  }

  private func showAlert(withTitle title: String, message: String) {
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alertController, animated: true)
    }
  }

  private func showPermissionsAlert() {
    showAlert(
      withTitle: "Camera Permissions",
      message: "Please open Settings and grant permission for this app to use your camera.")
  }
}


// MARK: - SafariViewControllerDelegate
extension ScannerViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    captureSession.startRunning()
  }
}




