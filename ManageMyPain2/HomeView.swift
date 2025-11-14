import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var store: PainStore
    @State private var painValue: Double = 0
    @State private var selectedDate = Date()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                topHeader

                ScrollView {
                    VStack(spacing: 24) {
                        painSection
                        addButtons
                        Text("Welcome to ManageMyPain2!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
            .ignoresSafeArea(.container, edges: .top)
        }
    }

    private var topHeader: some View {
        ZStack {
            Color.blue.frame(height: 150)
            Text("Manage My Pain 2")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.top, 20)
        }
    }

    private var painSection: some View {
        VStack(spacing: 16) {
            Text("How is your pain right now?")
                .font(.headline)

            Text("\(Int(painValue))")
                .font(.largeTitle.bold())
                .foregroundColor(.green)

            ZStack {
                LinearGradient(colors: [.green, .yellow, .orange, .red],
                               startPoint: .leading,
                               endPoint: .trailing)
                    .frame(height: 6)
                    .cornerRadius(3)

                Slider(value: $painValue, in: 0...10, step: 1)
                    .tint(.clear)
            }

            HStack {
                Text("No pain")
                Spacer()
                Text("Worst ever")
            }.font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 1)
    }

    private var addButtons: some View {
        VStack(spacing: 12) {
            NavigationLink(destination: AddRecordView()) {
                Text("Add pain record")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            NavigationLink(destination: Text("Reflection Page Coming Soon")) {
                Text("Add daily reflection")
                    .foregroundColor(.blue)
            }
        }
    }
}


