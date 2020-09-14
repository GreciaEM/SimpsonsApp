//
//  Quote.swift
//  SimpsonsApp
//
//  Created by Grecia Escárcega on 14/09/20.
//  Copyright © 2020 GEM. All rights reserved.
//

import UIKit

struct Quote: Codable {
    var quote, character: String?
    var image: String?
    var downloadedImage: UIImage? {
        return try? UIImage(data: Data(contentsOf: URL(string: image ?? "")!))
    }
}
