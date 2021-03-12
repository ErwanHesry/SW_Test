# Swapcard iOS Developer Technical Test
**Submited by Erwan Hesry**

This is the repository for my submission of the iOS Developer Technical Test. It includes the necessary files to build and run the project on another Mac.

As there is no limitation, it uses the latest iOS version as target deployment (iOS 14.4) and can be used with Catalyst on MacOS (11.0 minimum). The Xcode version used is the 12.4 (12D4e) one. 

## Estimated time elapsed
Day 1 - 10/03:
- creating the base structure (folders and files) and UI (ViewController with simple label)
- testing GraphQL endpoint

Time spent: 1h

Day 2 - 11/03:
- implementing coordinators / viewModels / view for the Search scene

Time spent: 2h

Day 3 - 12/03:
- implementing coordinators / viewModels / view for the Bookmarks scene
- implementing coordinators / viewModels / view for the Artist scene
- documentation

Time spent: 2h

Total estimated time: 5h

## Available features
- Search for artists
- Infinite scroll in the search list
- Add/remove bookmark from search list (swipe left on artist) and from artist detail view
- Remove bookmark from the bookmarks list
- Artist detail view (basic view that shows artists basic informations)

## GraphQL server URL & UserDefaults storage key
Both values can be found in the user-defined variables in the project Build Settings. The goal of using user-defined variables for these informations is for an easier environment management. UserDefaults are used to store bookmarks locally.

## Architecture
The project uses a MVVM-C architecture with an AppCoordinator as a base coordinator.

The AppCoordinator is responsible to create the necessary service that the child coordinators (included in scenes) will use.

### Service
One services is available into the project:
- NetworkService

The NetworkService is responsible of the network part: with the given GraphQL server Url, it performs queries calls.

### Scenes
Three scenes are declared:
- SearchScene
- BookmarkScene
- ArtistScene

Each scene uses its own view model, user interface and coordinators.


## Assets
For strings, the standard localizable strings are used. Currently, the application is only in English.
The icons showed in the tab bar / navigation bar are the system ones based on Sf Symbols.

## Notice
The provided source code limits the application footprint on both storage, memory and network.

### Memory
While creating the application, Memory leaks tests have been done with Instruments. A screenshot of one of the latests is provided inside the repository (file: MemoryLeakProfile) and shows no memory leak inside this small application. The test to get this result was : 
- launch the application
- search for an artist
- select one artist
- go back
- select the bookmarks tab
- select one artist
- go back
- select the search tab
Between each action, I wait for the green checkmark of no memory leak in Instruments. The iOS Simulator has been used to perform the test.

### Network
The network calls are based on the Apollo GraphQL library. However, to improve the app efficiency and avoid impossible calls, the NetworkService uses the NWPathMonitor that iOS provided to detect if the network is available or not or limited (if the device uses another iOS or MacOS hotspot to obtain Internet access).

### Libs
No other libraries than the one provided inside the template had been use to make this test. Only Utils had been added which consist of 2 classes I usally use (the ViewModel one is customized for the test) and an extension to get localized strings. 
