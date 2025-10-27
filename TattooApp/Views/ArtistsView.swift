import SwiftUI

struct ArtistsView: View {
    let artists: [Artist] = Artist.samples

    var body: some View {
        NavigationStack {
            List(artists) { artist in
                NavigationLink(destination: ArtistDetailView(artist: artist)) {
                    ArtistRow(artist: artist)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Artists")
        }
    }
}

private struct ArtistRow: View {
    let artist: Artist

    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(Color.accentColor.opacity(0.2))
                .frame(width: 54, height: 54)
                .overlay(Text(artist.name.prefix(2)).font(.headline))
            VStack(alignment: .leading, spacing: 6) {
                Text(artist.name)
                    .font(.headline)
                Text(artist.styles.map(\.rawValue).joined(separator: ", "))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Label(String(format: "%.1f", artist.rating), systemImage: "star.fill")
                .labelStyle(.titleAndIcon)
                .font(.caption)
                .foregroundStyle(.yellow)
        }
        .padding(.vertical, 8)
    }
}

struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistsView()
    }
}
