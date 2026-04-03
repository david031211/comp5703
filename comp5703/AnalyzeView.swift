import SwiftUI

struct AnalyzeView: View {
    @State private var inputText = ""
    @State private var resultTitle = "No analysis yet"
    @State private var resultColor: Color = .gray
    @State private var explanation = "Enter a suspicious message and tap Analyze."
    @State private var recommendation = "The system will provide a recommendation after analysis."
    @State private var isAnalyzing = false
    @State private var showResult = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Text Analysis")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Paste a suspicious message, email content, or link-related text below.")
                        .font(.title3)
                        .foregroundColor(.secondary)

                    TextEditor(text: $inputText)
                        .frame(minHeight: 220)
                        .padding(12)
                        .background(Color.gray.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                        )
                        .cornerRadius(16)

                    Button(action: analyzeText) {
                        HStack {
                            if isAnalyzing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }
                            Text(isAnalyzing ? "Analyzing..." : "Analyze Text")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isAnalyzing ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                    }
                    .disabled(isAnalyzing)

                    if showResult {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Result")
                                .font(.headline)

                            HStack {
                                Circle()
                                    .fill(resultColor)
                                    .frame(width: 12, height: 12)

                                Text(resultTitle)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(resultColor)
                            }

                            Divider()

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Explanation")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)

                                Text(explanation)
                                    .foregroundColor(.secondary)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Recommendation")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)

                                Text(recommendation)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(resultColor.opacity(0.35), lineWidth: 1)
                        )
                        .cornerRadius(16)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }

                    Spacer(minLength: 20)
                }
                .padding()
            }
            .navigationTitle("Text")
        }
    }

    private func analyzeText() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty {
            resultTitle = "No Input"
            resultColor = .gray
            explanation = "Please enter some text before analyzing."
            recommendation = "Paste a suspicious message, email, or link-related text to continue."
            showResult = true
            return
        }

        isAnalyzing = true
        showResult = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let lowercased = trimmed.lowercased()

            if lowercased.contains("verification code")
                || lowercased.contains("urgent")
                || lowercased.contains("transfer money")
                || lowercased.contains("bank account")
                || lowercased.contains("password")
                || lowercased.contains("click this link")
                || lowercased.contains("confirm your account") {

                resultTitle = "High Risk"
                resultColor = .red
                explanation = "The text contains multiple phishing or scam-related indicators, such as urgency, credential requests, or payment-related language."
                recommendation = "Do not click any links, do not share personal information, and verify the sender through an official channel."
            } else if lowercased.contains("login")
                        || lowercased.contains("account")
                        || lowercased.contains("security")
                        || lowercased.contains("update information") {

                resultTitle = "Medium Risk"
                resultColor = .orange
                explanation = "The text contains some suspicious account or security-related language, but the evidence is not strong enough to classify it as high risk."
                recommendation = "Review the message carefully and verify whether the request is legitimate before taking any action."
            } else {
                resultTitle = "Low Risk"
                resultColor = .green
                explanation = "No obvious phishing keywords or scam patterns were detected in the current text."
                recommendation = "The content appears relatively safe, but users should still remain cautious with unknown links or requests."
            }

            isAnalyzing = false

            withAnimation {
                showResult = true
            }
        }
    }
}

#Preview {
    AnalyzeView()
}
