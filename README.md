# EndlessNavigation
Practice for navigation controller

# Points
- Embed in navigation controller
- Add show seque to button
- animateWithDuration
- Use UILayoutGuide to center subview
- Add right bar button item with storyboard

## Add Swipe gesture recognizer to 'show' seque without editing code
1. Drag and drop Swipe Gesture Recognizer in Object Libaray pane to view in storyboard. Swipe Gesture Recognizer should be added to scene dock.
2. Change swipe direction in attributes inspector.
3. Ctrl+drag and drop Swipe Gesture Recognizer in scene dock to view controller and select 'show seque'.
4. Build, run and test.

## Presents table view by long press gesture
1. Add long press guesture recognizer to button in IB
2. Add action to long press gesture recognizer
3. Transfer data to destination view controller by prepareForSeque()


