# YummyDate

![152](https://github.com/samroman3/YummyDate/assets/52180475/98082013-82b5-4048-8083-bb7af0a148b6)


YummyDate is a highly customizable SwiftUI date picker framework designed to make it easy to add stylish date selection functionality to iOS applications.

## Features
- 1.0.0:
- **Easy Integration**: Seamlessly integrates with SwiftUI applications.
- **Customizable Themes**: Includes predefined themes and supports custom themes.
- **Date Selection Manager**: Leverages `DateSelectionManager` for easy date management within your app.

## Getting Started

### Installation

To add YummyDate to your SwiftUI project, simply add it as a dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/YummyDate.git", .upToNextMajor(from: "1.0.0"))
]
```

Or add it via Xcode by selecting File > Swift Packages > Add Package Dependency and enter the package repository URL.

## Usage

Import YummyDate in the file you'd like to use it:
```swift
import YummyDate
```

Using DateSelectionManager
Initialize the DateSelectionManager and bind it to YummyDateBar and DateSelectorView:
```swift
@StateObject private var dateSelectionManager = DateSelectionManager()

YummyDateBar(selectionManager: dateSelectionManager,
             selectedDate: $dateSelectionManager.selectedDate,
             onDateTapped: { /* Your code here */ },
             onCalendarTapped: { /* Your code here */ },
             theme: .limeTheme)
```

## Themes
YummyDate comes with three built-in themes: sunsetTheme, limeTheme, and oceanTheme.
![IMG_1630](https://github.com/samroman3/YummyDate/assets/52180475/ee392355-65f9-4a0d-a941-c45684322609)

![IMG_1629](https://github.com/samroman3/YummyDate/assets/52180475/0d82cef8-6eba-40e1-90ef-a2ac9bf852de) 

![IMG_1628](https://github.com/samroman3/YummyDate/assets/52180475/abdc9027-371f-4d58-af22-221c4bb6ee36)

Creating custom themes:
```swift
let customTheme = YummyTheme(primaryColor: .blue,
                             secondaryColor: .gray,
                             tertiaryColor: .white,
                             primaryTextColor: .white,
                             secondaryTextColor: .black,
                             primaryFont: .title,
                             secondaryFont: .body,
                             barAlignment: .center,
                             animation: .default,
                             scrollBehavior: .staticScroll)

//Note: only .staticScroll is available at the moment
```
Using theme in YummyDateBar:
```swift
YummyDateBar(selectionManager: dateSelectionManager,
             selectedDate: $dateSelectionManager.selectedDate,
             theme: customTheme)
```
## Sample Application
To see YummyDate in action, check out the YummyDateSampleApp included in this package.
Make sure to switch the target and build on a compatible (iOS) device or simulator.
## Future versions:
- More customization: custom scroll behavior, custom behavior for all components (Text, Icons, DateButtons)
- Use DateSelectorView without YummyDateBar
- Custom DateBar styles
- Expanded calendar methods
- DateSelectionManager protocol

## Contributing

Contributions to YummyDate are welcome! If you have any suggestions or run into issues with YummyDate feel free to open a pull request or create an issue. 
