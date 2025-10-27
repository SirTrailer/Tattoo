import SwiftUI

struct ProfileView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var vibrancyEnabled: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Account")) {
                    HStack(spacing: 16) {
                        Circle()
                            .fill(Color.accentColor.opacity(0.2))
                            .frame(width: 64, height: 64)
                            .overlay(Text("LS").font(.title2.weight(.bold)))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Lina Sommer")
                                .font(.headline)
                            Text("Premium Mitglied")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Section(header: Text("Benachrichtigungen")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Push Updates", systemImage: "bell.badge.fill")
                    }
                    Toggle(isOn: $vibrancyEnabled) {
                        Label("Vibrancy Alerts", systemImage: "sparkles")
                    }
                }

                Section(header: Text("Inspiration")) {
                    NavigationLink(destination: Text("Favoriten")) {
                        Label("Favorisierte Motive", systemImage: "heart.text.square")
                    }
                    NavigationLink(destination: Text("Moodboards")) {
                        Label("Moodboards", systemImage: "rectangle.on.rectangle.angled")
                    }
                }

                Section(header: Text("Support")) {
                    NavigationLink(destination: Text("FAQ")) {
                        Label("Hilfe & FAQ", systemImage: "questionmark.circle")
                    }
                    NavigationLink(destination: Text("Kontakt")) {
                        Label("Concierge Service", systemImage: "person.crop.circle.badge.questionmark")
                    }
                }

                Section {
                    Button(role: .destructive) {
                        // Logout Action
                    } label: {
                        Text("Abmelden")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Profil")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
