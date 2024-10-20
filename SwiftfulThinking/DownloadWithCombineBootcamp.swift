//
//  DownloadWithCombineBootcamp.swift
//  SwiftfulThinking
//
//  Created by Thành Trung on 20/10/24.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellable = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { completion in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellable)

    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombineBootcamp: View {
    @StateObject var viewModel = DownloadWithCombineViewModel()
    var body: some View {
        List {
            ForEach(viewModel.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.subheadline)
                    Text(post.body)
                        .foregroundStyle(Color(.systemGray4))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    DownloadWithCombineBootcamp()
}
