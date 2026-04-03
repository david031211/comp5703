import SwiftUI
import UniformTypeIdentifiers

struct AudioUploadView: View {
    @State private var selectedFileName = "No audio file selected"
    @State private var transcript = "Transcript will appear here."
    @State private var riskResult = "No analysis yet"
    @State private var riskColor: Color = .gray
    @State private var showImporter = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Audio Analysis")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Upload an audio file and convert it to text for phishing detection.")
                        .foregroundColor(.secondary)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Selected File")
                            .font(.headline)
                        Text(selectedFileName)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(14)

                    Button(action: {
                        showImporter = true
                    }) {
                        Text("Upload Audio File")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Button(action: analyzeAudioMock) {
                        Text("Convert and Analyze")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Transcript")
                            .font(.headline)

                        Text(transcript)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(14)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Risk Result")
                            .font(.headline)

                        Text(riskResult)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(riskColor)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(14)
                }
                .padding()
            }
            .navigationTitle("Audio")
            .fileImporter(
                isPresented: $showImporter,
                allowedContentTypes: [.audio],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let files):
                    if let file = files.first {
                        selectedFileName = file.lastPathComponent
                    }
                case .failure:
                    selectedFileName = "Failed to import file"
                }
            }
        }
    }

    private func analyzeAudioMock() {
        guard selectedFileName != "No audio file selected" else {
            transcript = "Please upload an audio file first."
            riskResult = "No File"
            riskColor = .gray
            return
        }

        transcript = "This is a mock transcript: Please transfer money urgently and do not tell anyone."
        riskResult = "High Risk"
        riskColor = .red
    }
}

#Preview {
    AudioUploadView()
}
