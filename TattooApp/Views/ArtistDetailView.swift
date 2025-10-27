import SwiftUI

struct ArtistDetailView: View {
    let artist: Artist
    @State private var selectedSegment: Segment = .about

    enum Segment: String, CaseIterable, Identifiable {
        case about = "Über"
        case portfolio = "Portfolio"
        case reviews = "Reviews"

        var id: String { rawValue }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HeaderView(artist: artist)
                Picker("Segment", selection: $selectedSegment) {
                    ForEach(Segment.allCases) { segment in
                        Text(segment.rawValue).tag(segment)
                    }
                }
                .pickerStyle(.segmented)

                switch selectedSegment {
                case .about:
                    AboutSection(artist: artist)
                case .portfolio:
                    PortfolioSection(items: artist.portfolio)
                case .reviews:
                    ReviewsSection()
                }
            }
            .padding(20)
        }
        .navigationTitle(artist.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct HeaderView: View {
    let artist: Artist

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            RoundedRectangle(cornerRadius: 28)
                .fill(.thinMaterial)
                .frame(height: 220)
                .overlay(
                    VStack(alignment: .leading, spacing: 12) {
                        Spacer()
                        Text(artist.name)
                            .font(.largeTitle.bold())
                        Text("\(artist.studio) · \(artist.location)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(24)
                )

            HStack(spacing: 16) {
                RatingBadge(value: artist.rating)
                Divider()
                    .frame(height: 24)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(artist.styles) { style in
                            Label(style.rawValue, systemImage: style.iconName)
                                .labelStyle(.titleAndIcon)
                                .font(.caption.weight(.semibold))
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                                .background(Color.accentColor.opacity(0.1))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
        }
    }
}

private struct AboutSection: View {
    let artist: Artist

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Über die Artist")
                .font(.title3.weight(.semibold))
            Text(artist.bio)
                .font(.body)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 12) {
                Label("Studio: \(artist.studio)", systemImage: "building.2")
                Label("Standort: \(artist.location)", systemImage: "mappin.and.ellipse")
                Label("Antwortzeit · 24h", systemImage: "bolt.badge.clock")
            }
            .font(.footnote)
            .foregroundStyle(.secondary)

            Button(action: {}) {
                Label("Anfrage senden", systemImage: "paperplane.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
    }
}

private struct PortfolioSection: View {
    let items: [PortfolioItem]

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(items) { item in
                VStack(alignment: .leading, spacing: 10) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.thinMaterial)
                        .frame(height: 160)
                        .overlay(Text(item.title.prefix(1)).font(.largeTitle.bold()))
                    Text(item.title)
                        .font(.headline)
                    Text(item.description)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                .padding(16)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 24))
            }
        }
    }
}

private struct ReviewsSection: View {
    let reviews: [Review] = Review.samples

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(reviews) { review in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(review.author)
                            .font(.headline)
                        Spacer()
                        RatingBadge(value: review.rating)
                    }
                    Text(review.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text(review.comment)
                        .font(.body)
                    Divider()
                }
            }
        }
    }
}

private struct RatingBadge: View {
    let value: Double

    var body: some View {
        Label(String(format: "%.1f", value), systemImage: "star.fill")
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(Color.yellow.opacity(0.16))
            .foregroundStyle(.yellow)
            .clipShape(Capsule())
    }
}

private struct Review: Identifiable {
    let id = UUID()
    let author: String
    let rating: Double
    let comment: String
    let date: Date

    static let samples: [Review] = [
        Review(author: "Svenja", rating: 5.0, comment: "Mira hat meine Vorstellung perfekt umgesetzt. Die Linien sind so präzise!", date: .now.addingTimeInterval(-86400 * 12)),
        Review(author: "Armin", rating: 4.8, comment: "Tolles Studio, sehr freundliche Atmosphäre und professionelle Beratung.", date: .now.addingTimeInterval(-86400 * 35)),
        Review(author: "Katya", rating: 4.9, comment: "Wahnsinns Detailarbeit, ich komme definitiv wieder!", date: .now.addingTimeInterval(-86400 * 54))
    ]
}

struct ArtistDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ArtistDetailView(artist: Artist.samples.first!)
        }
    }
}
