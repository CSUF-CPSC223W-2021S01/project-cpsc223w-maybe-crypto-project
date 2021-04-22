//
//  ViewController.swift
//  iPantry
//
//  Created by Melanie Mach on 3/10/21.
//
import UIKit
import Vision
import AVFoundation
import SafariServices

class ViewController: UIViewController {
  // Private Variables
  var captureSession = AVCaptureSession()

  // Var DetectBarcodesRequest variable
  lazy var detectBarcodeRequest = VNDetectBarcodesRequest { request, error in
    guard error == nil else {
      self.showAlert(
        withTitle: "Barcode error",
        message: error?.localizedDescription ?? "error")
      return
    }
    self.processClassification(request)
  }
  
  // Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    checkPermissions()
    setupCameraLiveView()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // Stop Session
    captureSession.stopRunning()
  }
}


extension ViewController {
  // MARK: - Camera
  private func checkPermissions() {
    // Checking permissions
    switch AVCaptureDevice.authorizationStatus(for: .video) {

    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { [self] granted in
        if !granted {
          showPermissionsAlert()
        }
      }

    case .denied, .restricted:
      showPermissionsAlert()

    default:
      return
    }
  }

  private func setupCameraLiveView() {
    //Setup captureSession
    captureSession.sessionPreset = .hd1280x720
    // Add input
    let videoDevice = AVCaptureDevice
      .default(.builtInWideAngleCamera, for: .video, position: .back)

    guard
      let device = videoDevice,
      let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
      captureSession.canAddInput(videoDeviceInput)
      else {
        showAlert(
          withTitle: "Cannot Find Camera",
          message: "There seems to be a problem with the camera on your device.")
        return
      }
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
    guard let barcodes = request.results else { return }
    DispatchQueue.main.async { [self] in
      if captureSession.isRunning {
        view.layer.sublayers?.removeSubrange(1...)

        for barcode in barcodes {
            guard
              // Check for QR Code symbology and confidence score
              let potentialQRCode = barcode as? VNBarcodeObservation,
              potentialQRCode.confidence > 0.9
              else { return }

          // 3
          showAlert(
            withTitle: potentialQRCode.symbology.rawValue,
            // Check the confidence score
            message: potentialQRCode.payloadStringValue ?? String(potentialQRCode.confidence) )
        }
      }
    }
  }

  // MARK: - Handler
  func observationHandler(payload: String?) {
    // Open it in Safari
  }
}


// AVCaptureDelegation
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    // Live Vision
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }
    
    let imageRequestHandler = VNImageRequestHandler(
      cvPixelBuffer: pixelBuffer,
      orientation: .right)

    do {
      try imageRequestHandler.perform([detectBarcodeRequest])
    } catch {
      print(error)
    }
  }
}


// Helper
extension ViewController {
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



// SafariViewControllerDelegate
extension ViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    captureSession.startRunning()
  }
=======
   
}

