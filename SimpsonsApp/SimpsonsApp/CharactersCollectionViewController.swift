//
//  CharactersCollectionViewController.swift
//  SimpsonsApp
//
//  Created by Grecia Escárcega on 14/09/20.
//  Copyright © 2020 GEM. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CharactersCollectionViewController: UICollectionViewController {
    
    var list = [Quote]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getQuotes()
        title = "Quotes list"
    }

    override func viewWillLayoutSubviews() {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout{
            if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeRight {
                flowLayout.scrollDirection = .horizontal
            } else {
                flowLayout.scrollDirection = .vertical
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeRight {
            return list.count
        } else {
            return 10
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        if list.count >= 10 {
            cell.nameLabel.text = list[indexPath.row].character
            cell.imageView.image = list[indexPath.row].downloadedImage
        }
        return cell
    }

    // MARK: UICollectionViewDelegate
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = self.storyboard!
        let viewController = storyboard.instantiateViewController(identifier: "DetailVC") as DetailViewController
        viewController.quote = list[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeRight {
            return CGSize(width: collectionView.frame.width * 0.30, height: collectionView.frame.height * 0.25)
        } else {
            return CGSize(width: collectionView.frame.width * 0.90, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeRight {
            return collectionView.frame.width * 0.03
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeLeft || UIApplication.shared.windows.first?.windowScene?.interfaceOrientation == UIInterfaceOrientation.landscapeRight {
            return collectionView.frame.height * 0.06
        } else {
            return 20
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
        collectionView.reloadData()
    }

}

extension CharactersCollectionViewController {
    func getQuotes() {
        QuotesAPI.get(){ (result) in
            if let result = result {
                self.list = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                print("couldnt get list")
            }
        }
    }
}
