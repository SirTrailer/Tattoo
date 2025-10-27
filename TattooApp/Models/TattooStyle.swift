import Foundation
import SwiftUI

enum TattooStyle: String, CaseIterable, Identifiable {
    case fineLine = "Fine Line"
    case geometric = "Geometric"
    case minimalist = "Minimalist"
    case blackwork = "Blackwork"
    case illustrative = "Illustrative"
    case dotwork = "Dotwork"
    case watercolor = "Watercolor"
    case realism = "Realism"

    var id: String { rawValue }
    var iconName: String {
        switch self {
        case .fineLine: return "pencil"
        case .geometric: return "triangle"
        case .minimalist: return "circle"
        case .blackwork: return "drop.fill"
        case .illustrative: return "paintbrush"
        case .dotwork: return "circle.grid.hex"
        case .watercolor: return "paintpalette"
        case .realism: return "camera"
        }
    }
}

struct DiscoveryFilters {
    var selectedStyles: Set<TattooStyle> = []
    var minRating: Double = 4.0
    var onlyFavorites: Bool = false
}
