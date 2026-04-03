import SwiftUI

struct HistoryView: View {
    let historyItems = [
        "Text Analysis - High Risk",
        "Audio Analysis - Low Risk",
        "Video Analysis - High Risk"
    ]

    var body: some View {
        NavigationStack {
            List(historyItems, id: \.self) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item)
                        .fontWeight(.medium)
                    Text("Saved analysis record")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryView()
}
