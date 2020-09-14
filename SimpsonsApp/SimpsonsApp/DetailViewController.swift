//
//  DetailViewController.swift
//  SimpsonsApp
//
//  Created by Grecia Escárcega on 14/09/20.
//  Copyright © 2020 GEM. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var quote: Quote!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = quote.character
        imageView.image = quote.downloadedImage
        nameLabel.text = quote.character
        descriptionTextView.text = quote.quote
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
