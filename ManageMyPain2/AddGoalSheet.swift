import SwiftUI

struct AddGoalSheet: View {
    @EnvironmentObject private var goalStore: GoalStore
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var detail = ""
    @State private var systemImage = "star.fill"

    private let iconOptions = [
        "figure.walk",
        "bed.double.fill",
        "drop.fill",
        "heart.fill",
        "bolt.fill",
        "sun.max.fill"
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section("Goal Title") {
                    TextField("e.g. 20-minute walk", text: $title)
                }

                Section("Details") {
                    TextField("Describe your goal...", text: $detail)
                }

                Section("Icon") {
                    Picker("Choose icon", selection: $systemImage) {
                        ForEach(iconOptions, id: \.self) { icon in
                            Label(icon, systemImage: icon)
                                .tag(icon)
                        }
                    }
                }
            }
            .navigationTitle("New Goal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        saveGoal()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }

    private func saveGoal() {
        goalStore.addGoal(
            title: title,
            detail: detail,
            systemImage: systemImage
        )
    }
}
