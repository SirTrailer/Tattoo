import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    HeroSection(appointment: appState.activeAppointment)
                    MoodBoardSection()
                    HighlightArtistsSection(artists: appState.favorites)
                    TipsSection()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .background(GradientBackground())
            .navigationTitle("Tattoo Studio")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color(.systemBackground), for: .navigationBar)
        }
    }
}

private struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            colors: [Color(.systemGray6), Color(.systemBackground)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

private struct HeroSection: View {
    let appointment: Appointment?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Dein nächster Termin")
                .font(.title3.weight(.semibold))

            if let appointment {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top, spacing: 16) {
                        Circle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 56, height: 56)
                            .overlay(Image(systemName: "sun.max.fill").font(.title2))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(appointment.artist.name)
                                .font(.headline)
                            Text(appointment.artist.studio)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(appointment.date, style: .date)
                            Text(appointment.date, style: .time)
                                .foregroundStyle(.secondary)
                        }
                        .font(.footnote)
                    }

                    HStack {
                        Label("Dauer: \(appointment.durationInMinutes) min", systemImage: "clock")
                        Spacer()
                        Label(appointment.status.rawValue, systemImage: "checkmark.seal")
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                    Text(appointment.designNotes)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                        .fixedSize(horizontal: false, vertical: true)

                    Divider()

                    HStack {
                        Label(appointment.placement, systemImage: "hand.raised.fill")
                        Spacer()
                        Button("Details ansehen") {}
                            .font(.footnote.weight(.semibold))
                    }
                }
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(LinearGradient(colors: [.clear, Color.accentColor.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                )
            } else {
                RoundedRectangle(cornerRadius: 28)
                    .fill(.ultraThinMaterial)
                    .frame(height: 160)
                    .overlay(
                        VStack(spacing: 12) {
                            Text("Noch kein Termin geplant")
                                .font(.headline)
                            Button("Jetzt entdecken") {}
                        }
                    )
            }
        }
    }
}

private struct MoodBoardSection: View {
    let moods: [Mood] = [
        Mood(title: "Architektur", subtitle: "Präzise Linien & Formen", color: .indigo, icon: "building.columns"),
        Mood(title: "Natur", subtitle: "Botanische Details", color: .green, icon: "leaf.fill"),
        Mood(title: "Kosmos", subtitle: "Galaktische Nuancen", color: .purple, icon: "moon.stars.fill")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Moodboards")
                .font(.title3.weight(.semibold))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(moods) { mood in
                        VStack(alignment: .leading, spacing: 12) {
                            Image(systemName: mood.icon)
                                .font(.title2)
                                .padding(16)
                                .background(.thinMaterial)
                                .clipShape(Circle())
                            Text(mood.title)
                                .font(.headline)
                            Text(mood.subtitle)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                        .padding(20)
                        .frame(width: 200, alignment: .leading)
                        .background(mood.color.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                }
            }
        }
    }

    struct Mood: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        let color: Color
        let icon: String
    }
}

private struct HighlightArtistsSection: View {
    let artists: [Artist]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Deine Favoriten")
                    .font(.title3.weight(.semibold))
                Spacer()
                Button("Alle anzeigen") {}
                    .font(.footnote.weight(.medium))
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(artists) { artist in
                        VStack(alignment: .leading, spacing: 12) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.thinMaterial)
                                .frame(width: 220, height: 140)
                                .overlay(
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(artist.name)
                                            .font(.headline)
                                        Text(artist.styles.map(\.rawValue).joined(separator: ", "))
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        HStack {
                                            Label(String(format: "%.1f", artist.rating), systemImage: "star.fill")
                                            Spacer()
                                            Button(action: {}) {
                                                Image(systemName: "heart.fill")
                                            }
                                        }
                                        .font(.footnote)
                                    }
                                    .padding()
                                )
                            Text(artist.bio)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .frame(width: 220, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
}

private struct TipsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Studio Guide")
                .font(.title3.weight(.semibold))
            VStack(alignment: .leading, spacing: 12) {
                GuideRow(title: "Pflege Checkliste", description: "Vor- und Nachbereitung für frische Tattoos.", icon: "checklist")
                Divider()
                GuideRow(title: "Aftercare Playlist", description: "Beruhigende Sounds für die Heilungszeit.", icon: "music.note")
                Divider()
                GuideRow(title: "Community Events", description: "Flash-Days & Workshops in deiner Nähe.", icon: "sparkle")
            }
            .padding(20)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }

    private struct GuideRow: View {
        let title: String
        let description: String
        let icon: String

        var body: some View {
            HStack(alignment: .top, spacing: 16) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.accent)
                    .frame(width: 32, height: 32)
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                    Text(description)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppState())
    }
}
