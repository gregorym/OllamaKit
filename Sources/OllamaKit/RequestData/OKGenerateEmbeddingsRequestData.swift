//
//  OKGenerateEmbeddingsRequestData.swift
//
//
//  Created by Paul Thrasher on 02/09/24.
//

import Foundation

/// A structure that encapsulates the data required for generating embeddings using the Ollama API.
public struct OKGenerateEmbeddingsRequestData: Encodable {
    /// A string representing the identifier of the model.
    public let model: String
    
    /// A list of strings containing the initial input or prompt.
    public let input: [String]
    
    /// Optional ``OKCompletionOptions`` providing additional configuration for the generation request.
    public var options: OKCompletionOptions?
    
    /// Optionally control how long the model will stay loaded into memory following the request (default: 5m)
    public var keep_alive: String?
    
    public init(model: String, input: [String]) {
        self.model = model
        self.input = input
    }
}
