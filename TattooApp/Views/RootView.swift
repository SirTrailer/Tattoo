import SwiftUI

struct RootView: View {
    enum Tab: String, CaseIterable {
        case home
        case discover
        case artists
        case appointments
        case profile

        var title: String {
            switch self {
            case .home: return "Home"
            case .discover: return "Entdecken"
            case .artists: return "Artists"
            case .appointments: return "Termine"
            case .profile: return "Profil"
            }
        }

        var systemImage: String {
            switch self {
            case .home: return "house.fill"
            case .discover: return "safari.fill"
            case .artists: return "person.3.fill"
            case .appointments: return "calendar"
            case .profile: return "person.crop.circle"
            }
        }
    }

    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            TabView(selection: $appState.selectedTab) {
                HomeView()
                    .tag(Tab.home)
                DiscoverView()
                    .tag(Tab.discover)
                ArtistsView()
                    .tag(Tab.artists)
                AppointmentsView()
                    .tag(Tab.appointments)
                ProfileView()
                    .tag(Tab.profile)
            }
            .tint(.accentColor)

            if appState.showOnboarding {
                OnboardingView()
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
            }
        }
    }
}

#if DEBUG
#Preview("Home") {
    RootView()
        .environmentObject(AppState.preview())
}

#Preview("Discover") {
    RootView()
        .environmentObject(AppState.preview(selectedTab: .discover))
}

#Preview("Onboarding") {
    RootView()
        .environmentObject(AppState.preview(showOnboarding: true))
}
#endif
