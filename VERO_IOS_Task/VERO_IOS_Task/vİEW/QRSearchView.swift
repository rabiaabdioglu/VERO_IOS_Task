//
//  QRSearchView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import CodeScanner
import SwiftUI

// QRSearchView.swift
struct QRSearchView: View {
    @State private var scannedText: String?
    @State private var isPresentingScanner = false
    @Binding var selectedTab: Int  // Add binding for selectedTab
    @Binding var QRSearchText: String

    var body: some View {
        NavigationView {
            VStack {
                if let scannedText = scannedText {
                 
                    Text("Scanned Text: \(scannedText)")
                        .padding()
                } else {
                    Text("Scan a QR code to search for tasks.")
                        .padding()
                }

                Button(action: {
                    isPresentingScanner = true
                }) {
                    Image(systemName: "camera.viewfinder")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding()
                }
                .sheet(isPresented: $isPresentingScanner) {
                    CodeScannerView(codeTypes: [.qr]) { result in
                        switch result {
                        case .success(let code):
                            scannedText = code.string
                            isPresentingScanner = false
                            QRSearchText = scannedText ?? ""
                            print(QRSearchText)
                            selectedTab = 0  // Switch to the "List" tab
                        case .failure(let error):
                            print("Scanning failed with error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
