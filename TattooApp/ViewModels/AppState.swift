import Foundation
import SwiftUI

final class AppState: ObservableObject {
    @Published var selectedTab: RootView.Tab = .home
    @Published var showOnboarding: Bool = true
    @Published var activeAppointment: Appointment? = Appointment.sample
    @Published var favorites: [Artist] = Artist.samples
    @Published var discoveryFilters = DiscoveryFilters()
}

#if DEBUG
extension AppState {
    static func preview(
        selectedTab: RootView.Tab = .home,
        showOnboarding: Bool = false
    ) -> AppState {
        let state = AppState()
        state.selectedTab = selectedTab
        state.showOnboarding = showOnboarding
        return state
    }
}
#endif
