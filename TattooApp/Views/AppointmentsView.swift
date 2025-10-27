import SwiftUI

struct AppointmentsView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showBookingSheet: Bool = false

    private var appointments: [Appointment] {
        guard let appointment = appState.activeAppointment else { return [] }
        return [appointment]
    }

    var body: some View {
        NavigationStack {
            Group {
                if appointments.isEmpty {
                    EmptyStateView(action: { showBookingSheet = true })
                } else {
                    List {
                        Section(header: Text("Anstehend")) {
                            ForEach(appointments) { appointment in
                                AppointmentRow(appointment: appointment)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Termine")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showBookingSheet = true }) {
                        Label("Buchen", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showBookingSheet) {
                BookingFlowView()
                    .presentationDetents([.medium, .large])
            }
        }
    }
}

private struct AppointmentRow: View {
    let appointment: Appointment

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
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
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
            }

            Label(appointment.status.rawValue, systemImage: "checkmark.seal")
                .font(.caption.weight(.semibold))
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(Color.accentColor.opacity(0.12))
                .clipShape(Capsule())

            VStack(alignment: .leading, spacing: 8) {
                Label("Dauer: \(appointment.durationInMinutes) min", systemImage: "clock")
                Label("Bereich: \(appointment.placement)", systemImage: "hand.raised")
            }
            .font(.footnote)
            .foregroundStyle(.secondary)

            Text(appointment.designNotes)
                .font(.body)
        }
        .padding(.vertical, 12)
    }
}

private struct EmptyStateView: View {
    let action: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 64))
                .foregroundStyle(.secondary)
            Text("Noch keine Termine")
                .font(.title3.bold())
            Text("Plane dein erstes Gespräch oder sichere dir einen Flash-Day Slot in wenigen Minuten.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button(action: action) {
                Text("Neuen Termin anlegen")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: 320)
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

private struct BookingFlowView: View {
    @State private var selectedStyle: TattooStyle? = .fineLine
    @State private var preferredDate: Date = .now.addingTimeInterval(86400 * 14)
    @State private var additionalNotes: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Stil") {
                    Picker("Tattoo-Stil", selection: $selectedStyle) {
                        ForEach(TattooStyle.allCases) { style in
                            Text(style.rawValue).tag(Optional(style))
                        }
                    }
                }

                Section("Datum & Zeit") {
                    DatePicker("Bevorzugtes Datum", selection: $preferredDate, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                }

                Section("Notizen") {
                    TextEditor(text: $additionalNotes)
                        .frame(minHeight: 120)
                }

                Section {
                    Button(action: {}) {
                        Text("Anfrage abschicken")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Termin planen")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Schließen") {
                        dismissKeyboard()
                    }
                }
            }
        }
    }

    private func dismissKeyboard() {
#if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
#endif
    }
}

struct AppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentsView()
            .environmentObject(AppState())
    }
}
