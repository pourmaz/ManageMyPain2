import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            AddRecordView()
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                }

            HeadachePatternView()
                .tabItem {
                    Label("Headaches", systemImage: "brain.head.profile")
                }

            MyGoalsView()
                .tabItem {
                    Label("Goals", systemImage: "checklist")
                }
        }
    }
}
#Preview {
    RootTabView()
        .environmentObject(PainStore())
        .environmentObject(GoalStore())
}
