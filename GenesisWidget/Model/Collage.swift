//
//  Collage.swift
//  GenesisWidget
//
//  Created by Максим Шаптала on 28.12.2020.
//

import UIKit

struct Collage: Codable {
    
    enum CodingKeys: String, CodingKey {
        case image1
        case image2
        case image3
        case image4
      }
    
    var images: [Int: UIImage?] = [:]
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        if let image1Data = try? container?.decode(Data.self, forKey: .image1), let image1 = UIImage(data: image1Data) {
            images[0] = image1
        }
        if let image2Data = try? container?.decode(Data.self, forKey: .image2), let image2 = UIImage(data: image2Data) {
            images[1] = image2
        }
        if let image3Data = try? container?.decode(Data.self, forKey: .image3), let image3 = UIImage(data: image3Data) {
            images[2] = image3
        }
        if let image4Data = try? container?.decode(Data.self, forKey: .image4), let image4 = UIImage(data: image4Data) {
            images[3] = image4
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let data1 = images[0]?.flatMap({$0})?.jpegData(compressionQuality: 0.5) {
            try? container.encode(data1, forKey: .image1)
        }
        if let data2 = images[1]?.flatMap({$0})?.jpegData(compressionQuality: 0.5) {
            try? container.encode(data2, forKey: .image2)
        }
        if let data3 = images[2]?.flatMap({$0})?.jpegData(compressionQuality: 0.5) {
            try? container.encode(data3, forKey: .image3)
        }
        if let data4 = images[3]?.flatMap({$0})?.jpegData(compressionQuality: 0.5) {
            try? container.encode(data4, forKey: .image4)
        }
        
    }
}
