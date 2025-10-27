import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var appState: AppState
    @State private var stepIndex: Int = 0

    private let steps: [OnboardingStep] = [
        OnboardingStep(title: "Finde deinen Stil", description: "Durchstöbere kuratierte Sammlungen und entdecke neue Tattoo-Trends, zugeschnitten auf deine Vorlieben.", systemImage: "sparkles"),
        OnboardingStep(title: "Lerne Artists kennen", description: "Sieh dir Portfolios, Bewertungen und Studio-Atmosphären an, bevor du deinen nächsten Termin buchst.", systemImage: "person.3.sequence"),
        OnboardingStep(title: "Plane smart", description: "Koordiniere Vorgespräche, Skizzenfreigaben und Sitzungen nahtlos in einer App.", systemImage: "calendar.badge.clock")
    ]

    var body: some View {
        VStack(spacing: 32) {
            Capsule()
                .fill(.secondary)
                .frame(width: 44, height: 4)
                .padding(.top, 12)

            TabView(selection: $stepIndex) {
                ForEach(steps.indices, id: \.self) { index in
                    VStack(spacing: 20) {
                        Image(systemName: steps[index].systemImage)
                            .font(.system(size: 48, weight: .bold))
                            .foregroundStyle(.primary)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 28))

                        VStack(spacing: 12) {
                            Text(steps[index].title)
                                .font(.title2.bold())
                            Text(steps[index].description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.horizontal, 32)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 320)

            Button(action: advance) {
                Text(stepIndex == steps.count - 1 ? "Los geht's" : "Weiter")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
        }
        .padding(.bottom, 12)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .padding(.horizontal)
        .padding(.bottom, 32)
    }

    private func advance() {
        if stepIndex < steps.count - 1 {
            withAnimation(.spring()) { stepIndex += 1 }
        } else {
            withAnimation(.easeInOut) {
                appState.showOnboarding = false
            }
        }
    }
}

private struct OnboardingStep: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let systemImage: String
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(AppState())
            .background(LinearGradient(colors: [.black, .gray], startPoint: .top, endPoint: .bottom))
    }
}
