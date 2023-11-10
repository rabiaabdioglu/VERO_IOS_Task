//
//  QRSearchView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI

import AVFoundation

struct QRSearchView: View {
    @State private var isScanning = false
    @State private var scannedText = ""

    var body: some View {
        VStack {
            if isScanning {
                ScannerView(scannedText: $scannedText, isScanning: $isScanning)
            } else {
                Text("Scanned QR Code: \(scannedText)")
            }

            Button(action: {
                isScanning.toggle()
            }) {
                Text(isScanning ? "Stop Scanning" : "Start Scanning")
            }
        }
    }
}

struct ScannerView: View {
    @Binding var scannedText: String
    @Binding var isScanning: Bool

    var body: some View {
        ZStack {
            ScannerRepresentable(scannedText: $scannedText, isScanning: $isScanning)
            Button(action: {
                isScanning = false
            }) {
                Text("Stop Scanning")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 50)
        }
    }
}

struct ScannerRepresentable: UIViewControllerRepresentable {
    @Binding var scannedText: String
    @Binding var isScanning: Bool

    func makeUIViewController(context: Context) -> ScannerViewController {
        let scannerViewController = ScannerViewController()
        scannerViewController.scannedText = $scannedText
        scannerViewController.isScanning = $isScanning
        return scannerViewController
    }

    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        // Not needed for now
    }
}

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var scannedText: Binding<String>!
    var isScanning: Binding<Bool>!

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                let stringValue = readableObject.stringValue else { return }
            found(code: stringValue)
        }
    }

    func found(code: String) {
        scannedText.wrappedValue = code
        isScanning.wrappedValue = false
        captureSession.stopRunning()
    }

    func failed() {
        // Handle error here
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if isScanning.wrappedValue {
            if (captureSession?.isRunning == false) {
           //     captureSession.startRunning()
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
}

struct QRSearchView_Previews: PreviewProvider {
    static var previews: some View {
        QRSearchView()
    }
}

#Preview {
    QRSearchView()
}
