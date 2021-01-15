//
//  CustomAvatarImageView.swift
//  GHFollowers
//
//  Created by Дмитрий Папушин on 05.05.2020.
//  Copyright © 2020 Дмитрий Папушин. All rights reserved.
//

import UIKit

class CustomAvatarImageView: UIImageView {
    
    // MARK: - Properties
    
    let cache = NetworkManager.shared.cache
    
    let placeholderImage = #imageLiteral(resourceName: "avatar-placeholder").withRenderingMode(.alwaysOriginal)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - Setup the UIimageView properties
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        //translatesAutoresizingMaskIntoConstraints = true
    }
    
    // MARK: - Download image from URL
    
    func downloadImage(from urlString: String) {
        
        // MARK: - Check for cache
        
        let cacheKye = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKye) {
            self.image = image
            return
        }
        
        //MARK: - Set image and get to cache
        
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else {return}
            self.cache.setObject(image, forKey: cacheKye)
            DispatchQueue.main.async {self.image = image}
        }
        
        task.resume()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
