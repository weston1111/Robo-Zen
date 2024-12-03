// In NetworkManager.swift
func sendCoordinates(_ coordinates: [CoordinateEntry], completion: @escaping (Result<Void, Error>) -> Void) {
    guard let url = URL(string: "\(baseURL)/receive-coordinates") else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    do {
        let jsonData = try JSONEncoder().encode(coordinates)
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    } catch {
        completion(.failure(error))
    }
}

// Add this struct to the file or in a separate file
struct CoordinateEntry: Codable {
    let x: Double
    let y: Double
    let timestamp: String?
    
    init(x: Double, y: Double, timestamp: String? = nil) {
        self.x = x
        self.y = y
        self.timestamp = timestamp ?? ISO8601DateFormatter().string(from: Date())
    }
}
