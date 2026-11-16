import SwiftUI

@main
struct LearningApp: App {
    @State private var savedGoal = GoalStore().load()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let savedGoal {
                                    LogInDay(saved: savedGoal)
                                }
                else {
                    Learning()
                }
            }
        }
    }
}
