# Learning Journey

Learning Journey is a SwiftUI app that helps you build a daily learning habit. Set a goal, log each day as learned (or freeze a day when you need a break), and track your progress in a calendar.

## Main features

- **Set a goal:** choose what you want to learn and for how long (Week, Month, or Year).
- **Log every day:** tap *Log as Learned*, or *Freeze for a day* if you can't study.
- **Change your mind:** today can be switched between learned and frozen.
- **Week strip:** this week at a glance. Learned days are orange, frozen days are blue.
- **Counters:** how many days you learned and how many you froze.
- **Calendar:** a view-only history of all your previous days.
- **Goal result:** when the goal ends, the app tells you whether you completed it.
- **Edit your goal:** change the topic or the length at any time (your counters start over).
- **Saved on your device:** close the app and come back to the same goal.

## Screenshots

| Set a goal | Activity |
|---|---|
| ![Set a goal](Screenshots/start-learning.png) | ![Activity](Screenshots/activity.png) |

## How a goal works

| | Week | Month | Year |
|---|---|---|---|
| Length | 7 days | 30 days | 365 days |
| Freezes allowed | 2 | 8 | 96 |

- The goal starts the day you press *Start Learning* and ends at midnight after its last day.
- The goal is **completed** if every day was either learned or frozen. If any day was missed, the app shows that you didn't reach it.
- The log and freeze buttons become available again at 12 AM each day.
- Updating the goal restarts the counters and the freeze limit.

## Technologies used

- SwiftUI and the `@Observable` macro (iOS 17 or later)
- **MVVM:** models hold the data, views only display it, and view models hold the logic
- `Codable` and `UserDefaults` for saving (`GoalStore`)
- An app icon made with Icon Composer

## Project structure

```
Learning/
├── MyApp.swift     App entry. Opens the saved goal, or the first screen
├── Model/          Data: DayEntry, Duration, GoalResult, SavedGoal, calendar types
├── View/           Screens and shared pieces (DayCircle, TopicField, DurationPicker)
└── ViewModel/      The logic for each screen
```

| Screen | View | View model |
|---|---|---|
| First screen (set a goal) | `Learning` | `LearningGoal` |
| Activity | `LogInDay` | `StartLG` |
| Edit goal | `EditGoalView` | `EditGoal` |
| Calendar | `ActivitiesView` | `Activities` |

## Run it

1. Open the project in Xcode (`Learning.xcodeproj`).
2. Pick an iPhone simulator and press **Cmd + R**.
3. To see the first screen again, delete the app from the simulator first. That also deletes the saved goal.

## Ideas for later

- A streak badge for consecutive days

---

Made by Shahad Almashjari while learning SwiftUI and MVVM.
