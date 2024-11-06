# Tech Stack:

The project implement the MVVM architecture and SwiftUI framework.

# Navigation

A custom router was implemented to handle navigation, effectively decoupling the navigation logic from the views.

# Favourites:

To bookmark countries, I utilized UserDefaults and created a manager to load saved countries when the application launches. This manager also manages adding or removing items from the favourites list.

# Networking:

I implemented a simple networking client using URLSession to fetch information from a Gist.

# ViewModel

I used a single ViewModel, created at app launch and injected into the views using @EnvironmentObject.

# Filter

I used the new .searchable modifier to filter the list of countries, which shows a native search bar. Additionally, I applied the .onChange modifier, listening to a property in the ViewModel to filter as the user types.

I utilized a higher-order function to make the filter case-insensitive by using a .lowercased() comparison:

```
allCountries?.filter { $0.name.lowercased().hasPrefix(prompt.lowercased()) }
```


# Views

On the main screen, I created a control group that allows users to toggle between viewing all countries or just their favorites. I used List for displaying countries due to its performance benefits.

For landscape mode, I leveraged the native capabilities of NavigationView to display both the list and the map side-by-side. This secondary view feature is only available on Plus and Max devices, so the default navigation experience remains unchanged for other devices.

The second screen is straightforward. I imported MapKit to display maps within the app and created a binding between the ViewModel and the map. This binding enables the map to update coordinates as users select different cities.

Lastly, I organized the project by creating a separate file for the card views used across the app and another file for the country data.
