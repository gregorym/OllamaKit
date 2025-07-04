//
//  OKGenerateEmbeddingsResponse.swift
//
//
//  Created by Paul Thrasher on 02/09/24.
//

import Foundation

/// A structure that represents the response to an embedding request from the Ollama API.
public struct OKGenerateEmbeddingsResponse: Decodable {
    
    /// An array of floats representing the embeddings of the input prompt.
    public let embeddings: [[Float]]?
}
