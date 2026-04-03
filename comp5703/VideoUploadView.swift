import SwiftUI
import UniformTypeIdentifiers

struct VideoUploadView: View {
    @State private var selectedFileName = "No video file selected"
    @State private var extractedSummary = "Video analysis result will appear here."
    @State private var riskResult = "No analysis yet"
    @State private var riskColor: Color = .gray
    @State private var showImporter = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Video Analysis")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Upload a video file for phishing detection using audio and on-screen text analysis.")
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
                        Text("Upload Video File")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    Button(action: analyzeVideoMock) {
                        Text("Analyze Video")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Analysis Summary")
                            .font(.headline)

                        Text(extractedSummary)
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
            .navigationTitle("Video")
            .fileImporter(
                isPresented: $showImporter,
                allowedContentTypes: [.movie],
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

    private func analyzeVideoMock() {
        guard selectedFileName != "No video file selected" else {
            extractedSummary = "Please upload a video file first."
            riskResult = "No File"
            riskColor = .gray
            return
        }

        extractedSummary = "Mock result: suspicious payment request and a phishing link were detected in the uploaded video."
        riskResult = "High Risk"
        riskColor = .red
    }
}

#Preview {
    VideoUploadView()
}
