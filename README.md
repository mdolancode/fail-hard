# Fail Hard

A SwiftUI iOS workout logging app built for myself — because I go to the gym and wanted a simple, no-nonsense way to track my sessions by date.

Never published — built to explore SwiftUI, Core Data persistence, and calendar-based UI patterns.

---

## Why Fail Hard Exists

Most workout apps overwhelm you with features. Fail Hard strips it back to the essentials: pick a date, log what you did, see your history at a glance. The calendar view makes it immediately obvious which days you showed up and which days you didn't. That visibility is the motivation.

---

## Core Features

- Calendar grid showing the current month with workout indicators (green dots on active days)
- Tap any day with a logged workout to view that day's sessions
- Log a new workout for any selected date
- Edit or delete existing workouts
- Navigate forward and backward between months
- Celebration sound plays on successful workout save (with fallback audio handling)
- Volume slider for adjusting celebration sound
- Input validation prevents empty workout names

---

## Technical Highlights

- **Core Data** with a singleton `CoreDataManager` for persistent local storage across sessions
- **`@FetchRequest`** with sort descriptors for reactive, automatically updating workout lists
- **`@Environment(\.managedObjectContext)`** passed through the SwiftUI view hierarchy
- **Calendar date math** — dynamic month generation, day-of-week alignment, and cross-day date comparison using `Calendar.isDate(_:inSameDayAs:)`
- **`LazyVGrid`** for the calendar layout with 7 equal columns
- **AVFoundation** for audio playback with primary and fallback sound handling
- **`NavigationLink`** to edit view with swipe-to-delete on workout list
- **Sheet presentation** for the workout list modal on date selection
- Clean component separation: `CalendarView`, `CalendarGridView`, `WorkoutListView`, `WorkoutLoggingView`, `EditWorkoutView`, `HeaderView`

---

## App Flow

1. Calendar grid loads showing current month
2. Days with logged workouts are highlighted in green
3. Tap a day with workouts to view that day's sessions in a modal sheet
4. Log a new workout for any date — validation prevents empty entries
5. On save, a celebration sound plays and the view dismisses after a short delay
6. Swipe left on any workout to delete it
7. Tap any workout to open the edit view

---

## Tech Stack

- Swift
- SwiftUI
- Core Data
- AVFoundation
- MVVM-inspired architecture

---

## Running Locally

Clone the repo and open the `.xcodeproj` in Xcode. No third-party dependencies. Build and run on simulator or device.

---

## Known Gaps (Intentional)

- No workout categories or exercise sets/reps tracking
- No iCloud sync
- No notifications or reminders
- UI polish incomplete — not submitted to the App Store

These would be the natural next steps toward a production release.
