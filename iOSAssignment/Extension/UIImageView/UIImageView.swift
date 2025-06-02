//
//  UIImageView.swift
//  iOSAssignment
//
//  Created by Mohamed abdelhamed on 02/06/2025.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        // Set placeholder first
        self.image = placeholder
        
        // Validate and create URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }

        // Download image in background
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors or empty data
            if let error = error {
                print("Failed to load image: \(error.localizedDescription)")
                return
            }
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("Invalid image data")
                return
            }

            // Set image on main thread
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }.resume()
    }
}
