//
//  HomeView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI

// HomeView.swift
struct HomeView: View {
    @State private var selectedTab: Int = 0
    @State  var QRSearchText = ""

    var body: some View {
        TabView(selection: $selectedTab) {
            ListView(searchTextForQR : $QRSearchText)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("List")
                }
                .tag(0)

            QRSearchView(selectedTab: $selectedTab, QRSearchText: $QRSearchText)
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("QR")
                }
                .tag(1)
        }
        .navigationBarBackButtonHidden(true)
        .font(.custom("SFPro-Regular", size: 15))
        .foregroundColor(.customText)
    }
}


#Preview {
    HomeView()
}
