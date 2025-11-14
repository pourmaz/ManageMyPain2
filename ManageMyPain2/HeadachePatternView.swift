import SwiftUI
import Charts

struct HeadachePatternView: View {
    @EnvironmentObject private var store: PainStore
    @State private var rangeInDays = 7

    var filtered: [PainEntry] {
        store.headacheEntries(lastDays: rangeInDays)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Picker("Range", selection: $rangeInDays) {
                    Text("7 days").tag(7)
                    Text("30 days").tag(30)
                }
                .pickerStyle(.segmented)

                if filtered.isEmpty {
                    Text("No headache records for this range.")
                        .foregroundColor(.secondary)
                } else {
                    chartSection
                }
            }
            .padding()
        }
        .navigationTitle("Headache Pattern")
    }

    private var chartSection: some View {
        Chart {
            ForEach(filtered) { entry in
                LineMark(
                    x: .value("Date", entry.date),
                    y: .value("Intensity", entry.intensity)
                )
                .foregroundStyle(.red)
            }
        }
        .frame(height: 260)
    }
}

