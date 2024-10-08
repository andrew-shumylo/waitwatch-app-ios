//
//  waitwatchappApp.swift
//  waitwatchapp
//
//  Created by A.Shumylo on 08.09.2024.
//

import SwiftUI

struct ContentView: View {
    init() {
        let appearance = UITabBarAppearance()
                
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor.black

                UITabBar.appearance().tintColor = UIColor.orange
                UITabBar.appearance().unselectedItemTintColor = UIColor.gray.withAlphaComponent(0.6)
        
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
    
    var body: some View {
        TabView {
            WaitWatchView(isAddingMoment: .constant(false))
                .tabItem {
                    Image(systemName: "hourglass")
                    Text("WaitWatch")
                }
            
            MomentView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Moments")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
