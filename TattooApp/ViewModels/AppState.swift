import Foundation
import SwiftUI

final class AppState: ObservableObject {
    @Published var selectedTab: RootView.Tab = .home
    @Published var showOnboarding: Bool = true
    @Published var activeAppointment: Appointment? = Appointment.sample
    @Published var favorites: [Artist] = Artist.samples
    @Published var discoveryFilters = DiscoveryFilters()
}
