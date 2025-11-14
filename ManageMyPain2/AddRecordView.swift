import SwiftUI

struct AddRecordView: View {
    @EnvironmentObject private var store: PainStore
    @Environment(\.dismiss) private var dismiss

    @State private var date = Date()
    @State private var painType: PainType = .headache
    @State private var intensity: Double = 5
    @State private var durationMinutes: Double = 30
    @State private var note: String = ""

    var body: some View {
        Form {
            Section("When & where") {
                DatePicker("Date & time", selection: $date)

                Picker("Pain type", selection: $painType) {
                    ForEach(PainType.allCases) { type in
                        Text(type.displayName).tag(type)
                    }
                }
            }

            Section("Intensity") {
                Slider(value: $intensity, in: 0...10, step: 1)
                Text("Intensity: \(Int(intensity))/10")
            }

            Section("Duration") {
                Stepper("\(Int(durationMinutes)) minutes",
                        value: $durationMinutes,
                        in: 5...480,
                        step: 5)
            }

            Section("Note") {
                TextField("Describe your pain...", text: $note)
            }
        }
        .navigationTitle("Add pain record")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { saveRecord() }
            }
        }
    }
    private func saveRecord() {
        let entry = PainEntry(
            date: date,
            intensity: Int(intensity),
            painType: painType,
            durationMinutes: Int(durationMinutes),
            note: note
        )
        store.add(entry)       // ← IMPORTANT: uses `add`, not `addEntry`
        dismiss()
    }

    }
