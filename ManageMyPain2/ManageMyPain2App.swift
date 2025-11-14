import SwiftUI

@main
struct ManageMyPain2App: App {
    @StateObject private var painStore = PainStore()
    @StateObject private var goalStore = GoalStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(painStore)
                .environmentObject(goalStore)
        }
    }
}

