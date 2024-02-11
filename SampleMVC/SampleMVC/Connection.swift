//
//  Connection.swift
//  SampleMVC
//
//  Created by Sandipan Roy Chowdhury on 06/02/24.
//

import Foundation
import UIKit

func downloadImageAsynchronously(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        // Check for errors
        if let error = error {
            print("Error downloading image: \(error)")
            completion(nil)
            return
        }
        
        // Check for response status
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Invalid response: \(String(describing: response))")
            completion(nil)
            return
        }
        
        // Check if data is available
        guard let imageData = data else {
            print("No data received")
            completion(nil)
            return
        }
        
        // Convert data to UIImage
        if let image = UIImage(data: imageData) {
            completion(image)
        } else {
            print("Invalid image data")
            completion(nil)
        }
    }.resume()
}
