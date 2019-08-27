//
//  CommentViewModel.swift
//  CombineDecode
//
//  Created by Harry Patsis on 24/8/19.
//  Copyright © 2019 Harry Patsis. All rights reserved.
//


import Foundation
import Combine

public class CommentViewModel: ObservableObject {
  @Published var comments: Comments = []

  private var cancellable: AnyCancellable?
    
  func load() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments/") else {
      return
    }
    
    self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .decode(type: Comments.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .replaceError(with: [])
      .eraseToAnyPublisher()
      .assign(to: \.comments, on: self)
//      .sink(receiveCompletion: { completion in
//        switch completion {
//        case .finished:
//          break
//        case .failure(let error):
//          fatalError(error.localizedDescription)
//        }
//      }, receiveValue: { comments in
//        DispatchQueue.main.async {
//          self.comments = comments
//        }
//      })
  }
}

