import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject private var appState: AppState
    @State private var searchText: String = ""

    private var filteredArtists: [Artist] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return Artist.samples.filter { artist in
            let matchesSearch = query.isEmpty || artist.name.lowercased().contains(query) || artist.styles.contains { $0.rawValue.lowercased().contains(query) }
            let matchesStyle = appState.discoveryFilters.selectedStyles.isEmpty || !appState.discoveryFilters.selectedStyles.isDisjoint(with: Set(artist.styles))
            let matchesRating = artist.rating >= appState.discoveryFilters.minRating
            let matchesFavorites = !appState.discoveryFilters.onlyFavorites || appState.favorites.contains(artist)
            return matchesSearch && matchesStyle && matchesRating && matchesFavorites
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    FilterSection(filters: $appState.discoveryFilters)
                    ForEach(filteredArtists) { artist in
                        NavigationLink(destination: ArtistDetailView(artist: artist)) {
                            ArtistCardView(artist: artist)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Suche nach Artists oder Stilen"))
            .navigationTitle("Entdecken")
        }
    }
}

private struct FilterSection: View {
    @Binding var filters: DiscoveryFilters

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Filter")
                .font(.title3.weight(.semibold))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(TattooStyle.allCases) { style in
                        FilterChip(isSelected: filters.selectedStyles.contains(style), title: style.rawValue, icon: style.iconName) {
                            if filters.selectedStyles.contains(style) {
                                filters.selectedStyles.remove(style)
                            } else {
                                filters.selectedStyles.insert(style)
                            }
                        }
                    }
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Mindestbewertung: \(String(format: "%.1f", filters.minRating))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Slider(value: Binding(
                    get: { filters.minRating },
                    set: { filters.minRating = max(3.0, $0) }
                ), in: 3.0...5.0, step: 0.1)
            }

            Toggle(isOn: $filters.onlyFavorites) {
                Label("Nur Favoriten zeigen", systemImage: "heart.fill")
            }
            .toggleStyle(.switch)
            .padding(.top, 4)
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

private struct FilterChip: View {
    let isSelected: Bool
    let title: String
    let icon: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.footnote)
                Text(title)
                    .font(.footnote.weight(.semibold))
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(isSelected ? Color.accentColor.opacity(0.16) : Color(.systemGray6))
            .foregroundStyle(isSelected ? Color.accentColor : .primary)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

private struct ArtistCardView: View {
    let artist: Artist

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RoundedRectangle(cornerRadius: 24)
                .fill(.thinMaterial)
                .frame(height: 200)
                .overlay(
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(artist.name)
                                    .font(.title3.weight(.semibold))
                                Text("\(artist.studio) · \(artist.location)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Label(String(format: "%.1f", artist.rating), systemImage: "star.fill")
                                .labelStyle(.titleAndIcon)
                                .font(.subheadline)
                                .foregroundStyle(Color.yellow)
                        }

                        Text(artist.bio)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .lineLimit(3)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(artist.styles) { style in
                                    Text(style.rawValue)
                                        .font(.caption.weight(.semibold))
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 10)
                                        .background(Color.accentColor.opacity(0.12))
                                        .foregroundStyle(Color.accentColor)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    .padding(20)
                )

            HStack {
                Label("Portfolio", systemImage: "photo.on.rectangle")
                Spacer()
                ForEach(artist.portfolio.prefix(3)) { item in
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 44, height: 44)
                        .overlay(Text(String(item.title.prefix(1))).font(.callout.weight(.bold)))
                }
                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.bold))
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                }
            }
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
        .padding(20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: Color.black.opacity(0.08), radius: 20, x: 0, y: 10)
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(AppState())
    }
}
