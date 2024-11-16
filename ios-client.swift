import Foundation

class RaspberryPiClient {
    private let baseURL: String
    
    init(ipAddress: String, port: Int = 5000) {
        self.baseURL = "http://\(ipAddress):\(port)/api"
    }
    
    func sendData(_ data: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/data") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let responseString = String(data: data, encoding: .utf8) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            completion(.success(responseString))
        }.resume()
    }
    
    func getData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/data") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(json))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
}
