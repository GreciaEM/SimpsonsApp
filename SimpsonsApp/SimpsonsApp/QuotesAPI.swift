//
//  QuotesAPI.swift
//  SimpsonsApp
//
//  Created by Grecia Escárcega on 14/09/20.
//  Copyright © 2020 GEM. All rights reserved.
//

import Alamofire

struct QuotesAPI {
    static func get(callback: @escaping ([Quote]?) -> Void) {
        AF.request("https://thesimpsonsquoteapi.glitch.me/quotes?count=20").responseDecodable(of: [Quote].self) { (response) in
            callback(response.value)
        }
    }
}
