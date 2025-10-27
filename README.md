# Tattoo iOS App

Eine vollständig designte SwiftUI-App, die ein hochwertiges mobiles Erlebnis für Tattoo-Enthusiast:innen bietet. Die Anwendung beinhaltet Start-, Entdecken-, Artists-, Termin- und Profilbereiche sowie ein detailreiches Onboarding.

## Projektüberblick
- **Technologie**: Swift 5.9+, SwiftUI, NavigationStack, ObservableObject
- **Features**:
  - Onboarding mit erklärenden Slides
  - Dashboard mit Terminübersicht, Moodboards, Favoriten und Studio-Guides
  - Entdecken-Bereich mit Suche, Filtern und Artist-Detailseiten
  - Terminverwaltung mit Buchungs-Flow und leeren Zuständen
  - Profilbereich mit Einstellungen und Support-Links

## Struktur
```
TattooApp/
├── Models/
├── ViewModels/
├── Views/
└── Resources/
```

Jeder Bereich ist modular aufgebaut, um eine spätere Erweiterung (z. B. Networking oder Persistenz) zu erleichtern. Die Assets sind als Platzhalter vorgesehen und können in Xcode ergänzt werden.
