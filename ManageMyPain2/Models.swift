import Foundation
import Combine

// MARK: - Pain Models

enum PainType: String, CaseIterable, Identifiable, Codable {
    case headache
    case back
    case neck
    case fibromyalgia
    case arthritis
    case other

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .headache: return "Headache"
        case .back: return "Back Pain"
        case .neck: return "Neck Pain"
        case .fibromyalgia: return "Fibromyalgia"
        case .arthritis: return "Arthritis"
        case .other: return "Other"
        }
    }
}

struct PainEntry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var intensity: Int
    var painType: PainType
    var durationMinutes: Int
    var note: String?

    init(
        id: UUID = UUID(),
        date: Date,
        intensity: Int,
        painType: PainType,
        durationMinutes: Int,
        note: String? = nil
    ) {
        self.id = id
        self.date = date
        self.intensity = intensity
        self.painType = painType
        self.durationMinutes = durationMinutes
        self.note = note
    }
}

@MainActor
class PainStore: ObservableObject {
    @Published var entries: [PainEntry] = []

    init() {
        entries = sampleData()
    }

    func add(_ entry: PainEntry) {
        entries.append(entry)
    }

    // Filter headaches for chart usage
    func headacheEntries(lastDays: Int? = nil) -> [PainEntry] {
        let headaches = entries.filter { $0.painType == .headache }

        guard let days = lastDays else { return headaches }

        let start = Calendar.current.date(byAdding: .day, value: -days, to: Date())!
        return headaches.filter { $0.date >= start }
    }

    // Sample data for charts
    private func sampleData() -> [PainEntry] {
        var entries: [PainEntry] = []
        let calendar = Calendar.current
        let today = Date()

        for daysAgo in 0..<14 {
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: today)!

            if Bool.random() {
                entries.append(
                    PainEntry(
                        date: date,
                        intensity: Int.random(in: 3...9),
                        painType: .headache,
                        durationMinutes: Int.random(in: 30...240),
                        note: "Sample headache entry"
                    )
                )
            }

            let others: [PainType] = [.neck, .back, .fibromyalgia, .arthritis]
            if Bool.random() {
                entries.append(
                    PainEntry(
                        date: date,
                        intensity: Int.random(in: 1...6),
                        painType: others.randomElement()!,
                        durationMinutes: Int.random(in: 15...120),
                        note: "Sample other pain"
                    )
                )
            }
        }

        return entries
    }
}

// MARK: - Goals

struct Goal: Identifiable, Codable, Equatable {

    let id: UUID
    var title: String
    var detail: String
    var systemImage: String

    init(
        id: UUID = UUID(),
        title: String,
        detail: String,
        systemImage: String
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.systemImage = systemImage
    }
}

@MainActor
class GoalStore: ObservableObject {
    @Published var goals: [Goal] = [
        Goal(title: "15-minute walk", detail: "Light exercise helps reduce triggers", systemImage: "figure.walk"),
        Goal(title: "7 hours sleep", detail: "Good rest improves recovery", systemImage: "bed.double.fill"),
        Goal(title: "Hydration", detail: "Drink enough water", systemImage: "drop.fill")
    ]

    @Published var completedToday: Set<UUID> = []

    func addGoal(title: String, detail: String, systemImage: String) {
        let newGoal = Goal(
            title: title,
            detail: detail,
            systemImage: systemImage
        )
        goals.append(newGoal)
    }

    func toggle(_ goal: Goal) {
        if completedToday.contains(goal.id) {
            completedToday.remove(goal.id)
        } else {
            completedToday.insert(goal.id)
        }
    }

    func isCompleted(_ goal: Goal) -> Bool {
        completedToday.contains(goal.id)
    }
}
