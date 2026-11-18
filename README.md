# Learning Journey

Learning Journey is a SwiftUI app that helps you build a daily learning habit. Set a goal, log each day as learned (or freeze a day when you need a break), and track your progress in a calendar.

![Learning Journey mockup](Screenshots/mockup.png)

## Main features

- **Set a goal:** choose what you want to learn and for how long (Week, Month, or Year).
- **Log every day:** tap *Log as Learned*, or *Freeze for a day* if you can't study.
- **Change your mind:** today can be switched between learned and frozen.
- **Streak badge:** shows how many days in a row you have logged or frozen. The streak starts over if you go more than 32 hours without logging, or when you change your goal.
- **Freeze limit:** 2 freezes for a Week goal, 8 for a Month goal, and 96 for a Year goal.
- **Week strip:** this week at a glance. Learned days are orange, frozen days are blue.
- **Counters:** how many days you learned and how many you froze.
- **Calendar:** a view-only history of all your previous days.
- **Goal result:** when the goal ends, the app tells you whether you completed it. Learned and frozen days both count, so you complete the goal if you didn't miss a day.
- **Edit your goal:** change the topic or the length at any time (your counters and streak start over).
- **Saved on your device:** close the app and come back to the same goal.

## Technologies used

- SwiftUI and the `@Observable` macro (iOS 27)
- **MVVM:** models hold the data, views only display it, and view models hold the logic
- `Codable` and `UserDefaults` for saving (`GoalStore`)
- An app icon made with Icon Composer (light, dark and tinted)