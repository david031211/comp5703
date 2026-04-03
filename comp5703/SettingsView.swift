import SwiftUI

struct SettingsView: View {
    @State private var enableAutoAnalysis = true
    @State private var privacyMode = true
    @State private var cloudAnalysis = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Detection")) {
                    Toggle("Enable Auto Analysis", isOn: $enableAutoAnalysis)
                    Toggle("Privacy First Mode", isOn: $privacyMode)
                    Toggle("Enable Cloud Analysis", isOn: $cloudAnalysis)
                }

                Section(header: Text("About")) {
                    Text("Phishing Guard")
                    Text("iOS Prototype for Text, Audio, and Video Scam Detection")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
