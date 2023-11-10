//
//  HomeView.swift
//  VERO_IOS_Task
//
//  Created by Rabia Abdioğlu on 3.11.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
                       ListView()
                           .tabItem {
                               Image(systemName: "list.dash")
                               Text("List")
                           }

                       QRSearchView()
                           .tabItem {
                               Image(systemName: "qrcode.viewfinder")
                               Text("QR")
                           }
                   }        .navigationBarBackButtonHidden(true)

               }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

#Preview {
    HomeView()
}
