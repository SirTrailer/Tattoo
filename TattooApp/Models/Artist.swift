import Foundation
import SwiftUI

struct Artist: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let studio: String
    let location: String
    let rating: Double
    let styles: [TattooStyle]
    let bio: String
    let heroImageName: String
    let portfolio: [PortfolioItem]

    static let samples: [Artist] = [
        Artist(
            name: "Mira Sol",
            studio: "Sol Ink Collective",
            location: "Berlin, Germany",
            rating: 4.9,
            styles: [.fineLine, .geometric, .minimalist],
            bio: "Mira kombiniert zarte Linien mit leuchtenden Akzenten, inspiriert von Architektur und Natur.",
            heroImageName: "mira-sol",
            portfolio: PortfolioItem.samples
        ),
        Artist(
            name: "Leo Varga",
            studio: "Nordic Shade",
            location: "Hamburg, Germany",
            rating: 4.8,
            styles: [.blackwork, .illustrative, .dotwork],
            bio: "Leo vereint organische Schattierungen mit kühnen, grafischen Elementen.",
            heroImageName: "leo-varga",
            portfolio: Array(PortfolioItem.samples.reversed())
        )
    ]
}

struct PortfolioItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String

    static let samples: [PortfolioItem] = [
        PortfolioItem(title: "Celestial Lines", imageName: "portfolio-celestial", description: "Filigrane Linienarbeit kombiniert mit Goldfolien-Highlights."),
        PortfolioItem(title: "Northern Flora", imageName: "portfolio-flora", description: "Detailreiche Blumenillustration in monochromem Finish."),
        PortfolioItem(title: "Sacred Geometry", imageName: "portfolio-geometry", description: "Symmetrische Formen mit subtilen Dotwork-Verläufen."),
        PortfolioItem(title: "Lunar Phases", imageName: "portfolio-lunar", description: "Minimalistische Mondphasen mit Aquarellstruktur.")
    ]
}
