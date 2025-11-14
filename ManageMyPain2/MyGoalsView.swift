import SwiftUI

struct MyGoalsView: View {
    @EnvironmentObject private var goalStore: GoalStore
    @State private var showAddGoal = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            ScrollView {
                VStack(spacing: 20) {

                    Text("Daily Goals")
                        .font(.title2.bold())
                        .padding(.top)

                    ForEach(goalStore.goals) { goal in
                        goalRow(goal)
                    }

                    Spacer(minLength: 50)
                }
                .padding(.top)
            }

            // MARK: - Floating Add Button
            Button {
                showAddGoal = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color.blue)
                            .shadow(radius: 10)
                    )
            }
            .padding(.trailing, 25)
            .padding(.bottom, 25)
        }
        .sheet(isPresented: $showAddGoal) {
            AddGoalSheet()
                .environmentObject(goalStore)
        }
    }

    // MARK: - Single Goal Row
    private func goalRow(_ goal: Goal) -> some View {
        let completed = goalStore.isCompleted(goal)

        return Button {
            goalStore.toggle(goal)
        } label: {
            HStack {
                Image(systemName: goal.systemImage)
                    .font(.title2)
                    .padding(8)

                VStack(alignment: .leading) {
                    Text(goal.title)
                        .font(.headline)

                    Text(goal.detail)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(completed ? .green : .gray)
            }
            .padding()
            .background(
                LiquidGlassView()   // <- glassmorphism card
            )
            .padding(.horizontal)
        }
        .buttonStyle(.plain)
        .transition(.opacity.combined(with: .scale))
        .animation(.spring(), value: goalStore.goals)
    }
}

#Preview {
    MyGoalsView()
        .environmentObject(GoalStore())
}
